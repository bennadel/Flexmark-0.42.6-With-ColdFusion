<cfscript>

	// Read-in our markdown file.
	markdown = fileRead( expandPath( "./widgets.md" ) );

	// Create some of our Class definitions. We need this in order to access some static
	// methods and properties.
	HtmlRendererClass = application.flexmarkJavaLoader.create( "com.vladsch.flexmark.html.HtmlRenderer" );
	ParserClass = application.flexmarkJavaLoader.create( "com.vladsch.flexmark.parser.Parser" );

	// Create our parser and renderer - both using the options.
	options = application.flexmarkJavaLoader.create( "com.vladsch.flexmark.util.options.MutableDataSet" ).init();
	parser = ParserClass.builder( options ).build();
	renderer = HtmlRendererClass.builder( options ).build();

	// Parse the markdown into an AST (Abstract Syntax Tree) document node.
	document = parser.parse( javaCast( "string", markdown ) );

	// Render the AST (Abstract Syntax Tree) document into an HTML string.
	html = renderer.render( document );

	// The JRegEx component will help us parse and replace the resultant HTML.
	jre = new JRegEx();

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// This version replaces the simple Vimeo VideoID widget.
	html = jre.jreReplace(
		html,
		"<!-- vimeo: *(\S+) -->",
		function( $0, videoID ) {

			// NOTE: I am including the original captured group in the output ($0) in
			// order to make the inputs and outputs easier to see in the demo.
			return('
				#$0#
				<iframe
					src="//player.vimeo.com/video/#videoID#?color=ff0179"
					width="700"
					height="394"
					frameborder="0"
					webkitallowfullscreen
					mozallowfullscreen
					allowfullscreen
				></iframe>
			');

		}
	);

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// This version replaces the more complex Script tag containing JSON content.
	html = jre.jreReplace(
		html,
		"<script type=.markdown/widget.>([\S\s]+?)</script>",
		function( $0, json ) {

			var data = deserializeJson( trim( json ) );

			// NOTE: I am including the original captured group in the output ($0) in
			// order to make the inputs and outputs easier to see in the demo.
			return('
				#$0#
				<iframe
					src="//player.vimeo.com/video/#data.vimeo.id#?color=#data.vimeo.color#"
					width="700"
					height="394"
					frameborder="0"
					webkitallowfullscreen
					mozallowfullscreen
					allowfullscreen
				></iframe>
			');

		}
	);

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	// This version replaces JSON, but using an HTML Comment instead of a Script tag.
	html = jre.jreReplace(
		html,
		"<!--\s*json:([\S\s]+?)-->",
		function( $0, json ) {

			var data = deserializeJson( trim( json ) );

			// NOTE: I am including the original captured group in the output ($0) in
			// order to make the inputs and outputs easier to see in the demo.
			return('
				#$0#
				<iframe
					src="//player.vimeo.com/video/#data.vimeo.id#?color=#data.vimeo.color#"
					width="700"
					height="394"
					frameborder="0"
					webkitallowfullscreen
					mozallowfullscreen
					allowfullscreen
				></iframe>
			');

		}
	);

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

</cfscript>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>
		Considering Ways To Embed Widgets In My Markdown Using Flexmark 0.42.6 And ColdFusion
	</title>
</head>
<body>

	<h1>
		Considering Ways To Embed Widgets In My Markdown Using Flexmark 0.42.6 And ColdFusion
	</h1>

	<h2>
		Rendered Output:
	</h2>

	<hr />

	<cfoutput>#html#</cfoutput>

	<hr />

	<h2>
		Rendered Markup:
	</h2>

	<pre class="language-html"
		><code class="language-html"
			><cfoutput>#encodeForHtml( html )#</cfoutput
		></code
	></pre>

	<!-- For our fenced code-block syntax highlighting. -->
	<link rel="stylesheet" type="text/css" href="./vendor/prism-1.14.0/prism.css" />
	<script type="text/javascript" src="./vendor/prism-1.14.0/prism.js"></script>

</body>
</html>
