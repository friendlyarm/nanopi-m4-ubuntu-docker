#!/bin/bash
#
#set -x

DISTRO=$PWD/distro
mkdir -p $DISTRO

rm -f $DISTRO/MiniLoaderAll.bin
rm -f $DISTRO/idbloader.img
rm -f $DISTRO/trust.img
rm -f $DISTRO/uboot.img
rm -f $DISTRO/boot.img

echo -e "\n\e[36m Building boot images \e[0m"
docker build -t rk3399 .
id=$(docker create rk3399)
docker cp $id:/boot.tar $DISTRO/boot.tar
docker rm -fv $id
tar xf $DISTRO/boot.tar -C $DISTRO
rm $DISTRO/boot.tar
sync

echo -e "\n\e[36m Done. \e[0m"
ls $DISTRO -lh
