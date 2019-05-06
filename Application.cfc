component
	output = false
	hint = "I provide the application settings and event handlers."
	{

	// Define the application.
	this.name = hash( getCurrentTemplatePath() );
	this.applicationTimeout = createTimeSpan( 0, 0, 10, 0 );
	this.sessionManagement = false;

	// Setup the application mappings.
	this.directory = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/" ] = this.directory;
	this.mappings[ "/flexmark" ] = ( this.directory & "vendor/flexmark-0.42.6/" );
	this.mappings[ "/javaloader" ] = ( this.directory & "vendor/javaloader-1.2/javaloader/" );
	this.mappings[ "/javaloaderfactory" ] = ( this.directory & "vendor/javaloaderfactory/" );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I initialize the application.
	* 
	* @output false
	*/
	public boolean function onApplicationStart() {

		// In order to prevent memory leaks, we're going to use the JavaLoaderFactory to
		// instantiate our JavaLoader. This will keep the instance cached in the Server
		// scope so that it doesn't have to continually re-create it as we test our
		// application configuration.
		application.javaLoaderFactory = new javaloaderfactory.JavaLoaderFactory();

		// Create a JavaLoader that can access the Flexmark 0.42.6 JAR files.
		// --
		// NOTE: This list of JAR files contains the CORE Flexmark functionality plus
		// the Attributes extension. Flexmark is configured such that each extension is
		// packaged as a separate, optional set of JAR files.
		application.flexmarkJavaLoader = application.javaLoaderFactory.getJavaLoader([
			expandPath( "/flexmark/flexmark-0.42.6.jar" ),
			expandPath( "/flexmark/flexmark-ext-attributes-0.42.6.jar" ),
			expandPath( "/flexmark/flexmark-formatter-0.42.6.jar" ),
			expandPath( "/flexmark/flexmark-util-0.42.6.jar" )
		]);

		// Indicate that the application has been initialized successfully.
		return( true );

	}

}
