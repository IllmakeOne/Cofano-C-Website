<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            
            
            
            
            
            $("form").submit(function(event){
                event.preventDefault();
                $.ajax({
                    type: $("form").attr('method'),
                    url: $("form").attr('action'),
                    data: JSON.stringify({"displayName": $("#addname").val(),
                    	"isoCode": $("#addiso").val(),
                    	"description": $("#adddescrip").val(),
                    	"length": $("#addlenght").val(),
                    	"height": $("#addheight").val(),
                    	"reefer": $('#' + "addreefer").is(":checked")
                    	}),
                    success: function(data) {
                        window.location.replace("${base}/containers");
                    },
                    error: function(data) {
                        $("#error").show().text("Something went wrong: " + data)
                    },
                    contentType: "application/json",
                    dataType: 'json'
                });
                return false; // prevent default
            });
            
            function retrieveContainer(id) {
                if ($('form').attr('method') === "put" && id !== "undefined") {
                    $("#loading").show();
                    $.getJSON( "${base}/api/containers/" + id, function(con) {
                    	$("#addname").val(con.displayName);
                    	$("#addiso").val(con.isoCode);
                    	$("#adddescrip").val(con.description);
                    	$("#addlenght").val(con.length);
                    	$("#addheight").val(con.height);
                    	//$("#addreefer").val(con.reefer);
                    })
                    .fail(function() {
                        $("#error").show().text("Could not load information")
                    })
                    .always(function() {
                        $("#loading").hide();
                    });
                }
            }
            document.onload = retrieveContainer($('form').data('id'));
            
          
            
            
        </script>
    </jsp:attribute>

   <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">${fn:escapeXml(action)} Application<c:if test="${not empty con}">: ${fn:escapeXml(con)}</c:if></h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <a class="btn btn-sm btn-outline-secondary" href="${base}/containers">Go back</a>
                </div>
            </div>
        </div>
        
         <div class="alert alert-danger" id="error" role="alert" style="display:none">
            A simple danger alert with <a href="#" class="alert-link">an example link</a>. Give it a click if you like.
        </div>

        <div class="alert alert-info" id="loading" role="alert" style="display:none">
            Loading
        </div>
        
          <form <c:if test="${not empty con}">data-id="${fn:escapeXml(con)}"</c:if>action="${formUrl}" method="${method}">
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
		     		 <input type="text" placeholder=" 54JS " id="addname" autocomplete="off">
                  </td>
                </tr>
                
 				<tr>
                  <td>ISO Code</td> 
                      <td>
		     			 <input type="text" placeholder=" 23B4 " id="addiso" autocomplete="off">
		    		</td>
                </tr>
                
                <tr>
                  <td>Description</td> 
                  <td>
		     		 <input type="text" placeholder=" Big squery thingy " id="adddescrip" autocomplete="off">
                  </td>
                </tr>
                
                <tr>
                  <td>Length</td> 
                  <td>
		     		<input type="number" min="1" max="999" placeholder=" 10" id="addlenght" autocomplete="off">
                  </td>
                </tr>
                
                <tr>
                  <td>Height</td> 
                  <td>
		     		 <input type="number" min="1" max="999" placeholder=" 5 " id="addheight" autocomplete="off">
                  </td>
                </tr>
                
                <tr>
                  <td>Reefer</td> 
                  <td>
					 <input class="form-check-input" type="checkbox" value="" id="addreefer" required>
				        Check for true, leave unchecked for false
                  </td>
                </tr>
                
                 <td></td> 
                 <td>
                        <button type="submit" class="btn btn-sm btn-outline">
                            <c:choose>
                                <c:when test="${method eq 'put'}">
                                    Edit
                                </c:when>
                                <c:otherwise>
                                    Add
                                </c:otherwise>
                            </c:choose>
                            information
                        </button>
                      </td>
                </tr>
              
              </tbody>
            </table>
          </div>   
    
        </div>
        
        </form>
    </jsp:body>
</t:dashboard>