<cfoutput>
	<div class="panel panel-primary">
		<!--- Info Box --->
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="fa fa-cogs"></i> Actions
			</h3>
		</div>
		<div class="panel-body">
		<!--- Lists --->
		<button class="btn btn-danger" onclick="return to('#event.buildLink(prc.xehLists)#')">Lists</button>
		<!--- Settings --->
		<cfif prc.oCurrentAuthor.checkPermission("MAILINGLIST_MAILING_ADMIN")>
			<button class="btn" onclick="return to('#event.buildLink(prc.xehSettings)#')" title="Set global mailing list settings">Settings</button>
		</cfif>
	</div>
</div>
</cfoutput>
