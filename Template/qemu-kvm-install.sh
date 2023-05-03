qemu-system-x86_64 \
	-serial stdio \
	-machine type=pc,accel=kvm \
	-m 8192 \
	-smp 6 \
	-serial stdio \
	-net nic \
	-cdrom $2 \
	-net user,hostfwd=tcp::10022-:22 $1
