<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${base}/DataTables/datatables.min.css"/>
    </jsp:attribute>

    <jsp:attribute name="footer">
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
            <h1 class="h2">Setting</h1>
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

        


    </jsp:body>
</t:dashboard>