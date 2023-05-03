qemu-system-x86_64 -serial stdio -m 4096 -smp 6 -net nic -net user,hostfwd=tcp::10022-:22 $1
