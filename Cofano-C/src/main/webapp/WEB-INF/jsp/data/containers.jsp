<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css"/>
    </jsp:attribute>

    <jsp:attribute name="footer">
        <script type="text/javascript" src="DataTables/datatables.min.js"></script>
        <script type="text/javascript">
            $(document).ready( function () {
                $('.datatables').DataTable({
                    ajax: {
                        url: "${base}/api/containers",
                        dataSrc: '',
                    },
                    columns: [
                        { data: 'id' },
                        { data: 'displayName' },
                        { data: 'isoCode' },
                        { data: 'description' },
                        { data: 'length' },
                        { data: 'height' },
                        { data: 'reefer' }
                    ],
                    responsive: true
                });
            } );
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Container types</h1>
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

        <table class="table table-striped table-sm datatables">
            <thead>
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