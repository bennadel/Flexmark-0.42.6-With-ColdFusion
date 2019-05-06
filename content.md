
<!--
	LESSON: HTML comments can be embedded right in the markdown. This can be used to
	interrupt other Markdown constructs. I could also be used to embed meta-data right
	into the content to be consumed programmatically after rendering. Example:
-->
<!-- VIDEO: 23vid7f3 -->


<!--
	LESSON: Style tags can be embedded right in the markdown.
-->
<style type="text/css">
	body {
		font-size: 16px ;
	}
</style>

<!--
	LESSON: Script tags can be embedded right in the markdown.
-->
<script type="text/javascript">
	console.log( "Oh chickens!" );
</script>

<script type="text/app-data">
	{
		id: 12345,
		name: "Thing"
	}
</script>


<!--
	LESSON: Code-fences can use more than 3-ticks to start and end a fenced-block. This
	allows for embedded ticks to be used. The end just has to have AT LEAST as many ticks
	as the start.
-->
````````txt
This has embedded ``` ticks.
````````


<!--
	LESSON: Inline code-spans can use more than 1-tick to start and end a span. This
	allows for embedded ticks to be used. The end just to have the same number of ticks
	as the start.
-->
This ```an embedded ` tick ``` right here.


<!--
	LESSON: Pre tags can be embedded right in the markdown.
-->
<pre>
	This markdown will **not be interpreted**.
</pre>


<!--
	LESSON: Markdown within HTML Blocks will be interpreted (as markdown) if the inner-
	content is separated by a blank line.
-->
<div data-id="container">

This markdown **will be interpreted**!

</div>


<!--
	LESSON: Link references can contain optional Title attributes.
-->
[mylink]: https://www.bennadel.com "This is a groovy link title!"

Hey, why don't you [click me][mylink].


<!--
	LESSON: Link references can be rendered by label alone. This renders the link label
	as the link text.
-->
[BenNadel.com]: https://www.bennadel.com "A blog on things and stuff."

You should really check out [BenNadel.com].


<!--
	LESSON: Link references work with images.
	--
	NOTE: I am also using the Flexmark Attributes Extension to assign WIDTH to the image.
	This is not a native part of the CommonMark Specification.
-->
[myimage]: ./goose-duck.jpg "Isn't she great?!"

![Goose Duck][myimage]{width="100"}


<!--
	LESSON: List items that are right next to each other will be embedded right in an LI.
	However, list items that are separated by a blank line will be embedded in P tags.
-->
* I will be wrapped in a `p` inside an `li`.

* I will be wrapped in a `p` inside an `li`.


<!--
	LESSON: HTML comments can interrupt two sibling lists.
-->
* In list one.
* In list one.
<!-- -->
* In list two.
* In list two.


<!--
	LESSON: Partial-word emphasis works with **, but not with __.
-->
Holy**chickens**!, this is fan__freakin__tastic!


<!--
	LESSON: Absolute links wrapped in < and > will get auto-linked.
-->
Check out <https://www.bennadel.com> for more info.


<!--
	LESSON: Two trailing spaces on a line will create a hard break, <br/>.
-->
This will all
be on one
line.

But, this will  
be on three  
different lines.


<!--
	LESSON: Anything that looks like HTML will be kept as-is. If it is inline, it will
	wrapped in `p` tags. If it goes across lines, it will be treated as a block element.
-->
Checkout <MyInlineElement></MyInlineElement>.

<!--
	CAUTION: If you try to wrap attribute on another line, this gets treated as an inline
	element. I am not sure if this is part of the spec; or, if this is just Flexmark.
-->
<MyBlockElement data-id="123" data-value="something">
</MyBlockElement>

<!--
	Self-closing tags appear to be treated as block elements if they are defined by
	themselves on a SINGLE LINE. Again, I am not sure if this is the spec or just how
	Flexmark is implementing it.
-->
<MyBlockElement data-id="123" data-value="something" />
