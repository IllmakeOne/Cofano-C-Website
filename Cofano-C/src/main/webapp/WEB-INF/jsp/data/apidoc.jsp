<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>



    

    <jsp:body>
    <style>
    
	h4 
	{ 
	color:#ff8c1a;
	font-size:190%;
	}
		
	h5 {
 	color:#ff8c1a; 
	font-size:120%;
	}	
	
	h6 
	{
 	color:#1aa3ff; 
	}
		
	h7 
	{
 	color:#ff471a; 
	}
	
	h8 
	{
 	color:#ffbf00; 
	}
	
	h9 
	{
 	color:#00ff99; 
	}

</style>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
       	
        </div>
        <h2>API Documentation</h2>
        
        When adding or editing an entry, the request must contain a JSON object stuctured like the ones received from the DBs
	<div>	  
	    <table class="table table-striped table " style="width:100%">
            <thead>
            <tr>
		        <th></th>
		        <th><h5>Ships</h5></th>
		        <th><h5>Ports</h5></th>
		        <th><h5>Terminals</h5></th>
		        <th><h5>Container Types</h5></th>
		        <th><h5>UNDGS</h5></th>
		    </tr>
             <tr>
		        <th><h5>Get all</h5></th>
		        <th><h6>GET</h6> ./ships</th>
		        <th><h6>GET</h6> ./ports</th>
		        <th><h6>GET</h6> ./terminals</th>
		        <th><h6>GET</h6> ./containers</th>
		        <th><h6>GET</h6> ./undgs</th>
		    </tr>
		    <tr>
		        <th><h5>Get a certain entry</h5></th>
		        <th><h6>GET</h6> ./ships/{id}</th>
		        <th><h6>GET</h6> ./ports/{id}</th>
		        <th><h6>GET</h6> ./terminals/{id}</th>
		        <th><h6>GET</h6> ./containers/{id}</th>
		        <th><h6>GET</h6> ./undgs/{id}</th>
		    </tr>
		    <tr>
		        <th><h5>Delete a certain entry</h5></th>
		        <th><h7>DELETE</h7> ./ships/{id}</th>
		        <th><h7>DELETE</h7> ./ports/{id}</th>
		        <th><h7>DELETE</h7> ./terminals/{id}</th>
		        <th><h7>DELETE</h7> ./containers/{id}</th>
		        <th><h7>DELETE</h7> ./undgs/{id}</th>
		    </tr>
		    
		    <tr>
		        <th><h5>Adding a new entry</h5></th>
		        <th><h8>POST</h8> ./ships/add</th>
		        <th><h8>POST</h8> ./ports/add</th>
		        <th><h8>POST</h8> ./terminals/add</th>
		        <th><h8>POST</h8> ./containers/add</th>
		        <th><h8>POST</h8> ./undgs/add</th>
		    </tr>
		    
		     <tr>
		        <th><h5>Editing a certain entry</h5></th>
		        <th><h9>PUT</h9> ./ships/{id}</th>
		        <th><h9>PUT</h9> ./ports/{id}</th>
		        <th><h9>PUT</h9> ./terminals/{id}</th>
		        <th><h9>PUT</h9> ./containers/{id}</th>
		        <th><h9>PUT</h9> ./undgs/{id}</th>
		    </tr>
            </thead>

            <tbody>

            </tbody>
        </table>
	</div>
    </jsp:body>
</t:dashboard>