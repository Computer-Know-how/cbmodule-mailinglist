<cfoutput>
<!--- Recipient Form --->
#html.startForm(name="recipientsForm",action=prc.xehRecipientRemove)#
#html.hiddenField(name="recipientID",value="")#
#html.hiddenField(name="listID",value=prc.list.getListID())#
<!--- Content Bar --->
<div class="contentBar">

	<div class="well well-sm">
	<div class="btn-group btn-sm pull-right">
		<button class="btn btn-sm btn-primary" onclick="toRecipientForm(); return false;" title="Add a new recipient">Add Recipient</button>
	</div>

	<div class="form-group form-inline no-margin">
		<input type="text" name="recipientFilter" size="30" class="form-control" placeholder="Quick Filter" id="recipientFilter">
	</div>
</div>

<!--- Recipients --->
<table id="recipients" class="table table-striped">
	<thead>
		<tr>
			<th>Email</th>
			<th width="75" class="center {sorter:false}">Actions</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#prc.recipients#" index="recipient">
		<tr id="recipientid-#recipient.getRecipientID()#">
			<td><a href="#event.buildLink(prc.xehRecipientEditor)#/recipientID/#recipient.getRecipientID()#" title="Edit #recipient.getEmail()#">#recipient.getEmail()#</a></td>

			<td class="text-center">
			<!--- Edit Command --->
			<a class="btn btn-info btn-sm" href="#event.buildLink(prc.xehListEditor)#/recipientID/#recipient.getRecipientID()#"
			title="Edit #recipient.getEmail()#"><i class="fa fa-pencil"></i></a>
			<!--- Delete Command --->
			<a class="btn btn-danger btn-sm confirmIt" title="Delete Recipient" href="javascript:removeRecipient('#recipient.getRecipientID()#')" data-title="Delete Recipient?"><i id="delete_#recipient.getRecipientID()#" class="fa fa-trash"></i></a>
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>
#html.endForm()#
</cfoutput>
