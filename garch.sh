#!/bin/bash
# Quick Setup Script for a mostly German Arch Linux Installation.
# Dangerous at this moment, only run this when you know what you do!!!
exit 1
echo "Disable exisiting LVM Volumes..."
vgchange -an
echo "...done"
echo "Installation Editor..."
#pacman -Sy
pacman --noconfirm -S vim
echo "...done"
echo "Creating Partition Table, LVM and Filesystems..."
parted -s /dev/sda mklabel gpt
parted -s /dev/sda mkpart primary 1M 4M
parted -s /dev/sda set 1 bios_grub on
parted -s /dev/sda mkpart primary 4M 100M
parted -s /dev/sda set 2 boot on
parted -s /dev/sda mkpart primary 100M 100%
parted -s /dev/sda set 3 lvm on
partprobe
pvcreate /dev/sda3
vgcreate main /dev/sda3
lvcreate -L 5G -n root main
mke2fs -t ext4 -L ROOT /dev/main/root
mount /dev/main/root /mnt
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
echo "...done"
echo "Bootstrapping Base System..."
pacstrap -c /mnt base base-devel vim bash-completion htop grub-bios sudo openssh nfs-utils
echo "...done"
echo "Creating default configuration..."
genfstab -L /mnt >> /mnt/etc/fstab
cat > /mnt/etc/hostname << EOF
YOURHOSTNAME
EOF
cat > /mnt/etc/vconsole.conf << EOF
KEYMAP=de-latin1-nodeadkeys
EOF
cat > /mnt/etc/locale.conf << EOF
LANG=en_US.UTF-8
LC_MESSAGES=C
EOF
echo "...done"
echo "Patching config files..."
#- patch mkinitcpio.conf
#- patch locale.gen
#- patch etc/default/grub
echo "...done"
echo "Editor session..."
vim /mnt/etc/mkinitcpio.conf
vim /mnt/etc/default/grub
vim /mnt/etc/locale.gen
vim /mnt/etc/hostname
echo "...done"
echo "Chroot session..."
cat > /mnt/garch-setup << EOF
#!/bin/bash
pacman --noconfirm -R vi nano
ln -s /usr/bin/vim /usr/bin/nano
ln -s /usr/bin/vim /usr/bin/vi
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
locale-gen
mkinitcpio -p linux
passwd
grub-mkconfig -o /boot/grub/grub.cfg
grub-install /dev/sda
EOF
chmod 0755 /mnt/garch-setup
arch-chroot /mnt /garch-setup
rm /mnt/garch-setup
done
echo "...done"
echo "Time for reboot: NOW ;-)"
