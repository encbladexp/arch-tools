#!/bin/sh
ALL=`pacman -Q | wc -l`
EXPL=`pacman -Qe | wc -l`
LOCAL=`pacman -Qm | wc -l`
NOREQ=`pacman -Qqdt | wc -l`
KERNEL=`uname -r`
GCC=`gcc --version | head -n1 | cut -d " " -f 5`
SETUP=`grep -i 'installed filesystem' /var/log/pacman.log | cut -c 2-17`

echo "$ALL total installed packages."
echo "$EXPL explicitly installed packages."
echo "$LOCAL localy installed packages."
echo "$NOREQ packages installed as dependencies which are no longer needed."
echo "Your system was originally set up $SETUP."
echo "You are using kernel $KERNEL and gcc version $GCC."
