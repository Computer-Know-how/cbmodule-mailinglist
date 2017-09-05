<cfoutput>
<script type="text/javascript">

	function toMailingForm(){
		var rURL = '#event.buildLink(prc.xehMailingEditor)#/listID/#prc.list.getListID()#';
		return to(rURL);
	}

	function sendMailing(mailingID){
		$("##sendMailingID").val( mailingID );
		$("##sendingForm").submit();
	}

	function removeMailing(mailingID){
		$("##mailingID").val( mailingID );
		$("##mailingForm").submit();
	}
</script>
</cfoutput>
