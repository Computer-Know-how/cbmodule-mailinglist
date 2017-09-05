/**
* A widget that renders a listing of mailings from a specified mailing list
*/
component extends="contentbox.models.ui.BaseWidget" singleton{

	MailingList function init(controller){
		// super init
		super.init(controller);

		// Widget properties
		setName("MailingList");
		setVersion("1.0");
		setDescription("A widget that renders a listing of mailings from a specified mailing list");
		setAuthor("Seth Engen");
		setAuthorURL("www.compknowhow.com");
		setForgeBoxSlug("cbwidget-mailinglist");

		return this;
	}

	/**
	* Renders a mailing list listing
	* @slug.hint The list slug to render
	* @defaultValue.hint The string to show if the list slug does not exist
	*/
	any function renderIt(required string slug, string defaultValue){
		var content = runEvent(event='cbmodule-mailinglist:listRender.renderList',eventArguments=arguments);
		if( !isNull(content) ){
			return content;
		}

		// default value
		if( structKeyExists(arguments, "defaultValue") ){
			return arguments.defaultValue;
		}

		throw(message="The mailing list slug '#arguments.slug#' does not exist",type="MailingListWidget.InvalidMailingListSlug");
	}

}
