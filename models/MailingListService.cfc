// A ColdBox enabled virtual entity service
component extends="modules.contentbox.modules.contentbox-deps.modules.cborm.models.VirtualEntityService" singleton{

	// DI
	property name="listService" inject="entityService:MailingList";
	property name="mailService" inject="model:mailService@cbmailservices";
	property name="settingService" inject="id:settingService@cb";
	property name="CBHelper" inject="id:CBHelper@cb";
	property name="controller" inject="coldbox";

	// Constructor
	public MailingListService function init(){
		// init super class
		super.init(entityName="MailingList");

		// Use Query Caching
		setUseQueryCaching( true );
		// Query Cache Region
		setQueryCacheRegion( 'MailingList' );
		// EventHandling
		setEventHandling( true );

		return this;
	}

	// Send the mailing
	public void function sendSubscribeConfirmation(required emailAddress, required listID){
		var settings = settingService.getAllSettings(asStruct=true);
		var confirmURL = createConfirmLink(arguments.emailAddress,arguments.listID);

		oList = listService.get(arguments.listID);

		var subject = "Mailing list '" & oList.getName() & "' subscription";
		var body = "You have requested an email subscription.  Please confirm your email address to finalize the subscription by clicking the following link:<br /><br /><a href='#confirmURL#'>Confirm my subscription</a><br /><br />Thank you,<br />" & CBHelper.siteName();

		// Make some mail
		var mail = mailservice.newMail(to=arguments.emailAddress,
									   from=settings.cb_site_outgoingEmail,
									   subject=subject,
									   body=body,
									   type="html",
									   server=settings.cb_site_mail_server,
									   username=settings.cb_site_mail_username,
									   password=settings.cb_site_mail_password,
									   port=settings.cb_site_mail_smtp,
									   useTLS=settings.cb_site_mail_tls,
									   useSSL=settings.cb_site_mail_ssl);

		// Send it out
		mailService.send( mail );
	}

	private function createHash(required emailAddress, required listID) {
		// Get the settings
		var settings = settingService.getAllSettings(asStruct=true);
		var mailingListSettings = deserializeJSON(settings.mailing_list);

		var toHash = arguments.emailAddress & arguments.listID & mailingListSettings.secretKey;
		var token = hash(toHash);
		return token;
	}

	private function createConfirmLink(required emailAddress, required listID) {
		var token = createHash(arguments.emailAddress,arguments.listID);
		var moduleURL = getEvent().buildLink( linkto="cbMailingList.recipient.confirmSubscription" );
		var confirmURL = moduleURL & "/email/" & arguments.emailAddress & "/listID/" & arguments.listID & "/token/" & token;
		return confirmURL;
	}

	private function getEvent(){
		return controller.getRequestService().getContext();
	}

}
