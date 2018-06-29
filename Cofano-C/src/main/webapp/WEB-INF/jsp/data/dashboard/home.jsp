<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:dashboard>

    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${base}/DataTables/datatables.min.css"/>
    </jsp:attribute>

    <jsp:attribute name="footer">
        <script type="text/javascript" src="${base}/DataTables/datatables.min.js"></script>
        <script type="text/javascript" src="${base}/js/dataTables.cellEdit.js"></script>
        <script type="text/javascript">
        $(document).ready( function () {
            var table = $('.datatables').DataTable({
                ajax: {
                    url: "${base}/api/ports/unapproved",
                    dataSrc: '',
                },
                columns: [
                    {
                        data: 'id',
                        render: function (data, type, row, meta) {
                            if (type == "sort" || type == 'type') {
                                return data;
                            }
                            return '<a class="btn btn-info btn-sm" href="${base}/port/'+ data +'" role="button">' +
                                '<span data-feather="check-sqare"></span>' +
                                '</a>&nbsp;' +
                                '<button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-id="' + data + '" data-delete-name="' + escapeHtml(row.name) + '" role="button">' +
                                '<span data-feather="trash-2"></span>' +
                                '</button>' ;
                        }
                    },
                    { data: 'name', render: $.fn.dataTable.render.text() },
                    { data: 'unlo', render: $.fn.dataTable.render.text() },
                ],
                responsive: true,
                drawCallback: function( settings ) {
                    feather.replace();
                },
            });


                var deletingRow;
                $(document).on('click', '.btn-delete', function () {
                    $('#delete-name').text($(this).data('delete-name'))
                    $('#delete-confirm').data('delete-url', "${base}/api/containers/" + $(this).data('delete-id'))
                    $('#deleteModal').modal('show')
                    deletingRow = $(this).parents('tr');
                });

                $(document).on('click', '#delete-confirm', function () {
                    $.ajax({
                        type: "delete",
                        url: $('#delete-confirm').data('delete-url'),
                        beforeSend: function( xhr ) {
                            $("#delete-error").hide();
                        },
                        success: function(data) {
                            $('#deleteModal').modal('hide')
                            table
                                .row( deletingRow )
                                .remove()
                                .draw();
                        },
                        error: function(data) {
                            $("#delete-error").show();
                        },
                    });
                });
            });
        </script>
        </jsp:attribute>

<jsp:body>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h2 id="title" class="h2">Dashboard</h2>
    <div class="btn-toolbar mb-2 mb-md-0">
        <div class="btn-group mr-2">
         <div class="col-sm-6">
         		 <c:import url="/WEB-INF/jsp/addButton.jsp"/>
				</div>
        </div>
         
    </div>
</div>



 <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <h3>Ports</h3>
            <tr>
                <th data-priority="1">#</th>
                <th data-priority="1">Name</th>
                <th>Unlo</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
              
              
              <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <h3>Terminals</h3>
            <tr>
                <th data-priority="1">#</th>
                <th data-priority="1">Name</th>
                <th>Terminal Code</th>
                <th>Type</th>
                <th>Unlo</th>
                <th>Port id</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        
        <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <h3>Ships</h3>
            <tr>
                <th data-priority="1">#</th>
                <th data-priority="1">Name</th>
                <th>IMO</th>
                <th>CallSign</th>
                <th>MMSI</th>
                <th>Depth</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        
        <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <h3>Container Types</h3>
            <tr>
                <th data-priority="1">#</th>
                <th data-priority="1">Display name</th>
                <th>ISO-code</th>
                <th>Description</th>
                <th>Length</th>
                <th>Height</th>
                <th>Reefer</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        
        
    </jsp:body>
</t:dashboard>
