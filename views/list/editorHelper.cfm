<cfoutput>
<script type="text/javascript">
$(document).ready(function() {
			// quick filter
			$("##mailingFilter").keyup(function(){
				$.uiTableFilter( $("##mailings"), this.value );
			});

			$("##mailings").dataTable({
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
				})

			$("##recipientFilter").keyup(function(){
				$.uiTableFilter( $("##recipients"), this.value );
			});

			$("##recipients").dataTable({
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
			})

		});

</script>
</cfoutput>
