<cfoutput>
#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-user"></i>
				<cfif prc.recipient.isLoaded()>Editing "#prc.recipient.getEmail()#"<cfelse>Add Recipient</cfif>
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

				#html.startForm(name="recipientform",action=prc.xehRecipientSave,novalidate="novalidate")#
					#html.startFieldset(legend="Recipient Details")#
					#html.hiddenField(name="recipientID",bind=prc.recipient)#
					#html.hiddenField(name="listID",value=prc.recipient.getList().getListID())#
					#html.textField(name="email", label="*Email:",required="required", title="The email address of the recipient", bind=prc.recipient, class="form-control", size="50", wrapper="div class=controls", labelClass="control-label", groupWrapper="div class=form-group")#
					<div class="form-actions">
						<button class="btn" onclick="return to('#event.buildLink(prc.xehListEditor)#/listID/#prc.recipient.getList().getListID()#/##recipients')">Cancel</button>
						<input type="submit" value="Save" class="btn btn-danger">
					</div>
					#html.endFieldSet()#
				#html.endForm()#
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
