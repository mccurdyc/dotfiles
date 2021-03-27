#!/bin/bash

TOOLS_DIR=$1
mkdir -p $TOOLS_DIR
git clone https://aur.archlinux.org/yay.git ${TOOLS_DIR}/yay
cd ${TOOLS_DIR}/yay
makepkg -si
