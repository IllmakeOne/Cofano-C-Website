<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            
            var restServlet = "${base}/api/ships/add";
            
            function addShip(){
            	
            	
            	var name = document.getElementById("addname");
            	var imo = document.getElementById("addimo");
            	var callsign = document.getElementById("addcallsign");
            	var mmsi = document.getElementById("addmmsi");
            	var depth = document.getElementById("adddepth");
            	
            	if(imo.value == ""){
            		alert("Please fill in at least IMO");	
            	} else {
            		var json = {"imo": imo.value, "name":name.value,"callsign":callsign.value,
            				"mmsi":mmsi.value,"depth":depth.value};
            	
            		let	xmlhttp = new XMLHttpRequest();
            		xmlhttp.open("POST", restServlet, true);
            		xmlhttp.setRequestHeader('Content-Type', 'application/json');
            		
            		xmlhttp.send(JSON.stringify(json));	
          
            		alert("Entry added to Database!");

            		window.location.replace("ships");	
            	}
            };    
            
            $(document).keypress(function (e) {
            	  if(e.which == 13 && e.target.nodeName != "TEXTAREA") return false;
            	});
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="row">
            <div class="col-sm-8">
                <h2 style="margin: 20px" >Add Ship</h2>
            </div>
        </div>
        <div class="col-sm-12">	
          <div class="table-responsive" style="margin: 35px">
            <table class="table table-striped table-sm">
              <thead>
                <tr>
                  <th><h5>Field</h5></th>
                  <th><h5>Data</h5></th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>IMO</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=12345AB id="addimo" autocomplete="off">
		    		</form>
                  </td>
                </tr>
 				<tr>
                  <td>Name</td> 
                  <td><form>
		     			 <input type="text" placeholder=" McBoatFace " id="addname" autocomplete="off">
		    		</form>
		    		</td>
                </tr>
                <tr>
                <tr>
                  <td>Callsign</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" BF45" id="addcallsign" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                <tr>
                <tr>
                  <td>MMSI</td> 
                  <td>
                	<form	>
		     			 <input type="text"  placeholder=" 456465ABC" id="addmmsi" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                <tr>
                  <td>Depth</td> 
                  <td>
                	<form	>
		     			 <input type="number" step="0.01" min="1" max="999" placeholder=" 5.5 " id="adddepth" autocomplete="off">
		    		</form>
                  </td>
                  </tr>
                  <tr>
                	<td> </td>
                  <td>
                  	<button type="button" class="btn" onclick="addShip()">
					    	Add Information 
					</button>
		    		</td>
                </tr>
              
              </tbody>
            </table>
          </div>   
    
			</div>
    </jsp:body>
</t:dashboard>