<cfoutput>
<!--- Custom JS --->
<script type="text/javascript">
	function toRecipientForm(){
		var rURL = '#event.buildLink(prc.xehRecipientEditor)#/listID/#prc.recipient.getList().getListID()#';
		return to(rURL);
	}
</script>
</cfoutput>
