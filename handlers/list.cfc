/**
* Handles the Mailing List module list events
*/
component extends="base" {

	function index(event,rc,prc){
		// Current lists
		prc.lists = listService.list(sortOrder="dateAdded DESC",asQuery=false); //

		// Lists view
		event.setView(view="list/index",module="cbmodule-mailinglist");
	}

	// List editor
	function editor(event,rc,prc){
		// Get new or persisted list
		prc.list = listService.get( event.getValue("listID",0) );

		// Viewlets
		prc.mailingsViewlet = "";
		prc.recipientsViewlet = "";
		if( prc.list.isLoaded() ){
			var args = {listID=rc.listID};
			prc.mailingsViewlet = runEvent(event="cbmodule-mailinglist:list.mailings",eventArguments=args);
			prc.recipientsViewlet = runEvent(event="cbmodule-mailinglist:list.recipients",eventArguments=args);
		}

		// View
		event.setView("list/editor");
	}

	// Save list
	function save(event,rc,prc){
		// Get it and populate it
		var oList = populateModel( listService.get(ID=rc.listID) );

		if (!len(oList.getDateAdded())) {
			oList.setDateAdded(now());
		}

		// Validate it
		var errors = oList.validate();
		if( !arrayLen(errors) ){
			// Save content
			listService.save( oList );
			// Message
			getInstance("MessageBox@cbMessageBox").info("List details saved! Yippee skippy!");
		}
		else{
			getInstance("MessageBox@cbMessageBox").warn(messageArray=errors);
		}

		// Relocate back to editor
		setNextEvent(event=prc.xehListEditor,queryString="listID=#oList.getListID()#/##details");
	}

	// Remove list
	function remove(event,rc,prc){
		var oList	= listService.get( rc.listID );

		if( isNull(oList) ){
			getInstance("MessageBox@cbMessageBox").setMessage("warning","Invalid list detected!");
			setNextEvent( prc.xehLists );
		}

		// Remove
		listService.delete( oList );

		// Message
		getInstance("MessageBox@cbMessageBox").setMessage("info","List removed!");

		// Redirect
		setNextEvent(prc.xehLists);
	}

	function mailings(event,rc,prc,listID){
		// Current lists
		var oList = listService.get(arguments.listID);
		prc.mailings = oList.getMailings();

		if (isNull(prc.mailings)) {
			prc.mailings = [];
		}

		// Mailing form view
		return renderview(view="viewlets/mailings",module="cbmodule-mailinglist");
	}

	function recipients(event,rc,prc,listID){
		// Current lists
		var oList = listService.get(arguments.listID);
		prc.recipients = oList.getRecipients();

		if (isNull(prc.recipients)) {
			prc.recipients = [];
		}

		// Recipient form view
		return renderview(view="viewlets/recipients",module="cbmodule-mailinglist");
	}

}
