/**
* A module that will allow you to manage a mailing list from ContentBox.
*/
component {

	// Module Properties
	this.title 				= "MailingList";
	this.author 			= "Computer Know How";
	this.webURL 			= "http://www.compknowhow.com";
	this.description 		= "Mailing list management for ContentBox";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "cbMailingList";

	function configure(){

		// module settings - stored in modules.name.settings
		settings = {
			secretKey=""
		};

		// SES Routes
		routes = [
			{pattern="/", handler="mailing",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Interceptors
		interceptors = [
			{ class="#moduleMapping#.interceptors.CBFRequest", properties={ entryPoint="cbadmin" }, name="CBFRequest@cbMailingList" },
			{ class="#moduleMapping#.interceptors.uncacheMessageBox", name="uncacheMessageBox@cbMailingList" }
		];

		//Mappings
		binder.map("MailingListService@cbMailingList").to("#moduleMapping#.models.MailingListService");

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// ContentBox loading
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) ){
			// Let's add ourselves to the main menu in the Modules section
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			// Add Menu Contribution
			menuService.addSubMenu(topMenu=menuService.MODULES,name="cbMailingList",label="Mailing List",href="/cbMailingList/list");
		}
	}

	/**
	* Fired when the module is activated by ContentBox
	*/
	function onActivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		// store default settings
		var findArgs = {name="mailing_list"};
		var setting = settingService.findWhere(criteria=findArgs);
		if( isNull(setting) ){
			var args = {name="mailing_list", value=serializeJSON( settings )};
			var mailingListSettings = settingService.new(properties=args);
			settingService.save( mailingListSettings );
		}

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		// ContentBox unloading
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) ){
			// Let's remove ourselves to the main menu in the Modules section
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			// Remove Menu Contribution
			menuService.removeSubMenu(topMenu=menuService.MODULES,name="cbMailingList");
		}
	}

	/**
	* Fired when the module is deactivated by ContentBox
	*/
	function onDeactivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var args = {name="mailing_list"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			settingService.delete( setting );
		}
	}
}
