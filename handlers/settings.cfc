component extends="base" {

	// DI
	property name="settingService" 	inject="settingService@cb";
	property name="cb" 				inject="cbHelper@cb";

	function index(event,rc,prc){
		prc.settings = deserializeJSON(settingService.getSetting( "mailing_list" ));

		event.setView("settings/index");
	}

	function saveSettings(event,rc,prc){
		// Get settings from user input
		var newSettings = serializeJSON({"secretKey"=rc.secretKey});

		// Get settings object
		var oSetting = settingService.findWhere( { name="mailing_list" } );

		// Set the value and save
		oSetting.setValue( newSettings );
		settingService.save( oSetting );

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();

		// Messagebox
		getInstance("MessageBox@cbMessageBox").info("Settings Saved & Updated!");

		// Relocate via CB Helper
		setNextEvent("cbMailingList.settings.index");
	}

	function render(event,rc,prc){
		// Get settings
		prc.settings = getModuleSettings("MailingList").settings;
		return renderview(view="settings/index",module="cbMailingList");
	}

}
