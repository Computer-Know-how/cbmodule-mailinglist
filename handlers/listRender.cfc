/**
* I handle the list rendering events
*/
component {

	// Dependencies
	property name="listService" inject="id:MailingListService@cbMailingList";
	property name="mailingService" inject="entityService:Mailing";
	property name="recipientService" inject="entityService:Recipient";

	function renderList(event,rc,prc,slug) {
		var list = listService.findWhere({slug=arguments.slug});
		prc.listID = list.getListID();

		var c = mailingService.newCriteria();
		c.isNotNull("mailingDate");
		c.createAlias("list","l");
		c.eq("l.slug",arguments.slug);
		c.order("mailingDate","desc");
		prc.mailings = c.list();

		return renderView(view="viewlets/renderList",module="cbmodule-mailinglist");
	}

	function subscribeToList(event,rc,prc) {
		var oRecipient = recipientService.findWhere({email=rc.emailAddress});
		var oList = listService.get(rc.listID);

		// Do we have a list?
		if (!isNull(oList)) {
			// Do we have a recipient?
			if (!isNull(oRecipient)) {
				// You are already on the list man!
				getInstance("MessageBox@cbMessageBox").setMessage("warning","You are already on the list!");
			} else {
				// Send subscription confirmation
				listService.sendSubscribeConfirmation(rc.emailAddress, rc.listID);
				getInstance("MessageBox@cbMessageBox").setMessage("info","Your subscription request has been sent.  Please check your email and confirm your email address to complete your subscription.");
			}
		} else {
			// Sorry, we couldn't find the list
			getInstance("MessageBox@cbMessageBox").setMessage("warning","Sorry, we couldn't find the list!");
		}

		setNextEvent(url=rc._returnTo);
	}

}
