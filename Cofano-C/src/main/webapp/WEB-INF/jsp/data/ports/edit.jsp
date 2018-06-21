<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            
            var restServlet = "${base}/api/ports/";
            
            
            
            
            function addShip(){
            	
            	
            	var name = document.getElementById("addname");
            	var unlo = document.getElementById("addunlo");
            	
            	if(name.value == ""){
            		alert("Please fill in at least the name");	
            	} else {
            		var json = {"unlo": unlo.value, "name":name.value};
            	
            		let	xmlhttp = new XMLHttpRequest();
            		xmlhttp.open("POST", restServlet+"add", true);
            		xmlhttp.setRequestHeader('Content-Type', 'application/json');
            		
            		xmlhttp.send(JSON.stringify(json));	
          
            		alert("Entry added to Database!");

            		window.location.replace("ports");	
            	}
            }
            $(document).keypress(function (e) {
            	  if(e.which == 13 && e.target.nodeName != "TEXTAREA") return false;
            	});
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="row">
            <div class="col-sm-8">
                <h2 style="margin: 20px" >Add Port</h2>
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
                  <td>Name</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder="TestName" id="addname" autocomplete="off">
		    		</form>
                  </td>
                </tr>
 				<tr>
                  <td>Unlo</td> 
                  <td><form>
		     			 <input type="text" placeholder=" UnloExample " id="addunlo" autocomplete="off">
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