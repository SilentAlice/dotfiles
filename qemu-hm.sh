#!/bin/bash

DEBUG_ARGS="-gdb tcp::1234"
ENABLE_NUMA=0
KERNEL_FILE="bootimage.elf"
EXTRA_ARGS=""
CPU_TYPE="cortex-a53"
CPU_NUM="4"
GIC_VERSION=3
QEMU_VERSION_REQUIRED=""

## Args parsing
while [ $# -gt 0 ]; do
    case ".$1" in
        ".--no-debug") DEBUG_ARGS="" ;;
        ".--numa") ENABLE_NUMA=1 ;;
        ".--gicv2") GIC_VERSION=2 ;;
        # RTOS scenario use image without elf header, indicate dtb and initrd
        ".--rtos")
        KERNEL_FILE="Image"
        EXTRA_ARGS="-dtb virt-rtos.dtb -initrd rootfs.cpio"
        ;;
        # Test scenario use newer features
        ".--test")
        KERNEL_FILE="Image"
        EXTRA_ARGS="-dtb virt-new.dtb -initd rootfs.cpio"
        CPU_TYPE="cortex-a76" # cortex-a76 supports aarch64 v8.1 features (e.g. VHE)
        CPU_NUM="8"
        QEMU_VERSION_REQUIRED="7.2.0"
        ;;
        # Running in el2 as hypervisor
        ".--hyp")
        VM_IMAGE="PATH/TO/VM/IMAGE"
        ;;
        # "--" means pass all remaining args to qemu
        ".--")
        shift; break ;;
    *) break ;;
    esac
    shift
done

# Reset positional parameters
# set -- "${POSITIONAL[@]}"

function version_sort() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1"; }
function check_qemu_version() {
    if [-n $QEMU_VERSION_REQUIRED ]; then
        QEMU_VERSION_LOCAL=$(qemu-system-aarch64 --version | head -n 1 | awk '{print $4}')
        if version_sort "$QEMU_VERSION_LOCAL" "$QEMU_VERSION_REQUIRED"; then
            echo "version: $QEMU_VERSION_LOCAL less then required version: $QEMU_VERSION_REQUIRED"
            exit 1
        fi
    fi
}
check_qemu_version

if [ -n ${VM_IMAGE} ]; then
    VM_ARGS="-device loader,file=${VM_IMAGE},addr=0xc0000000,force-raw=true \
        -device virtio-serial \
        -chardev pty,id=guestvm \
        -device virtconsole,chardev=guestvm"
fi

MEM_SIZE_MB=4096
MEM_BACKEND_FILE="/tmp/qemu-memfile.bin"

CPU_ARGS="-cpu ${CPU_TYPE} -smp ${CPU_NUM}"
MEM_ARGS="-m size=${MEM_SIZE_MB}M -object memory-backend-file,share=off,id=memory0,mem-path=${MEM_BACKEND_FILE},size=${MEM_SIZE_MB}M"

function create_mem_image() {
    CREATE_IMAGE_FILE=$1
    if [ ! -f ${CREATE_IMAGE_FILE} ]; then
        # create backend file
        echo "create backend file ${CREATE_IMAGE_FILE} ..."
        dd if=/dev/urandom of=${CREATE_IMAGE_FILE} bs=1M count=$MEM_SIZE_MB
    else
        echo "using existing backend file ${CREATE_IMAGE_FILE}"
    fi
}

function prepare_boot_args() {
    if [ $ENABLE_NUMA -eq 0 ]; then
        create_mem_image $MEM_BACKEND_FILE
    else
        echo "enable numa system 2 nodes"
        CPU_ARGS="${CPU_ARGS},sockets=2"
        MEM_BACKEND_FILE_EXTRA="${MEM_BACKEND_FILE}.extra"
        MEM_SIZE_PER_NODE=2048
        MEM_ARGS="-m size=${MEM_SIZE_MB}M \
            -object memory-backend-file,share-off,id=memory0,mem-path=${MEM_BACKEND_FILE},size=${MEM_SIZE_PER_NODE}M \
            -object memory-backend-file,share-off,id=memory1,mem-path=${MEM_BACKEND_FILE_EXTRA},size=${MEM_SIZE_PER_NODE}M \
            -numa node,memdev=memory0,cpus=0-1,nodeid=0 \
            -numa node,memdev=memory1,cpus=2-3,nodeid=1 \
            -numa dist,src=0,dst=1,val=12"
        create_mem_image $MEM_BACKEND_FILE
        create_mem_image $MEM_BACKEND_FILE_EXTRA
    fi
}
prepare_boot_args

