#!/bin/bash
grub-install --directory=/usr/lib/grub/x86_64-efi --target=x86_64-efi --root-directory=/boot/efi --boot-directory=/boot --bootloader-id=arch_grub --recheck
