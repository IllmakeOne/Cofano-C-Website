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
        <script type="text/javascript">
            $(document).ready( function () {
                $('.datatables').DataTable({
                    ajax: {
                        url: "${base}/api/users",
                        dataSrc: '',
                    },
                    columns: [
                        { data: 'id' },
                        { data: 'name' },
                        { data: 'email' },
                        {
                            data: 'lastLoggedIn',
                            render: function (data, type, row, meta) {
                                if (type == "sort" || type == 'type') {
                                    return data;
                                }
                                return new Date(data).toLocaleString();
                            }
                        },
                    ],
                    responsive: true
                });
            } );
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
            <h1 class="h2">Users</h1>
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
                <th>E-mail</th>
                <th>Last login in</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>


    </jsp:body>
</t:dashboard>