function prepare_tap() {
    ifconfig -a | grep tap_qemu
    if [ $? -ne 0 ]; then
        ip tuntap add dev tap_qemu mod tap
        if [ $? -ne 0 ]; then
            echo "setup tap_qemu failed"
            return 1
        fi
    fi
    return 0
}
prepare_tap
if [ $? -ne 0 ]; then
    echo "tap device not found, create it:"
    echo "ip tuntap add dev tap-qemu mod tap"
    echo "ifconfig tap_qemu 192.168.11.11 netmask 255.255.255.0 up"
    exit 1
fi
NET_ARGS="-netdev tap,id=net-qemu,script=no,downscript=no,ifname=tap_qemu \
    -device virtio-net-device,netdev=net-qemu,\
    mrg_rxbuf=off,csum=off,guest_csum=off,gso=off,\
    guest_tso4=off,guest_tso6=off,guest_ecn=off,guest_ufo=off,\
    ctrl_vlan=off,ctrl_rx=off"

function prepare_vcan() {
    ifconfig -a | grep can-qemu
    if [ $? -ne 0 ]; then
        ip link add dev can-qemu type vcan
        if [ $? -ne 0 ]; then
            echo "setup can_qemu failed"
            return 1
        fi
    fi
    ip link set can-qemu type can bitrate 1000000
    ip link set can-qemu up
    return 0
}
prepare_vcan
CAN_ARGS="-object can-bus,id=canbus0 \
    -device kvaser_pci,canbus=canbus0 \
    -object can-host-socketcan,id=canhost0,if=can-qemu,canbus=canbus0"

function create_device_file() {
    file_path=$(realpath $1)
    size=$2
    info=$3

    if [ -f $file_path ]; then
        echo "using file ${file_path} for ${info}"
        return 0
    fi

    echo "creating file ${file_path} for ${info}"
    dd if=/dev/zero of=${file_path} bs=1M count=${size} 2>/dev/null
    if [ $?? != 0 ]; then
        echo "failed to create file: ${file_path} for ${info}"
        return 1
    fi

    parted ${file_path} --script --mklabel msdos 2>/dev/null
    parted ${file_path} --script --mkpart primary 0 -1 2>/dev/null

    return 0
}

# USB
USB_FILE="usb0.img"
USB_SIZE_MB=32
USB_ARGS="-device usb-ehci,id=ehci \
    -device usb-kbd \
    -device usb-mouse -usb \
    -device usb-serial,chardev=ppp -chardev pty,id=ppp \
    -device qemu-xhci,id=xhci \
    -drive if=none,id=usb0,file=${USB_FILE},format=raw \
    -device usb-storage,bus=ehci.0,drive=usb0"
create_device_file $USB_FILE $USB_SIZE_MB "USB Device"

# SDCard
SDHCI_FILE="sdcard0.img"
SDHCI_SIZE_MB=32
SDHCI_ARGS="-device sdhci-pci \
    -drive if=none,id=sdcard0,file=${SDHCI_FILE},format=raw \
    -device sd-card,drive=sdcard0 "
create_device_file $SDHCI_FILE $SDHCI_SIZE_MB "SDCard Device"

# AHCI
AHCI_FILE="ahci0.img"
AHCI_SIZE_MB=32
AHCI_ARGS="-device ahci,id=ahci \
    -drive if=none,id=ahci0,file=${AHCI_FILE},format=raw \
    -device ide-hd,bus=ahci.0,drive=ahci0"
create_device_file $AHCI_FILE $AHCI_SIZE_MB "AHCI Device"

# VDA
VDA_FILE="vda0.img"
VDA_SIZE_MB=256
VDA_ARGS="-drive if=none,id=vda0,file=${VDA_FILE},format=raw \
    -device virtio-blk-device,drive=vda0"

qemu-system-aarch64 -machine virt,virtualization=true,gic-version=${GIC_VERSION} \
    -nographic \
    ${CPU_ARGS} \
    ${MEM_ARGS} \
    ${DEBUG_ARGS} \
    -kernel ${KERNEL_FILE} ${EXTRA_ARGS} \
    -serial mon:stdio \
    ${NET_ARGS} \
    ${USB_ARGS} \
    ${SDHCI_ARGS} \
    ${AHCI_ARGS} \
    ${CAN_ARGS} \
    ${VM_ARGS} \
    "$@"
