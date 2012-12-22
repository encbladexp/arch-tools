#!/bin/bash
comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort) | pacman -Sf -
comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort) | pacman -S -
