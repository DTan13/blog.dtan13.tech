---
title: "Add Power Off and Reboot to Grub Menu"
subtitle: ""
date: 2021-08-04T22:43:02+05:30
draft: false
author: "Dhananjay Tanpure"
authorLink: "https://github.com/DTan13"
description: "A Random Necessity!"

tags: ["Linux","Grub"]
categories: ["Linux"]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: "/images/add-poweroff-and-reboot-to-grub-menu/featured-image.jpg"
featuredImagePreview: "/images/add-poweroff-and-reboot-to-grub-menu/featured-image.jpg"

toc:
  enable: true
math:
  enable: false
lightgallery: false
---
This post shows how to add **Power Off** and **Reboot** to grub menu.
<!--more-->
---
## Introduction

To add **Power Off** and **Reboot** options to grub menu, you need to update a file in your grub configuration directory.

<br>

```bash
cd /etc/grub.d
```

<br>

### Open `40_custom` in your favorite editor

For me its `micro`:

<br>

```bash
micro 40_custom
```

<br>

### Add following line at the end of the file

<br>

```bash

 menuentry "Reboot" {
	  reboot
}

menuentry "Power Off" {
	  halt
}

```

> Do not change the ```exec tail``` line in the file

<br>

### Update your `grub.cfg` file

<br>

  - For Debian based distros

  ```bash 
  update-grub
  ```

  - For Arch based and Other distros

  ```bash
  grub-mkconfig -o /boot/grub/grub.cfg
  ```
