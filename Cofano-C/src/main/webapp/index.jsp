
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

<jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${(empty base) ? '.' : base}/DataTables/datatables.min.css"/>
    </jsp:attribute>

    <jsp:attribute name="footer">
        <script type="text/javascript" src="${(empty base) ? '.' : base}/DataTables/datatables.min.js"></script>
        <script type="text/javascript" src="${(empty base) ? '.' : base}/js/dataTables.cellEdit.js"></script>
        <script type="text/javascript">
        $(document).ready( function () {
        	var empties = 0;
            var portstable = $('#portstable').DataTable({
                ajax: {
                    url: "${(empty base) ? '.' : base}/api/ports/unapproved",
                    dataSrc: '',
                },
                columns: [
                    {
                        data: 'id',
                        render: function (data, type, row, meta) {
                            if (type == "sort" || type == 'type') {
                                return data;
                            }
                            return '<button type="button" class="btn btn-info btn-sm btn-approve" data-approve-id="' + data 
								+ '" data-approve-name="' + escapeHtml(row.displayName) + '" data-type="ports" role="button">' + 
				   				  '<span data-feather="check-square"></span>' +
			  					  '</button>&nbsp;' +
                                
                                '<button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-id="' + data
										+ '" data-delete-name="' + escapeHtml(row.name) + '"data-type="ports" role="button">' +
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
                    /*
                    console.log(this.data());
                    if(!this.data().any()){
                    	this.destroy();
                    	document.getElementById("portstable").outerHTML = "";
                    	document.getElementById("portname").outerHTML = "";
                    	empties +=1;
                    }
                    */
                },
            });	
          //  console.log(portstable.data());
            
            
            
                var terminaltable = $(' #terminalstable').DataTable({
                    ajax: {
                        url: "${(empty base) ? '.' : base}/api/terminals/unapproved",
                        dataSrc: '',
                    },
                    columns: [
                        {
                            data: 'id',
                            render: function (data, type, row, meta) {
                                if (type == "sort" || type == 'type') {
                                    return data;
                                }
                                return '<button type="button" class="btn btn-info btn-sm btn-approve" data-approve-id="' + data 
    									+ '" data-approve-name="' + escapeHtml(row.displayName) + '" data-type="terminals" role="button">' + 
        				   			  '<span data-feather="check-square"></span>' +
         			  				  '</button>&nbsp;' +
                                    
                                    '<button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-id="' + data 
                                    		+ '" data-delete-name="' + escapeHtml(row.name) + '" data-type="terminals" role="button">' +
                                    '<span data-feather="trash-2"></span>' +
                                    '</button>' ;
                            }
                        },
                        { data: 'name', render: $.fn.dataTable.render.text() },
                        { data: 'terminalCode', render: $.fn.dataTable.render.text() },
                        { data: 'type', render: $.fn.dataTable.render.text() },
                        { data: 'unlo', render: $.fn.dataTable.render.text() },
                        { data: 'portId', render: $.fn.dataTable.render.text() },
                    ],
                    responsive: true,
                    drawCallback: function( settings ) {
                        feather.replace();/*
                        if(!this.data().any()){
                        	this.destroy();
                        	document.getElementById("terminalstable").outerHTML = "";
                        	document.getElementById("termname").outerHTML = "";
                        	empties+=1;
                        }*/
                    },
                });
                
                var shipstable = $('#shipstable').DataTable({
                    ajax: {
                        url: "${(empty base) ? '.' : base}/api/ships/unapproved",
                        dataSrc: '',
                    },
                    columns: [
                        {
                            data: 'id',
                            render: function (data, type, row, meta) {
                                if (type == "sort" || type == 'type') {
                                    return data;
                                }
                                return '<button type="button" class="btn btn-info btn-sm btn-approve" data-approve-id="' + data 
            							+ '" data-approve-name="' + escapeHtml(row.displayName) + '" data-type="ships" role="button">' + 
              				   		  '<span data-feather="check-square"></span>' +
               			  			  '</button>&nbsp;' +
                                    
                                    '<button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-id="' + data
                                    		+ '" data-delete-name="' + escapeHtml(row.name) + '" data-type="ships" role="button">' +
                                    '<span data-feather="trash-2"></span>' +
                                    '</button>' ;
                            }
                        },
                        { data: 'name', render: $.fn.dataTable.render.text() },
                        { data: 'imo', render: $.fn.dataTable.render.text() },
                        { data: 'callSign', render: $.fn.dataTable.render.text() },
                        { data: 'mmsi', render: $.fn.dataTable.render.text() },
                        { data: 'depth', render: $.fn.dataTable.render.text() },
                    ],
                    responsive: true,
                    drawCallback: function( settings ) {
                        feather.replace();/*
                        if(!this.data().any()){
                        	this.destroy();
                        	document.getElementById("shipstable").outerHTML = "";
                        	document.getElementById("shipname").outerHTML = "";
                        	empties+=1;
                        }*/
                    },
                });
                
                var containerstable = $('#containerstable').DataTable({
                    ajax: {
                        url: "${(empty base) ? '.' : base}/api/containers/unapproved",
                        dataSrc: '',
                    },
                    columns: [
                        {
                            data: 'id',
                            render: function (data, type, row, meta) {
                                if (type == "sort" || type == 'type') {
                                    return data;
                                }
                                return  '<button type="button" class="btn btn-info btn-sm btn-approve" data-approve-id="' + data 
                        					+ '" data-approve-name="' + escapeHtml(row.displayName) + '" data-type="containers" role="button">' + 
                           				     '<span data-feather="check-square"></span>' +
                            			    '</button>&nbsp;' +
                                    
                                    '<button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-id="' + data 
                                    		+ '" data-delete-name="' + escapeHtml(row.displayName) + '" data-type="containers" role="button">' + 
                                    '<span data-feather="trash-2"></span>' +
                                    '</button>' ;
                            }
                        },
                        { data: 'displayName', render: $.fn.dataTable.render.text() },
                        { data: 'isoCode', render: $.fn.dataTable.render.text() },
                        { data: 'description', render: $.fn.dataTable.render.text() },
                        { data: 'length', render: $.fn.dataTable.render.text() },
                        { data: 'height', render: $.fn.dataTable.render.text() },
                        { data: 'reefer', render: $.fn.dataTable.render.text() },
                    ],
                    responsive: true,
                    drawCallback: function( settings ) {
                        feather.replace();        /*                
                        if(!this.data().any()){
                        	this.destroy();
                        	document.getElementById("containerstable").outerHTML = "";
                        	document.getElementById("conname").outerHTML = "";
                        	empties+=1;
                        }*/
                        
                    },
                });
                
                var undgstable = $('.undgstable').DataTable({
                    ajax: {
                        url: "${base}/api/undgs/full/unapproved",
                        dataSrc: '',
                    },
                    columns: [
                        {
                            data: 'id',
                            render: function (data, type, row, meta) {
                                if (type == "sort" || type == 'type') {
                                    return data;
                                }
                                return '<button type="button" class="btn btn-info btn-sm btn-approve" data-approve-id="' + data 
            					+ '" data-approve-name="' + escapeHtml(row.displayName) + '" data-type="undgs" role="button">' + 
              				     '<span data-feather="check-square"></span>' +
               			    '</button>&nbsp;' +
                       
                       '<button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-id="' + data 
                       		+ '" data-delete-name="' + escapeHtml(row.displayName) + '" data-type="undgs" role="button">' + 
                       '<span data-feather="trash-2"></span>' +
                       '</button>' ;
                            },
                            "width": "90px"
                        },
                        { data: 'unNo', render: $.fn.dataTable.render.text(), width: "10px" },
                        {
                            data: 'descriptions',
                            render: function (data, type, row, meta) {
                                // if (type == "sort" || type == 'type') {
                                //     return data;
                                // }
                                filteredData = data.filter(
                                    function(desc){
                                        if (desc.language == 'en') {
                                            return desc.description;
                                        }
                                    }
                                );
                                if (filteredData[0] !== undefined) {
                                    return escapeHtml(filteredData[0].description);
                                } else {
                                    return "<i>Not set</i>";
                                }
                            },
                            width: "20%"
                        },
                        { data: 'transportForbidden', render: $.fn.dataTable.render.text() },
                        { data: 'collective', render: $.fn.dataTable.render.text() },
                        { data: 'notApplicable', render: $.fn.dataTable.render.text() },
                        { data: 'classificationCode', render: $.fn.dataTable.render.text() },
                        { data: 'classification', render: $.fn.dataTable.render.text() },
                        { data: 'packingGroup', render: $.fn.dataTable.render.text() },
                        { data: 'hazardNo', render: $.fn.dataTable.render.text() },
                        { data: 'station', render: $.fn.dataTable.render.text() },
                        { data: 'transportCategory', render: $.fn.dataTable.render.text() },
                        { data: 'tunnelCode', render: $.fn.dataTable.render.text() },
                        { data: 'vehicleTankCarriage', render: $.fn.dataTable.render.text() },
                        {
                            data: 'labels',
                            render: function (data, type, row, meta) {
                                if (data !== undefined) {
                                    if (type == "sort" || type == 'type') {
                                        return data;
                                    }
                                    return escapeHtml(data.sort().join(", "));
                                }
                            },
                        },
                        {
                            data: 'tankSpecialProvisions',
                            render: function (data, type, row, meta) {
                                if (data !== undefined) {
                                    if (type == "sort" || type == 'type') {
                                        return data;
                                    }
                                    return escapeHtml(data.sort().join(", "));
                                }
                            },
                        },
                        {
                            data: 'tankCode',
                            render: function (data, type, row, meta) {
                                if (data !== undefined) {
                                    if (type == "sort" || type == 'type') {
                                        return data;
                                    }
                                    return escapeHtml(data.sort().join(", "));
                                }
                            },
                        },
                    ],
                    order: [[ 1, "asc" ]],
                    responsive: true,
                    drawCallback: function( settings ) {
                        feather.replace();
                    },
                });
                
                var approvingRow;
                $(document).on('click', '.btn-approve', function () {
                	approvingRow = $(this).parents('tr');
                    $.ajax({
                        type: "put",
                        url: "${(empty base) ? '.' : base}/api/"+ $(this).data('type')+ "/approve/" + $(this).data('approve-id'),
                        beforeSend: function( xhr ) {
                            $("#delete-error").hide();
                        },
                        success: function(data) {
                        	//console.log(deletingRow.closest('table'))
                            approvingRow.closest('table').DataTable()
                                .row( approvingRow )
                                .remove()
                                .draw();
                        },
                        error: function(data) {
                            $("#delete-error").show();
                        },
                    });
                });

                var deletingRow;
                $(document).on('click', '.btn-delete', function () {
                    deletingRow = $(this).parents('tr');
                    $.ajax({
                        type: "delete",
                        url: "${(empty base) ? '.' : base}/api/"+ $(this).data('type')+ "/unapproved/" + $(this).data('delete-id'),
                        beforeSend: function( xhr ) {
                            $("#delete-error").hide();
                        },
                        success: function(data) {
                        	//console.log(deletingRow.closest('table'))
                            deletingRow.closest('table').DataTable()
                                .row( deletingRow )
                                .remove()
                                .draw();
                        },
                        error: function(data) {
                            $("#delete-error").show();
                        },
                    });
                });
                
             
              
                /*
                
                if(empties === 4){
                	document.getElementById("title").outerHTML = "<h2>Nothing to be approved</h2>";
                } else {
                	document.getElementById("title").outerHTML = "<h3>These entries need approval</h3>";
                }
                */
                


           });
        </script>
        
        </jsp:attribute>
    <jsp:body>

        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3>
            <h1 class=" h2">UNDG's</h1>
            <div class="btn-group mr-2">
                <div class="col-sm-4">
                   <c:import url="/WEB-INF/jsp/addButton.jsp"/>
                </div>
            </div>
        </div>





					<div class="alert alert-danger alert-dismissible fade show" role="alert" id="delete-error" style="display:none">
                            <strong>Holy guacamole!</strong> Something went wrong while deleting
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

<h3 id = "title">These entries need approval</h3>

			

 			<table class="table table-striped table-sm datatables" style="width:100%" id="portstable" >
         	   <thead>
         		  <h3 id = "portname" >Ports</h3>
       				     <tr>
             		       <th data-priority="1">#</th>
           			     <th data-priority="1">Name</th>
           			     <th>Unlo</th>
           				 </tr>
          			  </thead>
          		  <tbody>
         		   </tbody>
       			</table>
              
              
              <table class="table table-striped table-sm datatables" style="width:100%" id = "terminalstable">
            <thead>
            <h3 id = "termname" >Terminals</h3>
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
        
        <table class="table table-striped table-sm datatables" style="width:100%" id="shipstable"> 
            <thead>
            <h3 id = "shipname" >Ships</h3>
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
        
        <table class="table table-striped table-sm datatables" style="width:100%" id="containerstable">
            <thead>
            <h3 id = "conname" >Container Types</h3>
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
        
         <table class="table table-striped table-sm datatables" style="width:100%; id="undgstable"">
            <thead>
            <h3 id = "undgsname" >UNDGs</h3>
            <tr>
                <th data-priority="1" style="min-width:90px">#</th>
                <th data-priority="1">uNo</th>
                <th data-priority="1" style="min-width:160px">English Description</th>
                <th>Transport Forbidden</th>
                <th>Collective</th>
                <th>Not Applicable</th>
                <th>Classification Code</th>
                <th>Classification</th>
                <th>Packing Group</th>
                <th>Hazard No.</th>
                <th>Station</th>
                <th>Transport Category</th>
                <th>Tunnel Code</th>
                <th>Vehicle Tank Carriage</th>
                <th>Labels</th>
                <th>Tank Special Provisions</th>
                <th>Tank Codes</th>
            </tr>
            </thead>

            <tbody>

            </tbody>
        </table>
        
    </jsp:body>
</t:dashboard>
