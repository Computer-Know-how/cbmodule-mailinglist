// Mailing List: Recipient entity
component persistent="true" table="cb_mailingList_recipient"{

	// Primary key
	property name="recipientID" fieldtype="id" column="recipientID" generator="identity" setter="false";

	// Properties
	property name="email" notnull="true" length="500" default="";

	// M2O -> List
	property name="list" notnull="true" cfc="contentbox.modules.MailingList.models.MailingList" fieldtype="many-to-one" fkcolumn="FK_listID" lazy="true" fetch="join";

	// Constructor
	function init(){
		return this;
	}

	// Is loaded?
	boolean function isLoaded(){
		return len( getRecipientID() );
	}

	// Validate entry, returns an array of errors or no messages
	array function validate(){
		var errors = [];

		// Limits
		if( len(email) gt 50 ){ arrayAppend(errors, "Email is too long"); }

		// Required
		if( !len(email) ){ arrayAppend(errors, "Email is required"); }

		return errors;
	}

}
