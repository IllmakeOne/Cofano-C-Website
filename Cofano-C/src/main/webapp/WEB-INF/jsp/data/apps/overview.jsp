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
                        url: "${base}/api/applications",
                        dataSrc: '',
                    },
                    columns: [
                        {
                            data: 'id',
                            render: function (data, type, row, meta) {
                                if (type == "sort" || type == 'type') {
                                    return data;
                                }
                                return '<a class="btn btn-info btn-sm" href="${base}/application/'+ data +'" role="button">' +
                                            '<span data-feather="edit-2"></span>' +
                                       '</a>&nbsp;' +
                                        '<button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-id="' + data + '" data-delete-name="' + escapeHtml(row.name) + '" role="button">' +
                                            '<span data-feather="trash-2"></span>' +
                                        '</button>' ;
                            },
                            class: "seqNum"
                        },
                        { data: 'name', render: $.fn.dataTable.render.text() },
                        {
                            data: 'apikey',
                            render: function (data, type, row, meta) {
                                return "<code>" + escapeHtml(data) + "</code>";
                            }
                        }
                    ],
                    responsive: true,
                    drawCallback: function( settings ) {
                        feather.replace();
                    },
                });

                function myCallbackFunction (updatedCell, updatedRow, oldValue) {
                    console.log("The new value for the cell is: " + updatedCell.data());
                    console.log(updatedRow.data());
                    var data = updatedRow.data();
                    $.ajax({
                        type: "put",
                        url: "${base}/api/applications/" + data.id,
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
                    "onUpdate": myCallbackFunction,
                    "columns": [1],
                    "inputCss": 'form-cotrol',
                    "confirmationButton": { // could also be true
                        "confirmCss": 'btn btn-sm btn-primary',
                        "cancelCss": 'btn btn-sm btn-danger'
                    },
                });

                var deletingRow;
                $(document).on('click', '.btn-delete', function () {
                    $('#delete-name').text($(this).data('delete-name'));
                    $('#delete-confirm').data('delete-url', "${base}/api/applications/" + $(this).data('delete-id'));
                    $('#deleteModal').modal('show');
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
                            $('#deleteModal').modal('hide');
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

                function maxIntValue(table, colSelector) {
                    var valArray = table.column(colSelector)
                        .data()
                        .sort()
                        .reverse();
                    for (var i=0;i<valArray.length;i++) {
                        if (!isNaN(valArray[i])) {
                            return parseInt(valArray[i]);
                        }
                    }
                    return 1;
                }



                $(document).on('click', '#addnew', function () {
                    $.ajax({
                        type: "get",
                        url: "${base}/api/applications/generate",
                        contentType: "application/json",
                        success: function(data) {
                            console.log(data);
                            table.row.add({
                                "id": data.id == 0? maxIntValue(table, ".seqNum") + 1 : data.id,
                                "name": data.name,
                                "apikey": data.apikey
                            }).draw( true );
                        }

                    });

                });
            });


        </script>

    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Applications</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <button role="button" id="addnew" class="btn btn-sm btn-outline-secondary" href="${base}/applications">Add new</button>
                </div>
            </div>
        </div>

        <div class="alert alert-danger alert-dismissible fade show" role="alert" id="error" style="display:none">
            <strong>Holy guacamole!</strong> Something went wrong with inline editing
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <tr>
                <th data-priority="1" style="min-width:90px; max-width: 90px">#</th>
                <th data-priority="1">Name</th>
                <th>API-Key</th>
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
                        <p>Are you really sure you want to delete app with name <code id="delete-name"></code>.</p>
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