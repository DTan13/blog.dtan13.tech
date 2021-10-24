---
title: "Understanding Colors and Styles in Terminal"
subtitle: "Life is really bland without colors, doesn't it?"
date: 2021-10-22T00:14:48+05:30
draft: false

author: "Dhananjay Tanpure"
authorLink: "https://github.com/DTan13"
authorComment: ""
description: "This post shows how to easily print colored text and styles to terminal."

tags: ["colors", "shell", "terminal", "bash", "linux"]
categories: ["Terminal", "Linux"]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: "/images/2021/10/01/featured-image.png"
featuredImagePreview: "/images/2021/10/01/featured-image.png"

theme: "wide"

toc:
    enable: true
math:
    enable: false
lightgallery: false
---

<!-- Add Summary Here -->

Learn to easily print colored text and styles in terminal.

<!--more-->

While using commands like **htop** or learning **Node.JS**, you might have come across colored and animated text in terminal. In this article we will have a deeper look at making your terminal and CLI script colorful.

## Introduction

There are many popular libraries providing a way to output colored text in terminal like **chalk** for **Node.JS** and **coloured** for **Python**. Before trying to understand on our own let's see how these libraries are doing it.

### chalk(ansi-styles)

The famous [**chalk**](https://github.com/chalk/chalk) library in turn depends on [**ansi-styles**](https://github.com/chalk/ansi-styles). Getting a little deeper in [**code**](https://github.com/chalk/ansi-styles/blob/main/index.js) on github you will come across these [lines](https://github.com/chalk/ansi-styles/blob/main/index.js#L1) :

```js
const wrapAnsi16 =
    (offset = 0) =>
    (code) =>
        `\u001B[${code + offset}m`;

const wrapAnsi256 =
    (offset = 0) =>
    (code) =>
        `\u001B[${38 + offset};5;${code}m`;

const wrapAnsi16m =
    (offset = 0) =>
    (red, green, blue) =>
        `\u001B[${38 + offset};2;${red};${green};${blue}m`;
```

Let it be there and take a look at another library.

### colored

[**Colored**](https://gitlab.com/dslackw/colored) is also a popular python module to output colored output on terminal. If we took a quick look at the code we will come across these [lines](https://gitlab.com/dslackw/colored/-/blob/master/colored/colored.py#L15):

```py
class colored(object):

    def __init__(self, color):

        self.ESC = "\x1b["
        self.END = "m"
        self.color = color
        self.enable_windows_terminal_mode()
```

This are not the entire codes but these codes does not look very fancy and complicated at all and did you noticed something common?

## Escape Sequences

Both codes for two different libraries have two things in common, **1B[** and **m**.

Here **1B** is a [ASCII Escape Character](https://en.wikipedia.org/wiki/Escape_character#ASCII_escape_character) presented either in unicode(**\u001B**) and hexadecimal(**\x1B**) form. The **[** (open square bracket) along with **1B** (escape) is also known as [**Control Sequence Introducer**](https://en.wikipedia.org/w/index.php?title=Control_Sequence_Introducer&redirect=no). CSI along with a **color code** (ex. for red, 31 => **\x1B[31m**) creates an **Escape Sequence**. Here **\x1B[31m** is treated as a independent escape sequence which signals terminal to change the color of the output after **m** to **Red** and similarly for **\x1B[32m** to **Green**. See [More colors](#more-colors) section below for other colors.

> Escape sequences are used to signal as an alternative interpretation of a series of characters. Just like **\t** is interpreted as a **tab**.

These escape sequences working with only colors are known as **ASCII escape code** and are standardized. And therefore they work everywhere.

### Escape Character

Although in above example **\x1B** is used as a escape character, we can use any one of the following :

-   **\x1B**
-   **\u001B**
-   **\033**
-   **\e**

## Trying out colors

You can use any modern terminal and any programming language to output color.

### Linux and MacOS

So lets write red **Hello World!**

> **echo** is just used to print text in terminal. You can use **printf**.

```bash
echo "\x1B[31mHello World\!"

#or

echo "\u001B[31mHello World\!"

# or

echo "\033[31mHello World\!"

#or

echo "\e[31mHello World\!"
```

All these commands results in same output :
<br>
{{< style "color:#ff0000" >}}Hello World!{{< /style >}}

For further article I am using **\e** for simplicity. But remember that **\e** might not work with programming languages.

### Windows

For versions before Windows 10, the Windows command prompt does not support output coloring by default. You could install either [Cmder](https://cmder.net/), [ConEmu](https://conemu.github.io/) or [Mintty](https://mintty.github.io/) to add coloring support to your Windows command console.

It turns out that the support was added after Windows 10 build 16257. You can see [this stackoverflow question](https://superuser.com/questions/413073/windows-console-with-ansi-colors-handling) for further steps and [add color to powershell](https://practicalpowershell.com/add-a-bit-of-color-to-powershell/).

## Programming Languages

In above example **echo** is used for printing out text to terminal. You can also use above expression with code in any programming language like **python**, **js** and **c++**.

Fire up python IDLE or Node REPL, and with type following code :

```py
print("\x1B[31mHello World\!")
```

OR

```js
console.log("\x1B[31mHello World!");
```

You will get the usual output :
<br>
{{< style "color:#ff0000" >}}Hello World!{{< /style >}}

> **\e** might not work with programming languages.

## More Colors

For more colors you can try changing **31** to something else.

### Foreground(Text color)

For foreground we have folllowing options :

```bash
echo "\e[${Code}mHello World\!"

# example

echo "\e[35mHii There\!"
```

| Color   | Code |                         Output                          |
| :------ | :--: | :-----------------------------------------------------: |
| Black   |  30  | {{< style "color:#000000" >}}Hello World!{{< /style >}} |
| Red     |  31  | {{< style "color:#ff0000" >}}Hello World!{{< /style >}} |
| Green   |  32  | {{< style "color:#00ff00" >}}Hello World!{{< /style >}} |
| Yellow  |  33  | {{< style "color:#ffff00" >}}Hello World!{{< /style >}} |
| Blue    |  34  | {{< style "color:#0000ff" >}}Hello World!{{< /style >}} |
| Magenta |  35  | {{< style "color:#ff00ff" >}}Hello World!{{< /style >}} |
| Cyan    |  36  | {{< style "color:#00ffff" >}}Hello World!{{< /style >}} |
| White   |  37  | {{< style "color:#ffffff" >}}Hello World!{{< /style >}} |
| Default |  39  | {{< style "color:#ffffff" >}}Hello World!{{< /style >}} |

> I have considered **Default** as White.

### Background

For background we have folllowing options :

```bash
echo "\e[${Code}mHello World\!"

# example

echo "\e[45mHii There\!"
```

| Color   | Code |                               Output                               |
| :------ | :--: | :----------------------------------------------------------------: |
| Black   |  40  | {{< style "background-color:#000000" >}}Hello World!{{< /style >}} |
| Red     |  41  | {{< style "background-color:#ff0000" >}}Hello World!{{< /style >}} |
| Green   |  42  | {{< style "background-color:#00ff00" >}}Hello World!{{< /style >}} |
| Yellow  |  43  | {{< style "background-color:#ffff00" >}}Hello World!{{< /style >}} |
| Blue    |  44  | {{< style "background-color:#0000ff" >}}Hello World!{{< /style >}} |
| Magenta |  45  | {{< style "background-color:#ff00ff" >}}Hello World!{{< /style >}} |
| Cyan    |  46  | {{< style "background-color:#00ffff" >}}Hello World!{{< /style >}} |
| White   |  47  | {{< style "background-color:#ffffff" >}}Hello World!{{< /style >}} |
| Default |  49  |                            Hello World!                            |

## Custom colors using **RGB**

### Forground

The format for setting up custom foreground colors using RGB values :

```bash
echo "\e[38:2:${R_value}:${G_value}:${B_value}mHello World\!"
```

For example

```bash
echo "\e[38:2:247:7:59mHello World\!"
```

Output :
{{< style "color:#f7073b" >}}Hello World!{{< /style >}}

### Background

The format for setting up custom background colors using RGB values :

```bash
echo "\e[48:2:${R_value}:${G_value}:${B_value}mHello World\!"
```

For example

```bash
echo "\e[48:2:247:7:59mHello World\!"
```

Output :
{{< style "background-color:#f7073b;max-width:fit-content" >}}Hello World!{{< /style >}}

## Styles

There are some styles like

-   {{< style "text-decoration:underline" >}}underline{{</style>}}
-   **bold**
-   _italics_

The format for applying styles is same as for colors,

```bash
echo "\e[${code}mHello World\!"
```

For example :

```bash
echo "\e[4mHello World\!"
```

Output :
{{< style "text-decoration:underline" >}}Hello World!{{< /style >}}

| Color            | Code |                                                               Output                                                               |
| :--------------- | :--: | :--------------------------------------------------------------------------------------------------------------------------------: |
| Normal (default) |  0   |                                                            Hello World!                                                            |
| Bold             |  1   |                                     {{< style "font-weight:bold" >}}Hello World!{{< /style >}}                                     |
| Faint            |  2   |                                   {{< style "font-weight:lighter" >}}Hello World!{{< /style >}}                                    |
| Italics          |  3   |                                    {{< style "font-style:italic" >}}Hello World!{{< /style >}}                                     |
| Underline        |  4   |                                {{< style "text-decoration:underline" >}}Hello World!{{< /style >}}                                 |
| Blink            |  5   |                                              <span class="blink">Hello World!</span>                                               |
| Inverse          |  7   | {{< style "background:black;filter: invert(100%);width:fit-content;text-align:center;margin: 0 auto" >}}Hello World!{{< /style >}} |
| Invisible        |  8   |                                        {{< style "display: none">}}Hello World!{{</style>}}                                        |
| Strikethrough    |  9   |                                {{< style "text-decoration: line-through">}}Hello World!{{</style>}}                                |
| Double Underline |  21  |               {{< style "text-decoration-line: underline;text-decoration-style: double;">}}Hello World!{{</style>}}                |

## Complex Styles

For more complex styles you can add multiple styles to make a new one. Some simle examples:
| Expression | Result |
|:----|:----:|
| **echo "\e[42m\e[31m\e[5mError\!"** | {{< style "background:lightgreen;width: fit-content;color:red">}}<span class="blink">Error!</span>{{</ style>}}|
| **echo "\e[31mLine 43:21 : \e[33mWARN\e[0m Problem"** |{{< style "color: red">}}Line 43:21 :{{</ style >}} {{< style "color: yellow">}}WARN {{</ style >}} Problem |

Just understand the `\` after `m` in some cases.

## Problems

### Linux

-   If colors are not rendering properly you should check the value of shell variable **$TERM**. If it is something other them **xterm** or **xterm-256color**, set it to **xterm-256color** in your **~/.bashrc** or **~/.zshrc**.

```bash
export TERM=xterm-256color
```

<br/>

**If you have any problem. Let me know in the comments section.**

<!-- Custom CSS -->

<style>
@keyframes blinking {
    0% {
        opacity: 1
    }
    100% {
        opacity: 0
    }
    }
    .blink {
    animation: blinking 1s infinite;
    }
</style>
