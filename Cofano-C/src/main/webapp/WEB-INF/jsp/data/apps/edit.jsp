<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            
            var restServlet = "${base}/api/applications/add";
            
            function addApp(){
            	var name = document.getElementById("addname");
            	var api = document.getElementById("addapi");
            	if(name.value == "" || api.value == ""){
            		alert("Please fill in all the boxes");	
            	} else {
            		var json = {"name": name.value, "apikey":api.value};
            		let	xmlhttp = new XMLHttpRequest();
            		xmlhttp.open("POST", restServlet, true);
            		xmlhttp.setRequestHeader('Content-Type', 'application/json');
            		xmlhttp.send(JSON.stringify(json));	
            		
            		alert("Entry added to Database!");

            		window.location.replace("applications");
            		
            		name.value="";api.value="";	
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
                <h2 style="margin: 20px" >Applications</h2>
            </div>
        </div>
        <div class="col-sm-10">	
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
                  <td>Company Name</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" Name Example " id="addname" autocomplete="off">
		    		</form>
                  </td>
                </tr>
 				<tr>
                  <td>API Key</td> 
                  <td><form>
		     			 <input type="text" placeholder=" 12345 " id="addapi" autocomplete="off">
		    		</form>
		    		</td>
                </tr>
                <tr>
                  <td></td> 
                  <td>
                  	<button type="button" class="btn" onclick="addApp()">
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