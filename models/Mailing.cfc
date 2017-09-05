// Mailing List: Recipient entity
component persistent="true" table="cb_mailingList_mailing"{

	// Primary key
	property name="mailingID" fieldtype="id" column="mailingID" generator="identity" setter="false";

	// Properties
	property name="subject" notnull="true" length="500" default="";
	property name="content" notnull="true" length="8000" default="";
	property name="mailingDate" notnull="false" ormtype="timestamp";

	// M2O -> List
	property name="list" notnull="true" cfc="contentbox.modules_user.cbmodule-mailinglist.models.MailingList" fieldtype="many-to-one" fkcolumn="FK_listID" lazy="true" fetch="join";

	//DI
	property name="mailService"		inject="model:mailService@cbmailservices" persistent="false";
	property name="settingService"	inject="id:settingService@cb" persistent="false";
	property name="controller"		inject="coldbox" persistent="false";

	// Constructor
	function init(){
		return this;
	}

	// Is loaded?
	boolean function isLoaded(){
		return len( getMailingID() );
	}

	// Validate entry, returns an array of error or no messages
	array function validate(){
		var errors = [];

		// Limits
		subject				= left(subject,500);
		content				= left(content,8000);

		// Required
		if( !len(subject) ){ arrayAppend(errors, "Subject is required"); }
		if( !len(content) ){ arrayAppend(errors, "Content is required"); }

		return errors;
	}

	// Send the mailing
	public void function send(){
		var recipients = getList().getRecipients();

		// Loop it up!
		for (recipient in recipients) {
			//set some settings
			var settings = settingService.getAllSettings(asStruct=true);
			var unsubscribeURL = createUnsubscribeLink(recipient.getEmail(),recipient.getList().getListID());

			var body = getContent() & "<br /><hr /><a href='#unsubscribeURL#'>Unsubscribe</a>";

			cfmail(from=settings.cb_site_outgoingEmail, subject=getSubject(), to=recipient.getEmail(), type="html") {
				writeOutput(body);
			}
		}
	}

	private function createHash(required emailAddress, required listID) {
		// Get the settings
		var settings = settingService.getAllSettings(asStruct=true);
		var mailingListSettings = deserializeJSON(settings.mailing_list);

		var toHash = arguments.emailAddress & arguments.listID & mailingListSettings.secretKey;
		var token = hash(toHash);
		return token;
	}

	private function createUnsubscribeLink(required emailAddress, required listID) {
		var token = createHash(arguments.emailAddress,arguments.listID);
		var moduleURL = getEvent().buildLink( linkto="cbMailingList.recipient.unsubscribe" );
		var unsubscribeURL = moduleURL & "/email/" & arguments.emailAddress & "/listID/" & arguments.listID & "/token/" & token;

		return unsubscribeURL;
	}

	private function getEvent(){
		return controller.getRequestService().getContext();
	}

}
