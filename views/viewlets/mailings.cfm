<cfoutput>
<!--- Mailing Form --->
#html.startForm(name="mailingForm",action=prc.xehMailingRemove)#
#html.hiddenField(name="mailingID",value="")#
#html.hiddenField(name="listID",value=prc.list.getListID())#

<div class="well well-sm">
	<div class="btn-group btn-sm pull-right">
		<button class="btn btn-sm btn-primary" onclick="toMailingForm(); return false;" title="Create new mailing">Create Mailing</button>
	</div>

	<div class="form-group form-inline no-margin">
		<input type="text" name="mailingFilter" size="30" class="form-control" placeholder="Quick Filter" id="mailingFilter">
	</div>
</div>


<!--- Mailings --->
<table id="mailings" class="table table-striped">
	<thead>
		<tr>
			<th>Subject</th>
			<th>Mailing Date</th>
			<th width="100" class="center {sorter:false}">Actions</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#prc.mailings#" index="mailing">
		<tr id="mailingid-#mailing.getMailingID()#">
			<td><a href="#event.buildLink(prc.xehMailingEditor)#/mailingID/#mailing.getMailingID()#" title="Edit #mailing.getSubject()#">#mailing.getSubject()#</a></td>
			<td>#dateFormat(mailing.getMailingDate(),"short")# #timeFormat(mailing.getMailingDate(),"short")#</td>

			<td class="center">
				<cfif prc.oCurrentAuthor.checkPermission("MAILINGLIST_MAILING_ADMIN")>
					<cfif isNull(mailing.getMailingDate())>
						<!--- Send Command --->
						<a class="btn btn-primary btn-sm" title="Send Mailing" href="javascript:sendMailing('#mailing.getMailingID()#')" class="confirmIt" data-title="Send Mailing?"><i class="fa fa-envelope-o"></i></a>
					</cfif>
				</cfif>
				<cfif prc.oCurrentAuthor.checkPermission("MAILINGLIST_MAILING_EDITOR") or prc.oCurrentAuthor.checkPermission("MAILINGLIST_MAILING_ADMIN")>
					<!--- Edit Command --->
					<a class="btn btn-info btn-sm" href="#event.buildLink(prc.xehMailingEditor)#/mailingID/#mailing.getMailingID()#"
						title="Edit #mailing.getSubject()#"><i class="fa fa-pencil"></i></a>
				</cfif>
				<cfif prc.oCurrentAuthor.checkPermission("MAILINGLIST_MAILING_ADMIN")>
						<!--- Delete Command --->
						<a class="btn btn-danger btn-sm confirmIt" title="Delete Mailing" href="javascript:removeMailing('#mailing.getMailingID()#')" data-title="Delete Mailing?"><i id="delete_#mailing.getMailingID()#" class="fa fa-trash"></i></a>

				</cfif>
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>
#html.endForm()#

<!--- Send Mailing Form --->
#html.startForm(name="sendingForm",action=prc.xehMailingSend)#
	#html.hiddenField(name="sendMailingID",value="")#
	#html.hiddenField(name="listID",value=prc.list.getListID())#
#html.endForm()#
</cfoutput>
