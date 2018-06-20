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
            <div class="btn-group mr-2">
    	    <div class="col-sm-4">
         		 <div class="dropdown">
	  				<button class="btn btn-primary dropdown-toggle btn" type="button" data-toggle="dropdown">+
					  <span class="caret"></span></button>
					<ul class="dropdown-menu">
					    <li class="dropdown-item"><a href="${(empty base) ? '.' : base}/addship">Ship</a></li>
			    		<li class="dropdown-item"><a href="${(empty base) ? '.' : base}/addapp">Application</a></li>
					    <li class="dropdown-item"><a href="${(empty base) ? '.' : base}/addcontainer">Container Type</a></li>
				    	<li class="dropdown-item"><a href="${(empty base) ? '.' : base}/addterminal">Terminal</a></li>
					    <li class="dropdown-item"><a href="${(empty base) ? '.' : base}">UNDG</a></li>
			    		<li class="dropdown-item"><a href="${(empty base) ? '.' : base}/addport">Port</a></li>
					 </ul>
				</div>
			</div>
        </div>
        </div>

        <table class="table table-striped table-sm datatables" style="width:100%">
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