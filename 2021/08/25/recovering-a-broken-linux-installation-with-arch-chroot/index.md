# Recovering a Broken Linux Installation With Chroot


<!-- Add Summary Here -->

How to use **chroot** to recover broken linux installation.

<!--more-->

---

## Introduction

**Chroot** is a method of focusing on a part of your filesystem. This changes apparent root directory. Which gives asscess to root filesystem and root access in order to perform various operations on the system.
Some of which include

1. Recovering a broken install (Reinstalling the bootloader)
2. Upgrading and Downgrading packages
3. Resetting a forgotten passsword
4. Fix your /etc/fstab

---

### Problem

Sometimes during dual boot, due to a **Windows Update** or a **BIOS Update**, It may happen that you are left with the default bios options which has **Legacy Boot** mode and you only have windows as a option to boot.

In this case the data in our linux partitions is safe but you cant access it directly. In order to gain access to the system you need to resintall GRUB.

---

## Procedure

You need to access your broken installation in order to fix it.

<br>

### Boot

1. You need to grab the **Arch Linux ISO** from [Website](https://archlinux.org/download/).
2. Make a bootable USB Drive.
3. Make sure to boot into UEFI mode.
4. Boot into archlinux.
5. Match the architecture of the system you are booted in with the system you wish to enter.
    > `uname -r` Most probably this will be`x86_64`.
6. Enable Swap if needed.
    > `swapon /path/to/swapfile`

<br>

### Mount

**chroot** is all about the root file filesystem `/`. You need to mount the partition before performing `chroot`.

<br>

**Check the location and filetype of the your disk.**

<br>

```bash
fdisk -l
```

Output in my case is :

```bash
Disk /dev/sda: 1.82 TiB, 2000398934016 bytes, 3907029168 sectors
Disk model: ST2000LM007-1R81
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt

Device          Start        End    Sectors   Size Type
/dev/sda1        2048     526335     524288   256M Linux filesystem
/dev/sda2      526336  419956735  419430400   200G Linux filesystem
/dev/sda3   419956736 3277883391 2857926656   1.3T Linux filesystem
/dev/sda4  3277883392 3278088191     204800   100M EFI System
/dev/sda5  3278088192 3278120959      32768    16M Microsoft reserved
/dev/sda6  3278120960 3905969269  627848310 299.4G Microsoft basic data
/dev/sda7  3905970176 3907026943    1056768   516M Windows recovery environment
```

In above output :

```bash
/dev/sda2 #root filesystem(/)
/dev/sda3 #home (/home)
/dev/sda1 #EFI partition
```

To properly mounting these partitions you need to know the type of partition, You can get this using `blkid` :

```bash
blkid
```

```bash
/dev/sda4: UUID="BEBE-377F" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="b0ce5bc5-5767-4138-ba63-209fd95abbc7"
/dev/sda2: UUID="cb2baa0a-3a81-42a1-9670-6060fabaa27f" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="8b7aaeab-1bcb-cf43-8b5d-785fbc5c63a1"
/dev/sda7: BLOCK_SIZE="512" UUID="CAAEBF45AEBF2939" TYPE="ntfs" PARTUUID="ecd471f6-cbd4-4a8a-b70c-54070669939c"
/dev/sda5: PARTLABEL="Microsoft reserved partition" PARTUUID="75d5ffda-1051-47cc-8cba-ae187d2d35d7"
/dev/sda3: UUID="1fe29b19-feb2-4924-b8ac-91a7e4785e98" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="f15d44bb-96f9-0d42-a0f8-4109dd5959b0"
/dev/sda1: UUID="D939-5AD9" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="242f0c5c-5a6c-554c-a2c3-70d6268b835a"
/dev/sda6: BLOCK_SIZE="512" UUID="3AAAC0ADAAC066CB" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="6cfc75a8-c9ee-4239-8cec-2394c0ec5037"
```

You can get type of partition in `TYPE` field.

<br>

**Now mount your partition accordingly on `/mnt`.**

<br>

-   Most important partition is root `/`.
    > Here `-t` is the type of filesystem.

```bash
mount -t ext4 /dev/sda2 /mnt
```

<br>

-   Mount `/home` if necessary

```bash
mount -t ext4 /dev/sda3 /mnt/home
```

<br>

-   Mount other required partitions.
    > These include virtual filesystems required for chroot to run

```bash
for i in /dev /dev/pts /proc /sys /run; do mount -B $i /mnt$i; done
```

<br>

-   If you want to update the GRUB, mount `/sys/firmware/efi/efivars`.

```
mount -B /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars
```

<br>

-   If you've setup your network and want to use it in the chrooted system, copy over `/etc/resolv.conf` so that you'll be able to resolve domain names :

    > `cp -L /etc/resolv.conf /mnt/etc/resolv.conf`

<br>

After all required partitions are mounted you are free to chroot into your `/mnt` directory.

---

### Chroot

Use `chroot` command to move into mounted filesystem.

```bash
chroot /mnt /bin/bash
```

-   If you'll be doing anything with GRUB, you'll need to be sure your `/etc/mtab` file is up-to-date :
    > `grep -v rootfs /proc/mounts > /etc/mtab`

### Work

After a successful `chroot`, You get root access on mounted root(`/`) filesystem. You are free to do anything you want. Like :

-   Upgrade and Downgrade packages.
    > Use your package manager to upgrade or downgrade broken packages.
-   Change a forgotten password.
    > You can use `passwd <username>` to change the password.
-   Fix your `/etc/fstab`.
-   Upgrade or Downgrade kernel.
-   Anything you want to do.

## Recovering broken installation

### Mount

In order to Reinstall the GRUB you need to mount your EFI partition.

```bash
mount -t vfat /dev/sda1 /boot/efi
```

### Run `grub-install`

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck --force --debug
```

After this make sure to unmount your EFI partition.

```bash
umount /boot/efi
```

## Finally

### Unmount

When you are done with your work you can exit `chroot` by typing `exit`.

Now unmount all the partitions you mounted.

```bash
umount -R /mnt
```

If any error occurs, you can use `umount -l` to list all the mounted partitions and unmount remaining partitions.

### Reboot

```bash
reboot
```

