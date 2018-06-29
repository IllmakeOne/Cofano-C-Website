<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


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
                        url: "${base}/api/ports",
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
                                    '<span data-feather="edit-2"></span>' +
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

                function inlineEditCallback (updatedCell, updatedRow, oldValue) {
                    $.ajax({
                        type: "put",
                        url: "${base}/api/containers/" + updatedRow.data().id,
                        data: JSON.stringify(updatedRow.data()),
                        success: function(data) {
                            $("#error").hide();
                        },
                        error: function(data) {
                            $("#error").show();
                        },
                        contentType: "application/json",
                        dataType: 'json'
                    });
                }

                table.MakeCellsEditable({
                    "onUpdate": inlineEditCallback,
                    "columns": [1,2],
                    "inputCss": 'form-cotrol',
                    "confirmationButton": { // could also be true
                        "confirmCss": 'btn btn-sm btn-primary',
                        "cancelCss": 'btn btn-sm btn-danger'
                    },
                });

                var deletingRow;
                $(document).on('click', '.btn-delete', function () {
                    $('#delete-name').text($(this).data('delete-name'))
                    $('#delete-confirm').data('delete-url', "${base}/api/ports/" + $(this).data('delete-id'))
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
            <h1 class="h2">Ports</h1>
            <div class="btn-group mr-2">
    	    <div class="col-sm-4">
         		 <c:import url="/WEB-INF/jsp/addButton.jsp"/>
			</div>
        </div>
        </div>

        <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <tr>
                <th data-priority="1">#</th>
                <th data-priority="1">Name</th>
                <th>Unlo</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>

        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="delete modal" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm deletion</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert" id="delete-error" style="display:none">
                            <strong>Holy guacamole!</strong> Something went wrong while deleting
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <p>Are you really sure you want to delete port with name <code id="delete-name"></code>.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-delete-url="" id="delete-confirm">Yes delete it</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>


    </jsp:body>
</t:dashboard>