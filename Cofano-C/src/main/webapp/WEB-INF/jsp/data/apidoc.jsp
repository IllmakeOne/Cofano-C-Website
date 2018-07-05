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
	font-size:130%;
	}	
	
	h12 
	{
 	color:#1aa3ff; 
	}
		
	h7 
	{
 	color:#ff471a; 
	}
	
	h8 
	{ 
 	color:#00ff99;
	}
	
	h9 
	{
 	color:#ffbf00; 
	}
	h10 
	{
	font-size:110%;
	}

</style>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
       	
      </div>
        <h2>API Documentation</h2>
        	
        	<h5>General for adding, editing and deleting</h5>
      	    <h10>	To see the exact form of any object please look at the received Json documents by making calls to the api.</h10>
      	    <h10> <br> All entries which are edited or added through API are unapproved and await approval by a Cofano employee</h10>
      	    
  			<p><h10> When making an edit(<h9>PUT</h9>) or adding (<h8>POST</h8>) a new entry, 
  			in the request there must be a json object. This applies for all the types of entries.
  			</h10></p>
  			
  			<p><h10> Deletion is direct and permanet. 
  			We advise making the delete function hard to reach in your applications to limit its use by non-Cofano users.
  			</h10></p>
  			
  			<h5>Conflicts</h5>
  			<p><h10> When testing for conflicts, the attribute specifed is tested to not be the exact same as another entry in the table.
  			</h10></p><h10>Null values do not create conflicts</h10>
  			<p><h10> If there is a conflict, the api requester will receive back a JSON object with a title and a description of why the conflict occurred.</h10></p>
  			
  		<div class="row">
  			<div class="col-sm-6">
  				<h5>Ships</h5>
  				<h10> IMO and name must be not null when editing or adding</h10>
  				<h10><p>IMO,MMSI and Callsign are taken into account when testing for conflicts.</p></h10>		
  			</div>
 			 <div class="col-sm-6">
				<h5>Ports</h5>
  				<h10> Name must be not null when editing or adding</h10>
  				<h10><p>Name and Unlo are taken into account when testing for conflicts.  </p></h10>	
			</div>
		</div>
		
		<div class="row">
  			<div class="col-sm-6">
  				<h5>Terminals</h5>
  				<h10> Name, terminal_code and port_id must be not null when editing or adding</h10>
				<h10>When adding or editing an terminal, please take into accout it has a foreign key to Ports. <br> </h10>
				<h10>A <h12>GET</h12> request came be made to ./terminals/portids to receive all available ports</h10>
  				<h10><p>Name and Terminal code are taken into account when testing for conflicts.  </p></h10>
  			</div>
 			 <div class="col-sm-6">
				<h5>Container Types</h5>
  				<h10> Display name, length and height must be not null when editing or adding</h10>
  				<h10><p>Display name and ISO-code are taken into account when testing for conflicts.  </p></h10>	
			</div>
		</div>
		
		<div class="row">
  			<div class="col-sm-12">
  				<h5>UNDGs</h5>
  				<h10> UNDGs have lables, tankcodes and tanks special provisions. 
  				<p> All of them can be retrived by making a <h12>GET</h12> request at:
  				<p> ./ungs/labels for available lables</p>
  				<p> ./ungs/tankcodes for available tankcodes</p>
  				<p> ./undgs/tankspecialprovisions for available special tank provisions</p>
  				</p></h10>
  			</div>
		</div>
        
   
		<p>  <h5>All API request are required to have an "Authorization" header which has as value "Bearer" + " " + "APIkey", the api key
		is assiged by cofano. 
		</h5><h10>These API keys must be stored in the database in the Applications table.</h10></p>	
		<p><h10> <h12>GET</h12>, <h7>DELETE</h7>, <h8>POST</h8>, <h9>PUT</h9> are the types of HTTP request.</h10></p>
	  
	<h5> The "<h12>.</h12>" in "<h12>./</h12>" stands for <h12>" http://farm05.ewi.utwente.nl:7027/Cofano-C/<h7>api/</h7>"</h12></h5>
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
		        <th><h12>GET</h12> ./ships</th>
		        <th><h12>GET</h12> ./ports</th>
		        <th><h12>GET</h12> ./terminals</th>
		        <th><h12>GET</h12> ./containers</th>
		        <th><h12>GET</h12> ./undgs/full</th>
		    </tr>
		    <tr>
		        <th><h5>Get a certain entry</h5></th>
		        <th><h12>GET</h12> ./ships/{id}</th>
		        <th><h12>GET</h12> ./ports/{id}</th>
		        <th><h12>GET</h12> ./terminals/{id}</th>
		        <th><h12>GET</h12> ./containers/{id}</th>
		        <th><h12>GET</h12> ./undgs/{id}</th>
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