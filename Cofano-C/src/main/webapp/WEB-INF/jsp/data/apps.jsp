<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${base}/DataTables/datatables.min.css"/>
    </jsp:attribute>

    <jsp:attribute name="footer">
        <script type="text/javascript" src="${base}/js/dataTables.cellEdit.js"></script>
        <script type="text/javascript" src="${base}/DataTables/datatables.min.js"></script>
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
                                return '<a class="btn btn-info btn-sm" href="'+ data +'" role="button">' +
                                            '<span data-feather="edit-2"></span>' +
                                       '</a>&nbsp;' +
                                        '<a class="btn btn-danger btn-sm" href="'+ data +'" role="button">' +
                                            '<span data-feather="trash-2"></span>' +
                                        '</a>' ;
                            }
                        },
                        { data: 'name' },
                        { data: 'apikey' }
                    ],
                    // columnDefs: [
                    //     {
                    //         "targets": 0,
                    //         "render": function ( data, type, row ) {
                    //             return "<button>Click!" + row[0] + "</button>";
                    //         }
                    //     },
                    //     { "visible": true,  "targets": [ 1 ] }
                    // ],
                    responsive: true,
                    drawCallback: function( settings ) {
                        feather.replace();
                    },
                });

                function myCallbackFunction (updatedCell, updatedRow, oldValue) {
                    console.log("The new value for the cell is: " + updatedCell.data());
                    console.log("The values for each cell in that row are: " + updatedRow.data());
                }

                table.MakeCellsEditable({
                    "onUpdate": myCallbackFunction,
                    "columns": [1,2],
                    "inputCss": 'form-cotrol',
                    "confirmationButton": { // could also be true
                        "confirmCss": 'btn btn-sm btn-primary',
                        "cancelCss": 'btn btn-sm btn-danger'
                    },
                });

            } );
        </script>

    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Applications</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <button class="btn btn-sm btn-outline-secondary">Share</button>
                    <button class="btn btn-sm btn-outline-secondary">Export</button>
                </div>
                <button class="btn btn-sm btn-outline-secondary dropdown-toggle">
                    <span data-feather="calendar"></span>
                    This week
                </button>
            </div>
        </div>

        <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <tr>
                <th data-priority="1">#</th>
                <th data-priority="1">Name</th>
                <th>API-Key</th>
            </tr>
            </thead>

            <tbody>

            </tbody>
        </table>


    </jsp:body>
</t:dashboard>