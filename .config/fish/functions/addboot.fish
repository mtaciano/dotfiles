# Create a boot entry based on the supplied linux version
function addboot -w efibootmgr --description "Create a new bootentry"
    if test -e /boot/vmlinuz-$argv[1]-gentoo-dist && test -e /boot/initramfs-$argv[1]-gentoo-dist.img
        echo "Creating boot entry for kernel version $argv[1]"
        sudo efibootmgr --disk /dev/nvme0n1 --part 1 --create --write-signature --label "Gentoo ZFS Zen 1 Linux $argv AUTO" --loader "vmlinuz-$argv[1]-gentoo-dist" --unicode "root=zfs:AUTO ro clearcpuid=514 rcu_nocbs=0-15 pci=noaer idle=nomwait processor.max_cstate=5 initrd=\\initramfs-$argv[1]-gentoo-dist.img"
        or echo "Failed to create boot entry for kernel version $argv[1], efibootmgr returned $status"
    else
        echo "No kernel installed matches version $argv[1]"
    end
end
