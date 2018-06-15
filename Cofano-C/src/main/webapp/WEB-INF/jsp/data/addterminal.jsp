<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            
            var restServlet = "${base}/api/terminals/add";
            
            function addTerminal(){
            	
            	
            	var name = document.getElementById("addname");
            	var terminalcode = document.getElementById("addterminalcode");
            	var type = document.getElementById("caddtype");
            	var unlo = document.getElementById("addunlo");
            	var portid = document.getElementById("addportid");
            	
            	if(name.value == "" || portid.value == 0){
            		alert("Please fill in at least a name and a valid port ID");	
            	} else {
            		var json = {"name": name.value, "portId":portid.value,"type":type.value,
            				"terminalCode":terminalcode.value,"unlo":unlo.value};
            	
            		let	xmlhttp = new XMLHttpRequest();
            		xmlhttp.open("POST", restServlet, true);
            		xmlhttp.setRequestHeader('Content-Type', 'application/json');
            		
            		xmlhttp.send(JSON.stringify(json));	
          
            		if(false){
            			
            		} else {
            			alert("Entry added to Database!");
            			window.location.replace("terminals");
            		}	
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
		     			 <input type="text" placeholder=Timisoara id="addname" autocomplete="off">
		    		</form>
                  </td>
                </tr>
 				<tr>
                  <td>Port ID</td> 
                  <td><form>
		     			 <input type="number" placeholder=23 id="addportid" autocomplete="off">
		    		</form>
		    		</td>
                </tr>
                <tr>
                <tr>
                  <td>Terminal Code</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" 00BF97" id="addterminalcode" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                <tr>
                <tr>
                  <td>Type</td> 
                  <td>
                	<form	>
		     			 <input type="text"  placeholder=" UNKNOWN" id="caddtype" autocomplete="off">
		    		</form>
                  </td>
                </tr>
                <tr>
                  <td>Unlo</td> 
                  <td>
                	<form	>
		     			 <input type="text" placeholder=" 123123XP" id="addunlo" autocomplete="off">
		    		</form>
                  </td>
                  </tr>
                  <tr>
                	<td> </td>
                  <td>
                  	<button type="button" class="btn" onclick="addTerminal()">
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