/**
* Handles the Mailing List module recipient events
*/
component extends="base" {

	property name="cb" 				inject="cbHelper@cb";

	// Recipient editor
	function editor(event,rc,prc){
		// Get new or persisted field
		prc.recipient  = recipientService.get( event.getValue("recipientID",0) );
		if( !prc.recipient.isLoaded() ){
			oList = listService.get( event.getValue("listID",0) );
			prc.recipient.setList(oList);
		}

		// View
		event.setView("recipient/editor");
	}

	// Save recipient
	function save(event,rc,prc){
		// Get it and populate it
		var oRecipient = populateModel( recipientService.get(id=rc.recipientID) );

		if( !oRecipient.isLoaded() ){
			oList = listService.get( event.getValue("listID",0) );
			oRecipient.setList(oList);
		}

		if ( !len(oRecipient.getEmail()) ){
			oRecipient.setEmail(oRecipient.getEmail());
		}

		// Validate it
		var errors = oRecipient.validate();
		if( !arrayLen(errors) ){
			// Save content
			recipientService.save( oRecipient );
			// Message
			getInstance("MessageBox@cbMessageBox").info("Recipient saved! Woot!");
		} else {
			getInstance("MessageBox@cbMessageBox").warn(messageArray=errors);
		}

		// Relocate back to editor
		setNextEvent(event=prc.xehListEditor,queryString="listID=#rc.listID#/##recipients");
	}

	function remove(event,rc,prc){
		var oRecipient	= recipientService.get( rc.recipientID );

		if( isNull(oRecipient) ){
			getInstance("MessageBox@cbMessageBox").setMessage("warning","Invalid recipient detected!");
			setNextEvent( prc.xehRecipients );
		}

		// Remove
		recipientService.delete( oRecipient );

		// Message
		getInstance("MessageBox@cbMessageBox").setMessage("info","Recipient removed!");

		// Relocate back to editor
		setNextEvent(event=prc.xehListEditor,queryString="listID=#rc.listID#/##recipients");
	}

	function confirmSubscription(event,rc,prc){
		param name="rc.email" default="";
		param name="rc.listID" default="";
		param name="rc.token" default="";
		// Get the settings
		var settings = settingService.getAllSettings(asStruct=true);
		var mailingListSettings = deserializeJSON(settings.mailing_list);

		var toHash = rc.email & rc.listID & mailingListSettings.secretKey;

		// If we have a token/hash match
		if (rc.token eq hash(toHash)) {
			var oRecipient = recipientService.findWhere({email=rc.email});

			// Does this email exist?
			if (isNull(oRecipient)) {
				var oList = listService.get(rc.listID);

				var oRecipient = recipientService.new();
				oRecipient.setEmail(rc.email);
				oRecipient.setList(oList);

				// Validate the recipient
				var errors = oRecipient.validate();

				if (arrayLen(errors)) {
					getInstance("MessageBox@cbMessageBox").setMessage(type="error",messageArray=errors);
				} else {
					recipientService.save(oRecipient);
					getInstance("MessageBox@cbMessageBox").setMessage("info","You are now subscribed to the list");
				}
			} else {
				getInstance("MessageBox@cbMessageBox").setMessage("info","Your email is already subscribed to the list");
			}
		} else {
			getInstance("MessageBox@cbMessageBox").setMessage("error","Email confirmation failed!");
		}
		setNextEvent(url=cb.linkHome());
	}

	function unsubscribe(event,rc,prc){
		// Get the settings
		var settings = settingService.getAllSettings(asStruct=true);
		var mailingListSettings = deserializeJSON(settings.mailing_list);

		var toHash = rc.email & rc.listID & mailingListSettings.secretKey;

		// If we have a token/hash match
		if (rc.token eq hash(toHash)) {
			var oList = listService.get(rc.listID);
			var oRecipient = recipientService.findWhere({email=rc.email,list=oList});

			// Does this email exist?
			if (!isNull(oRecipient)) {
				recipientService.delete(oRecipient);
				getInstance("MessageBox@cbMessageBox").setMessage("info","You have been unsubscribed from the list");
			} else {
				getInstance("MessageBox@cbMessageBox").setMessage("info","Hmmm, couldn't find your email address to remove");
			}
		} else {
			getInstance("MessageBox@cbMessageBox").setMessage("error","Email unsubscription failed!");
		}

		setNextEvent(url=cb.linkHome());
	}

}
