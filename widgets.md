
When it comes to embedding widgets in my markdown, I could just embed the HTML
right in the content. Embedding HTML is a totally valid approach:

<iframe
	src="//player.vimeo.com/video/96794772?color=ff3366"
	width="700"
	height="394"
	frameborder="0"
	webkitallowfullscreen
	mozallowfullscreen
	allowfullscreen
></iframe>

The problem with this is that tightly couples the "intent" of the widget to the
"implementation" of the widget. Plus, it's quite verbose. Instead, what I'd like
to do is provide a _description_ of the widget; and then hide the implementation
behind some sort of post-processing.

The first approach that I thought of was to use an HTML Comment to embed simple
markers that could be replaced with a RegEx pattern:

<!-- vimeo: 96794772 -->

The above approach is nice when there is a single token to work with (such as
the video ID) because the pattern is really easy to match. But, if the data is
more complex and has several attributes, it might be nice to work with a complex
data structure. For this, I could use a Script tag to embed JSON (JavaScript
Object Notation) directly in the content:

<script type="markdown/widget">
	{
		"type": "vimeo",
		"vimeo": {
			"id": "96794772",
			"color": "ffffff"			
		}
	}
</script>

In this case, we're still using a RegEx pattern to match the payload between the
open `<script>` and the close `</script>`. But, the contents ultimately get
parsed using the `deserializeJson()` function.

But, then I wondered, could I just do the same thing with an HTML Comment and a
bit less ceremony:

<!-- json:
	{
		"type": "vimeo",
		"vimeo": {
			"id": "96794772",
			"color": "ff00ff"			
		}
	}
-->

This approach works quite well and has less syntax. But, isn't quite as
attractive, visually speaking. That said, any of these approach is sufficient
and fills me with hope that migrating to Markdown will be easier than I thought
it would be.
