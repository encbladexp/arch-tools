#!/usr/bin/bash
set -e
echo "Downloading Kernel and initramfs (x86_64)…"
cd /srv/tftp/arch/x86_64/
rm vmlinuz archiso.img
wget http://ftp.uni-bayreuth.de/linux/archlinux/iso/latest/arch/boot/x86_64/vmlinuz
wget http://ftp.uni-bayreuth.de/linux/archlinux/iso/latest/arch/boot/x86_64/archiso.img
echo "Downloading rootfs (x86_64)…"
cd /srv/http/pxe/arch/x86_64/
rm airootfs.*
wget http://ftp.uni-bayreuth.de/linux/archlinux/iso/latest/arch/x86_64/airootfs.md5
wget http://ftp.uni-bayreuth.de/linux/archlinux/iso/latest/arch/x86_64/airootfs.sfs
