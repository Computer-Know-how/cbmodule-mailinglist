<cfoutput>
<script type="text/javascript">
	$(document).ready(function() {
		$("##listTable").dataTable({
			"paging": false,
			"info": false,
			"searching": false,
			"columnDefs": [
			{
				"orderable": false,
				"targets": '{sorter:false}'
			}
			],
			"order": []
		});

		$("##listFilter").keyup(function(){
			$.uiTableFilter( $("##listTable"), this.value );
		})
	});

	function removeList(listID){
		$("##listID").val( listID );
		$("##lists").submit();
	}
</script>
</cfoutput>
