<cfoutput>
<!--- Custom JS --->
<script type="text/javascript">
	$(document).ready(function(){
		var content = CKEDITOR.replace( 'content',
		{
			toolbarGroups: [
				{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
				{ name: 'links' },
				{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
				{ items: [ 'Source' ] }
			]
		});
	});

	function toMailingForm(){
		var rURL = '#event.buildLink(prc.xehMailingEditor)#/listID/#prc.mailing.getList().getListID()#';
		return to(rURL);
	}
</script>
</cfoutput>
