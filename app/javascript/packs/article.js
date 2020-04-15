import dt from 'datatables.net-dt'
jQuery.fn.dataTable = dt

jQuery(document).ready(function() {
  jQuery('#article-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": jQuery('#article-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "id"},
      {"data": "preview"},
      {"data": "description"},
      {"data": "author"}
    ]
  });
});
