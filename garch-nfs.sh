#!/bin/bash
# Setup Script for a mostly German Arch Linux Installation (NFS Cache Edition)
echo "Mounting Network Cache..."
mkdir -p /mnt/var/cache/pacman/pkg
mkdir -p /var/cache/pacman/pkg
mount server:/pacman /mnt/var/cache/pacman/pkg
mount server:/pacman /var/cache/pacman/pkg
echo "...done"
echo "Installation Editor..."
pacman -Sy
pacman --noconfirm -S vim
echo "...done"
echo "Bootstrapping Base System..."
pacstrap /mnt base base-devel vim bash-completion htop grub-bios sudo nfs-utils
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
echo "Editor session..."
vim /mnt/etc/rc.conf
vim /mnt/etc/mkinitcpio.conf
vim /mnt/etc/default/grub
vim /mnt/etc/locale.gen
vim /mnt/etc/hostname
echo "...done"
echo "Chroot session..."
cat > /mnt/garch-setup << EOF
#!/bin/bash
pacman -R vi nano
ln -s /usr/bin/vim /usr/bin/nano
ln -s /usr/bin/vim /usr/bin/vi
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
locale-gen
mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg
grub-install /dev/sda
passwd
EOF
chmod 0755 /mnt/garch-setup
arch-chroot /mnt /garch-setup
echo "...done"
echo "Time for reboot: NOW ;-)"
