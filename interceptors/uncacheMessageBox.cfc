/**
* I am a messagebox interceptor, makes sure messages are delivered without caching
*/
component {

	// DI Injections
	property name="cachebox" 			inject="cachebox";
	property name="settingService"		inject="id:settingService@cb";
	property name="pageService"			inject="id:pageService@cb";

	void function configure(){}

	void function cbui_preRequest(event,struct interceptData){
		//if we have a message in the messagebox evict the page from cache
		if (!getInstance("messagebox@cbmessagebox").isEmptyMessage()){
			var page = getPageFromEvent(event);
			event.setValue("evictPage","true",true);
			doCacheCleanup(page.buildContentCacheKey(),page);
		}
	}

	void function cbui_postRequest(event,struct interceptData) {
		//if we evicted the page then evict again so we don't get a page cached with a messagebox
		if(event.getValue("evictPage","false",true)){
			var page = getPageFromEvent(event);
			doCacheCleanup(page.buildContentCacheKey(),page);
		}
	}

	// clear according to cache settings
	private function doCacheCleanup(required string cacheKey, any content){
		// Get settings
		var settings = settingService.getAllSettings(asStruct=true);
		// Get appropriate cache provider
		var cache = cacheBox.getCache( settings.cb_content_cacheName );
		// clear by keysnippets
		cache.clearByKeySnippet(keySnippet=arguments.cacheKey,async=false);
		cache.clearByKeySnippet(keySnippet="cb-content-pagewrapper-#replacenocase(arguments.content.getSlug(), "/" & listLast(arguments.content.getSlug(),"/"),"")#",async=false);
	}

	private function getPageFromEvent(event){
		var rc = event.getCollection();
		var prc = event.getCollection(private="true");
		var incomingURL  = "";
		// Do we have an override page setup by the settings?
		if( !structKeyExists(prc,"pageOverride") ){
			// Try slug parsing for hiearchical URLs
			incomingURL  = rereplaceNoCase(event.getCurrentRoutedURL(), "\/$","");
		}
		else{
			incomingURL	 = prc.pageOverride;
		}

		// Entry point cleanup
		if( len( prc.cbEntryPoint ) ){
			incomingURL = replacenocase( incomingURL, prc.cbEntryPoint & "/", "" );
		}

		// Try to get the page using the incoming URI
		return pageService.findBySlug( incomingURL, false );
	}

}
