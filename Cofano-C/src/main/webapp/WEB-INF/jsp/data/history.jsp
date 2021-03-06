<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${base}/DataTables/datatables.min.css"/>   
        <script type="text/javascript" src="${base}/js/dataTables.cellEdit.js"></script>
        
    </jsp:attribute>

    <jsp:attribute name="footer">
        <script type="text/javascript" src="${base}/DataTables/datatables.min.js"></script>
        <script type="text/javascript">
            $(document).ready( function () {
                $('.datatables').DataTable({
                    ajax: {
                        url: "${base}/api/history",
                        dataSrc: '',
                    },
                    columns: [
                        { data: 'title', render: $.fn.dataTable.render.text() },
                        { data: 'message', render: $.fn.dataTable.render.text() },
                        { data: 'type', render: $.fn.dataTable.render.text() },
                        {
                            data: 'addedAt',
                            render: function (data, type, row, meta) {
                                if (type == "sort" || type == 'type') {
                                    return data;
                                }
                                return new Date(data).toLocaleString('en-GB', { timeZone: 'UTC' });
                            }
                        },
                    ],
                    order: [[ 3, "desc" ]],
                    responsive: true
                });
            } );
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Recently added data</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
            </div>
        </div>

        <table class="table table-striped table-sm datatables" style="width:100%">
            <thead>
            <tr>
                <th data-priority="1">Title</th>
                <th data-priority="1">Message</th>
                <th data-priority="1">Type</th>
                <th>Added at</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>


    </jsp:body>
</t:dashboard>