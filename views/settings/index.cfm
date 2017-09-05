<cfoutput>
#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-gear"></i> Settings
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
				#getInstance("MessageBox@cbMessageBox").renderit()#
				<div class="tabbable tabs-left">
					<ul class="nav nav-tabs">
						<li class="active"><a href="##security" data-toggle="tab"><i class="fa fa-reorder"></i> Security</a></li>
					</ul>

					<div class="tab-content">
						<!--- Security Details --->
						<div class="tab-pane active" id="security">
							#html.startForm(action="cbMailingList.settings.saveSettings",name="settingsForm")#
								#html.startFieldset(legend="Security")#
									<p>This will seed the hashing for email confirmation tokens.</p>
									#html.textField(name="secretKey", label="Secret Key:", value="#prc.settings.secretKey#", class="form-control")#
									<div class="form-actions">
										#html.submitButton(value="Save Settings",class="btn btn-danger",title="Save Settings")#
									</div>
								#html.endFieldSet()#
							#html.endForm()#
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--============================ Sidebar ============================-->
	<div class="col-md-3">
		<cfinclude template="../sidebar/actions.cfm" >
		<cfinclude template="../sidebar/help.cfm" >
		<cfinclude template="../sidebar/about.cfm" >
	</div>
</div>
</cfoutput>
