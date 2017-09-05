<cfoutput>
<script type="text/javascript">

	function toRecipientForm(){
		var rURL = '#event.buildLink(prc.xehRecipientEditor)#/listID/#prc.list.getListID()#';
		return to(rURL);
	}

	function removeRecipient(recipientID){
		$("##recipientID").val( recipientID );
		$("##recipientsForm").submit();
	}
</script>
</cfoutput>
