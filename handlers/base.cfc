/**
* Base handler for the Mailing List module
*/
component{

	// Dependencies
	property name="listService" inject="id:MailingListService@cbMailingList";
	property name="mailingService" inject="entityService:Mailing";
	property name="recipientService" inject="entityService:Recipient";
	property name="settingService" inject="id:settingService@cb";

		// Pre handler
	function preHandler(event,action,eventArguments){
		var rc 	= event.getCollection();
		var prc = event.getCollection(private=true);

		// get module root
		prc.moduleRoot = event.getModuleRoot("cbmodule-mailinglist");

		// Exit points
		prc.xehLists = "cbMailingList.list.index";
		prc.xehListEditor = "cbMailingList.list.editor";
		prc.xehListSave = "cbMailingList.list.save";
		prc.xehListRemove = "cbMailingList.list.remove";

		prc.xehMailings = "cbMailingList.mailing.index";
		prc.xehMailingEditor = "cbMailingList.mailing.editor";
		prc.xehMailingSave = "cbMailingList.mailing.save";
		prc.xehMailingRemove = "cbMailingList.mailing.remove";
		prc.xehMailingSend = "cbMailingList.mailing.send";

		prc.xehRecipients = "cbMailingList.recipient.index";
		prc.xehRecipientEditor = "cbMailingList.recipient.editor";
		prc.xehRecipientSave = "cbMailingList.recipient.save";
		prc.xehRecipientRemove = "cbMailingList.recipient.remove";

		prc.xehSettings = "cbMailingList.settings.index";

		// Use the CB admin layout
		event.setLayout(name="admin",module="contentbox-admin");

		// Tab control
		prc.tabModules = true;
		prc.tabModules_cbMailingList = true;
	}

	//fires before any save, purging the cache
	function preSave(event,action,eventArguments){
		getModel("ContentService@cb").clearAllCaches(async=false);
	}

}
