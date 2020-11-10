# General steps to install NixOS with the config

1) Boot NixOS iso and connect to internet
2) Use `lsblk` to find the correct device. likely `sda` or `nvme0n1`
3) `sgdisk --zap-all <disk>` -> THIS MURDERS THINGS!
4) Use `ls -l /dev/disk/by-id/` to find the correct device id
5) `DISK=/dev/disk/by-id/<id>`
6) Create boot partition with `sgdisk -n 0:0:+1GiB -t 0:EF00 -c 0:boot $DISK`
7) Create swap partition with `sgdisk -n 0:0:+20GiB -t 0:8200 -c 0:swap $DISK`. You likely want the size to be at least 2x ram for hibernate. Because of ZRam, potentially you could be using much more ram.
8) Create ZFS partition with `sgdisk -n 0:0:0 -t 0:BF01 -c 0:ZFS $DISK`
9) Save new variables with `BOOT=$DISK-part1;SWAP=$DISK-part2;ZFS=$DISK-part3`
10) Set pool name variable `PNAME=<name>`
11) Create zpool with `zpool create -o ashift=12 -O mountpoint=none -O atime=off -O compression=lz4 -O xattr=sa -O acltype=posixacl -o altroot="/mnt" $PNAME $ZFS`
12) Create datasets with
```
zfs create -o mountpoint=none $PNAME/local
zfs create -o mountpoint=none $PNAME/safe
zfs create -o mountpoint=legacy $PNAME/local/root
zfs create -o mountpoint=legacy $PNAME/local/var
zfs create -o mountpoint=legacy $PNAME/local/nix
zfs create -o mountpoint=legacy $PNAME/safe/home
zfs create -o mountpoint=legacy $PNAME/safe/nixconfig
zfs create -o refreservation=1G -o mountpoint=none $PNAME/reserved
```
12) Play with recordsize if you want with `zfs set recordsize=32k $PNAME`
13) Enable snapshots for safe with `zfs set com.sun:auto-snapshot=true $PNAME/safe`
14) Allow send and snapshots from user `zfs allow -u bren077s hold,snapshot,send NotTim`
15) Enable trim with `zfs set autotrim=on $PNAME`
16) Mount everything zfs with
```
mount -t zfs $PNAME/local/root /mnt
mkdir /mnt/var
mount -t zfs $PNAME/local/var /mnt/var
mkdir /mnt/nix
mount -t zfs $PNAME/local/nix /mnt/nix
mkdir /mnt/home
mount -t zfs $PNAME/safe/home /mnt/home
mkdir -p /mnt/etc/nixos
mount -t zfs $PNAME/safe/nixconfig /mnt/etc/nixos
```
17) Setup boot with
```
mkfs.vfat $BOOT
mkdir /mnt/boot
mount $BOOT /mnt/boot
```
18) Setup swap with
```
mkswap -L swap $SWAP
swapon $SWAP

```
20) Setup tmpfs with
```
mkdir /mnt/tmp
mount -t tmpfs none /mnt/tmp
```
19) Generate the config with `nixos-generate-config --root /mnt`
20) Double check `/etc/nixos/hardware-configuration.nix` using the referecence `hardware-configuration.nix`
21) Copy over all files except `hardware-configuration.nix`
22) Maybe change the host id to `head -c 8 /etc/machine-id`
23) `nixos-install` and `reboot`
