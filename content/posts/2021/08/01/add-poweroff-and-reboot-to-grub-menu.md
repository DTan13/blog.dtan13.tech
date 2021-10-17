---
title: "Add Power Off and Reboot to Grub Menu"
subtitle: ""
date: 2021-08-04T22:43:02+05:30
draft: false
author: "Dhananjay Tanpure"
authorLink: "https://github.com/DTan13"
description: "A Random Necessity!"

tags: ["linux", "grub"]
categories: ["Linux"]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: "/images/2021/08/01/featured-image.jpg"
featuredImagePreview: "/images/2021/08/01/featured-image.jpg"

theme: "wide"

toc:
    enable: true
math:
    enable: false
lightgallery: false
---

This post shows how to add **Power Off** and **Reboot** to grub menu.

<!--more-->

## Introduction

To add **Power Off** and **Reboot** options to grub menu, you need to update a file in your grub configuration directory.

```bash
cd /etc/grub.d
```

### Open **40_custom** in your favorite editor

For me its `micro` :

```bash
micro 40_custom
```

### Add following line at the end of the file

> Do not change the `exec tail` line in the file

```bash

 menuentry "Reboot" {
	  reboot
}

menuentry "Power Off" {
	  halt
}

```

### Update your **grub.cfg** file

-   For Debian based distros

```bash
update-grub
```

-   For Arch based and Other distros

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```
