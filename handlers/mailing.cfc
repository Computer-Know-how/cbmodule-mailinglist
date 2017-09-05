/**
* Handles the Mailing List module mailing events
*/
component extends="base" {
	// Mailing editor
	function editor(event,rc,prc){
		// Get new or persisted field
		prc.mailing  = mailingService.get( event.getValue("mailingID",0) );
		if( !prc.mailing.isLoaded() ){
			oList = listService.get( event.getValue("listID",0) );
			prc.mailing.setList(oList);
		}

		// View
		event.setView("mailing/editor");
	}

	// Save mailing
	function save(event,rc,prc){
		// Get it and populate it
		var oMailing = populateModel( mailingService.get(id=rc.mailingID) );

		if( !oMailing.isLoaded() ){
			oList = listService.get( event.getValue("listID",0) );
			oMailing.setList(oList);
		}

		if ( !len(oMailing.getSubject()) ){
			oMailing.setSubject(oMailing.getSubject());
		}

		// Validate it
		var errors = oMailing.validate();
		if( !arrayLen(errors) ){
			// Save content
			mailingService.save( oMailing );
			// Message
			getInstance("MessageBox@cbMessageBox").info("Mailing saved! Woot!");
		} else {
			getInstance("MessageBox@cbMessageBox").warn(messageArray=errors);
		}

		// Relocate back to editor
		setNextEvent(event=prc.xehListEditor,queryString="listID=#rc.listID#/##mailings");
	}

	function remove(event,rc,prc){
		var oMailing	= mailingService.get( rc.mailingID );

		if( isNull(oMailing) ){
			getInstance("MessageBox@cbMessageBox").setMessage("warning","Invalid mailing detected!");
			setNextEvent( prc.xehMailings );
		}

		// Remove
		mailingService.delete( oMailing );

		// Message
		getInstance("MessageBox@cbMessageBox").setMessage("info","Mailing removed!");

		// Relocate back to editor
		setNextEvent(event=prc.xehListEditor,queryString="listID=#rc.listID#/##mailings");
	}

	function send(event,rc,prc){
		var oMailing	= mailingService.get( rc.sendMailingID );

		if( isNull(oMailing) ){
			getInstance("MessageBox@cbMessageBox").setMessage("warning","Invalid mailing detected!");
			setNextEvent( prc.xehMailings );
		}

		// Have we already sent this mailing?
		if (!len(oMailing.getMailingDate())) {
			// Send the message
			oMailing.send();

			// Set the mailing date to now
			oMailing.setMailingDate(now());
			mailingService.save( oMailing );

			// Message
			getInstance("MessageBox@cbMessageBox").setMessage("info","Mailing sent!");
		} else {
			getInstance("MessageBox@cbMessageBox").setMessage("warning","Mailing can only be sent once!");
		}

		// Relocate back to editor
		setNextEvent(event=prc.xehListEditor,queryString="listID=#rc.listID#/##mailings");
	}
}
