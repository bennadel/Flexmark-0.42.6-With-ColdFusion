<cfscript>

	// Read-in our markdown file.
	markdown = fileRead( expandPath( "./content.md" ) );

	// Create some of our Class definitions. We need this in order to access some static
	// methods and properties.
	AttributesExtensionClass = application.flexmarkJavaLoader.create( "com.vladsch.flexmark.ext.attributes.AttributesExtension" );
	HtmlRendererClass = application.flexmarkJavaLoader.create( "com.vladsch.flexmark.html.HtmlRenderer" );
	ParserClass = application.flexmarkJavaLoader.create( "com.vladsch.flexmark.parser.Parser" );

	// Create our options instance - this dataset is used to configure both the parser
	// and the renderer.
	options = application.flexmarkJavaLoader.create( "com.vladsch.flexmark.util.options.MutableDataSet" ).init();

	// Define the extensions we're going to use. In this case, the only extension that
	// I want to add is the Attributes Extension. This allows me to use {...} postfix
	// syntax in order to append attributes to the preceding element.
	// --
	// NOTE: If you want to add more extensions, you will need to download more JAR files
	// and add them to the JavaLoader class paths.
	options.set(
		ParserClass.EXTENSIONS,
		[
			AttributesExtensionClass.create()
		]
	);

	// Create our parser and renderer - both using the options.
	// --
	// NOTE: In the demo, I'm re-creating these on every page request. However, in
	// production I would probably cache both of these inside of some Abstraction
	// (such as MarkdownParser.cfc) which would, in turn, get cached inside the
	// application scope.
	parser = ParserClass.builder( options ).build();
	renderer = HtmlRendererClass.builder( options ).build();

	// Parse the markdown into an AST (Abstract Syntax Tree) document node.
	document = parser.parse( javaCast( "string", markdown ) );

	// Render the AST (Abstract Syntax Tree) document into an HTML string.
	html = renderer.render( document );

</cfscript>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>
		Using Flexmark 0.42.6 To Parse Markdown Into HTML in ColdFusion
	</title>
</head>
<body>

	<h1>
		Using Flexmark 0.42.6 To Parse Markdown Into HTML in ColdFusion
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
