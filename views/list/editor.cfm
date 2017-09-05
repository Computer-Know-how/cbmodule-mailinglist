<cfoutput>
	#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<cfif prc.list.isLoaded()>
					<i class="fa fa-edit"></i>
					Editing "#prc.list.getName()#"
				<cfelse>
					<i class="fa fa-plus"></i>
					Create List
				</cfif>
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

				<div class="tabbable tabs-left">
					<!--- User Navigation Bar --->
					<ul class="nav nav-tabs">
						<li class="active"><a href="##details" data-toggle="tab"><i class="fa fa-list"></i> List Details</a></li>
						<cfif prc.list.isLoaded()>
						<li><a href="##mailings-tab" data-toggle="tab"><i class="fa fa-envelope-o"></i> List Mailings</a></li>
						<li><a href="##recipients-tab" data-toggle="tab"><i class="fa fa-group"></i> List Recipients</a></li>
						</cfif>
					</ul>

					<div class="tab-content">
						<div class="tab-pane active" id="details">
							<!--- List Details --->
							#html.startForm(name="list",action=prc.xehListSave,novalidate="novalidate")#
								#html.startFieldset(legend="List Details")#
								#html.hiddenField(name="listID",bind=prc.list)#
								<!--- Fields --->
								#html.textField(name="name", label="*Name:", title="A friendly name for your list", bind=prc.list, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#
								#html.textField(name="slug", label="*Slug:", title="A slug to identify the list.  Must be unique.", bind=prc.list, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#
								#html.textarea(name="description", label="Description:", title="Type a description of the list", bind=prc.list, rows="10", class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#
								<div class="form-actions">
									<button class="btn" onclick="return to('#event.buildLink(prc.xehLists)#')">Cancel</button>
									<input type="submit" value="Save" class="btn btn-danger">
								</div>
								#html.endFieldSet()#
							#html.endForm()#
						</div>

						<!--- List Mailings --->
						<div class="tab-pane" id="mailings-tab">
							#html.startFieldset(legend="List Mailings")#
								#prc.mailingsViewlet#
							#html.endFieldSet()#
						</div>

						<!--- List Recipients --->
						<div class="tab-pane" id="recipients-tab">
							#html.startFieldset(legend="List Recipients")#
								#prc.recipientsViewlet#
							#html.endFieldSet()#
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--============================ Sidebar ============================-->
	<div class="col-md-3"">
		<cfinclude template="../sidebar/actions.cfm" >
		<cfinclude template="../sidebar/help.cfm" >
		<cfinclude template="../sidebar/about.cfm" >
	</div>
</div>
</cfoutput>
