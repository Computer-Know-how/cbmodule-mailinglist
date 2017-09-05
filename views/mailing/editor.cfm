<cfoutput>
#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-envelope"></i>
				<cfif prc.mailing.isLoaded()>Editing "#prc.mailing.getSubject()#"<cfelse>Create Mailing</cfif>
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

						<!--- User Navigation Bar --->
						<ul class="nav nav-tabs">
							<li class="active"><a href="##optionDetails" data-toggle="tab"><i class="fa fa-list"></i> Mailing Details</a></li>
						</ul>

				<!--- Mailing Details --->
				#html.startForm(name="mailingform",action=prc.xehMailingSave,novalidate="novalidate")#
					#html.startFieldset(legend="Mailing Details")#
					#html.hiddenField(name="mailingID",bind=prc.mailing)#
					#html.hiddenField(name="listID",value=prc.mailing.getList().getListID())#
					#html.textField(name="subject", label="*Subject:",required="required", title="The subject of this mailing", bind=prc.mailing, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#
					#html.textarea(name="content", label="Content:",required="required",rows="10", title="The content (body) for this mailing", bind=prc.mailing, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#
					<div class="form-actions">
						<button class="btn" onclick="return to('#event.buildLink(prc.xehListEditor)#/listID/#prc.mailing.getList().getListID()#/##mailings')">Cancel</button>
						<input type="submit" value="Save" class="btn btn-danger">
					</div>
					#html.endFieldSet()#
				#html.endForm()#

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
