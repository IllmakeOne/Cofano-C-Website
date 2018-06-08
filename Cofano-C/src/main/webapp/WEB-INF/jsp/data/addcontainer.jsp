<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            
            var restServlet = "${base}/api/containers/add";
            
            function addContainer(){
            	
            	var name = document.getElementById("addname");
            	var iso = document.getElementById("addiso");
            	var descr = document.getElementById("adddescrip");
            	var lenght = document.getElementById("addlenght");
            	var height = document.getElementById("addheight");
            	var reefer = document.getElementById("addreefer");
            	
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
                <h2 style="margin: 20px" >Add Container Type</h2>
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
                  <td>Display Name</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" 54JS " id="addname" autocomplete="off">
		    		</form>
                  </td>
                </tr>
 				<tr>
                  <td>ISO Code</td> 
                  <td><form>
		     			 <input type="text" placeholder=" 23B4 " id="addiso" autocomplete="off">
		    		</form>
		    		</td>
                </tr>
                <tr>
                <tr>
                  <td>Description</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" Big squery thingy " id="adddescrip" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                <tr>
                <tr>
                  <td>Length</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" 10" id="addlenght" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                <tr>
                  <td>Height</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" 5 " id="addheight" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                  <td>Reefer</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" Name Example " id="addreefer" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                
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