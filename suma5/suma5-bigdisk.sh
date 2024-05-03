#!/bin/bash
# Copyright (c) 2019 SUSE Linux GmbH
#
#
# This script is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License

usage() {
    echo "Usage: $0 <storage-disk-device>"
    echo
    echo "<storage-disk-device> will"
    echo "be used for both file and data base storage."
    echo
}

case "$1" in
  "-h"|"--help"|"")
    usage
    exit 0
    ;;
esac

export device=$1
partition=${device}p1
    if [ -e $partition ]; then
        echo $partition
        else
        partition=${device}1
        echo $partition
    fi
parted -s $device mklabel GPT
parted -s $device mkpart primary 2048s 100%
mkfs.xfs -f $partition &>/dev/null 
mkdir -p /var/lib/containers/storage/volumes
export uuid=$(blkid -s UUID -o value $partition)
mount UUID=$uuid /var/lib/containers/storage/volumes
echo "UUID=$uuid /var/lib/containers/storage/volumes xfs defaults,nofail 1 2" >> /etc/fstab
echo "SUSE Manager storage is now provisioned to use $partition"
