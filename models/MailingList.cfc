// Mailing List: List entity
component persistent="true" table="cb_mailingList_list"{

	// Primary key
	property name="listID" fieldtype="id" column="listID" generator="identity" setter="false";

	// Properties
	property name="slug" notnull="true" length="200" default="" unique="true";
	property name="name" notnull="true" length="500" default="";
	property name="description" notnull="false" length="8000" default="";
	property name="dateAdded" notnull="true" ormtype="timestamp" update="false";

	// O2M -> Mailings
	property name="mailings" singularName="mailing" fieldtype="one-to-many" type="array" lazy="extra" batchsize="25" orderby="mailingDate"
			  cfc="contentbox.modules_user.cbmodule-mailinglist.models.Mailing" fkcolumn="FK_listID" inverse="true" cascade="all-delete-orphan";

	// O2M -> Recipients
	property name="recipients" singularName="recipient" fieldtype="one-to-many" type="array" lazy="extra" batchsize="25" orderby="email"
			  cfc="contentbox.modules_user.cbmodule-mailinglist.models.Recipient" fkcolumn="FK_listID" inverse="true" cascade="all-delete-orphan";

	// Constructor
	function init(){
		return this;
	}

	// Is loaded?
	boolean function isLoaded(){
		return len( getListID() );
	}

	// Validate entry, returns an array of error or no messages
	array function validate(){
		var errors = [];

		// Limits
		slug				= left(slug,200);
		name				= left(name,500);
		description			= left(description,8000);

		// Required
		if( !len(slug) ){ arrayAppend(errors, "Slug is required"); }
		if( !len(name) ){ arrayAppend(errors, "Name is required"); }

		return errors;
	}
}
