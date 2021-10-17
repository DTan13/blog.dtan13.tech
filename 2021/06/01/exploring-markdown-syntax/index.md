# Exploring Markdown Syntax of LoveIt


This post is for exploring markdown syntax, built-in and extended shortcodes of **LoveIt** theme.

<!--more-->

## Introduction

**[Hugo](https://gohugo.io/)** is really a great tool to start a blog.

With hundreads of Clean, Responsive and Simple **[Themes](https://themes.gohugo.io/)**, it makes really easy for anyone to create their own website. These themes are really easy to use so that any one can get started in less 5 minutes.

{{< youtube w7Ft2ymGmfc >}}

## Theme

After Examining nearly all the **[Themes](https://themes.gohugo.io/)**, I selected **[LoveIt](https://hugoloveit.com/)**. It is a beautiful and responsive theme with many other [features](https://github.com/dillonzq/LoveIt#why-choose-loveit).

This theme have good **[Documentation](https://hugoloveit.com/categories/documentation/)**, readable dark-mode, and some awesome CSS animations.

## Exploring Markdown Syntax

The following are most important elements of Markdown. Let's see how they are represented inside LoveIt Theme.

### Headings {#headings}

Headings from `h2` through `h6` are constructed with a `#` for each level :

```markdown
## h2 Heading

### h3 Heading

#### h4 Heading

##### h5 Heading

###### h6 Heading
```

### Comment

Comments should be similar to HTML.

```html
<!--
Just a comment in HTML.
-->
```

Comment below should **NOT** be seen :

<!--
This is invisible!
-->

### Horizontal Rules

In Markdown, you can create a horizontal rule using :

-   `---`: three consecutive dashes
-   `___`: three consecutive underscores
-   `***`: three consecutive asterisks

Output :

---

---

---

### Emphasis

Emphasizing something makes it **different** from the things around it.

#### Bold

**This Word** is bold.

```markdown
**This Word** is bold.
**This Word** is bold.
```

#### Italics

_This Word_ is italic.

```markdown
_This Word_ is italic.
_This Word_ is italic.
```

#### Strikethrough

~~This~~ is strikethrough.

```markdown
~~This~~ is strikethrough.
```

#### Combination

Bold, italics, and strikethrough can be used in combination :

```markdown
**_bold and italics_**
~~**strikethrough and bold**~~
~~_strikethrough and italics_~~
~~**_bold, italics and strikethrough_**~~
```

Output :

**_bold and italics_**

~~**strikethrough and bold**~~

~~_strikethrough and italics_~~

~~**_bold, italics and strikethrough_**~~

### Blockquotes

Add `>` before any text you want to quote :

```markdown
> This is a **Blockquote**.
```

Output :

> This is a **Blockquote**.

This can also be nested :

```markdown
> This is a **Blockquote**.
>
> > This is a Nested Blockquote.
```

Output :

> This is a **Blockquote**.
>
> > This is a Nested Blockquote.

### Lists

#### Unordered

One of the following symbol will work :

```markdown
-   List Item

*   List Item

-   List Item
```

For example :

```markdown
-   List
    -   Ordered
    -   Unordered
    -   Tasked
-   Code
    -   Inline
    -   Indented
    -   Block Fenced
    -   Syntax Highlighting
```

Output :

-   List
    -   Ordered
    -   Unordered
    -   Tasked
-   Code
    -   Inline
    -   Indented
    -   Block Fenced
    -   Syntax Highlighting

#### Ordered

```markdown
1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa
4. Facilisis in pretium nisl aliquet
5. Nulla volutpat aliquam velit
6. Faucibus porta lacus fringilla vel
7. Aenean sit amet erat nunc
8. Eget porttitor lorem
```

Output :

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa
4. Facilisis in pretium nisl aliquet
5. Nulla volutpat aliquam velit
6. Faucibus porta lacus fringilla vel
7. Aenean sit amet erat nunc
8. Eget porttitor lorem

{{< admonition tip >}}
:(far fa-bookmark fa-fw): Only using `1.` place of every digit will also work!

> See the last two.
> {{< /admonition >}}

#### Task Lists

A list of items with checkboxes :

-   Unchecked Task
    -   `[ ]`
-   Checked Task
    -   `[x]`

For example :

```markdown
-   [x] Task one
-   [ ] Task two
```

Output:

-   [x] Task one
-   [ ] Task two

### Code

#### Inline Code

Wrap inline snippets of code with <code>`</code>.

```markdown
In this example, `<section></section>` should be wrapped as **code**.
```

Output :

In this example, `<section></section>` should be wrapped as **code**.

#### Indented Code

Indenting several lines of code by at least four spaces :

```markdown
    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code
```

Output :

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code

#### Block Fenced Code

Use "fences" <code>```</code> to block in multiple lines of code with a language attribute.

{{< highlight markdown >}}

```markdown
Sample text here...
```

{{< / highlight >}}

#### Syntax Highlighting

To activate it, simply add the file extension of the language you want to use directly after the first code "fence",
<code>```go</code>, and syntax highlighting will automatically be applied in the rendered HTML.

For example :

```go
package main

import (
	"fmt"
	"sync"
)

func main() {
	defer fmt.Println("About to exit!")
	fmt.Println("Started")

	channels := make([]chan int, 5)
	fanInChan := make(chan int)

	go send(channels)
	go recive(fanInChan, channels)

	for val := range fanInChan {
		fmt.Println("Fanin", val)
	}
}
func send(channels []chan int) {
	defer fmt.Println("Send Ended")
	fmt.Println("Send Started")

	for i := 0; i < 100; i++ {
		channels[i%5] <- i
	}

	for i := 0; i < 5; i++ {
		close(channels[i])
	}
}

func recive(fanin chan<- int, channels []chan int) {
	defer fmt.Println("Recive Ended")
	fmt.Println("Recive Started")

	var wg sync.WaitGroup
	wg.Add(5)

	for i := 0; i < 5; i++ {
		go func(inew int) {
			defer wg.Done()
			fmt.Println(inew)
			for v := range channels[inew] {
				fanin <- v
			}
		}(i)
	}

	wg.Wait()
	close(fanin)
}
```

### Tables

Tables are created by adding `pipes`**|** as dividers between each cell, and by adding a line of `dashes`**-** beneath the header. Note that the pipes do not need to be vertically aligned.

For Example :

```markdown
| Digit | Cardinal Default | Cardinal Left | Cardinal Right |
| :---: | ---------------- | :------------ | -------------: |
|   1   | One              | One           |            One |
|   2   | Two              | Two           |            Two |
|   3   | Three            | Three         |          Three |
|   4   | Four             | Four          |           Four |
|   5   | Five             | Five          |           Five |
```

Output :

| Digit | Cardinal Default | Cardinal Left | Cardinal Right |
| :---: | ---------------- | :------------ | -------------: |
|   1   | One              | One           |            One |
|   2   | Two              | Two           |            Two |
|   3   | Three            | Three         |          Three |
|   4   | Four             | Four          |           Four |
|   5   | Five             | Five          |           Five |

> -   Adding a colon on the right side of the dashes below any heading will right align text for that column.
> -   Adding a colon on the left side of the dashes below any heading will left align text for that column.
> -   Adding colons on both sides of the dashes below any heading will center align text for that column.

### Links

#### Basic Link

```markdown
<https://gohugo.io>
<contact@revolunet.com>
[GuHugo](https://gohugo.io)
```

Output :

<https://gohugo.io>

<contact@revolunet.com>

[GoHugo](https://gohugo.io)

Hover over the link, there is no tooltip.

#### Add a Title

```markdown
[DTan13](https://github.com/DTan13/ "Visit Me!")
```

Output :

[DTan13](https://github.com/DTan13/ "Visit Me!")

Hover over the link, there should be a tooltip.

#### Named Anchors

Named anchors enable you to jump to the specified anchor point on the same page. For example, each of these chapters :

```markdown
## Table of Contents

-   [Chapter 1](#chapter-1)
-   [Chapter 2](#chapter-2)
-   [Chapter 3](#chapter-3)
```

Will jump to these sections :

```markdown
## Chapter 1 <a id="chapter-1"></a>

Content for chapter one.

## Chapter 2 <a id="chapter-2"></a>

Content for chapter one.

## Chapter 3 <a id="chapter-3"></a>

Content for chapter one.
```

{{< admonition >}}
The specific placement of the anchor tag seems to be arbitrary. They are placed inline here since it seems to be unobtrusive, and it works.
{{< /admonition >}}

### Footnotes

Footnotes allow you to add notes and references without cluttering the body of the document. When you create a footnote, a superscript number with a link appears where you added the footnote reference. Readers can click the link to jump to the content of the footnote at the bottom of the page.

To create a footnote reference, add a caret and an identifier inside brackets (`[^1]`). Identifiers can be numbers or words, but they can’t contain spaces or tabs. Identifiers only correlate the footnote reference with the footnote itself — in the output, footnotes are numbered sequentially.

Add the footnote using another caret and number inside brackets with a colon and text (`[^1]: My footnote.`). You don’t have to put footnotes at the end of the document. You can put them anywhere except inside other elements like lists, block quotes, and tables.

```markdown
This is a digital footnote[^1].
This is a footnote with "label"[^label]

[^1]: This is a digital footnote
[^label]: This is a footnote with "label"
```

This is a digital footnote[^1].

This is a footnote with "label"[^label]

[^1]: This is a digital footnote
[^label]: This is a footnote with "label"

### Images

Images have a similar syntax to links but include a preceding exclamation point.

```markdown
![Minion](https://octodex.github.com/images/minion.png)
```

![Minion](https://octodex.github.com/images/minion.png)

or :

```markdown
![Alt text](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")
```

![Alt text](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, images also have a footnote style syntax :

```markdown
![Alt text][id]
```

![Alt text][id]

With a reference later in the document defining the URL location :

```markdown
[id]: https://octodex.github.com/images/dojocat.jpg "The Dojocat"
```

[id]: https://octodex.github.com/images/dojocat.jpg "The Dojocat"

## Built-in Shortcodes

### figure

Example `figure` input :

```markdown
{{</* figure src="/images/2020/06/01/exploring-markdown-syntax/way.jpg" title="Way (figure)" */>}}
```

Output:-

{{< figure src="/images/2021/06/01/way.jpg" title="Way (figure)" >}}

### gist

Example `gist` input :

```markdown
{{</* gist spf13 7896402 */>}}
```

Output:-

{{< gist spf13 7896402 >}}

### highlight

Example `highlight` input :

```markdown
{{</* highlight html */>}}

<section id="main">
    <div>
        <h1 id="title">{{ .Title }}</h1>
        {{ range .Pages }}
            {{ .Render "summary"}}
        {{ end }}
    </div>
</section>
{{</* /highlight */>}}
```

Output :

{{< highlight html >}}

<section id="main">
    <div>
        <h1 id="title">{{ .Title }}</h1>
        {{ range .Pages }}
            {{ .Render "summary"}}
        {{ end }}
    </div>
</section>
{{< /highlight >}}

### instagram

Example `instagram` input :

```markdown
{{</* instagram BsOGulcndj- hidecaption */>}}
```

### param

Gets a value from the current Page's params set in front matter.

Example `param` input :

```markdown
{{</* param description */>}}
```

Output:-

{{< param description >}}

### tweet

[Documentation of `tweet`](https://gohugo.io/content-management/shortcodes#tweet)

Example `tweet` input :

```markdown
{{</* tweet 877500564405444608 */>}}
```

Output :

{{< tweet 877500564405444608 >}}

### vimeo

[Documentation of `vimeo`](https://gohugo.io/content-management/shortcodes#vimeo)

Example `vimeo` input :

```markdown
{{</* vimeo 146022717 */>}}
```

Output :

{{< vimeo 146022717 >}}

### youtube

Example `youtube` input :

```markdown
{{</* youtube w7Ft2ymGmfc */>}}
```

Output :

{{< youtube w7Ft2ymGmfc >}}

