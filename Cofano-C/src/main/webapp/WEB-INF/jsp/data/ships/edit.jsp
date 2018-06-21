<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">

        <script type="text/javascript">

            var api = $("#apikey");

            $("form").submit(function(event){
                event.preventDefault();
                $.ajax({
                    type: $("form").attr('method'),
                    url: $("form").attr('action'),
                    data: JSON.stringify({"imo": $("#imo").val(), "name":$("#name").val(),"callsign":$("#callsign").val(),
                        "mmsi":$("#mmsi").val(),"depth":$("#depth").val()}),
                    success: function(data) {
                        window.location.replace("${base}/ships");
                    },
                    error: function(data) {
                        $("#error").show().text("Something went wrong: " + data)
                    },
                    contentType: "application/json",
                    dataType: 'json'
                });
                return false; // prevent default
            });

            function retrieveShip(id) {
                if ($('form').attr('method') === "put" && id !== "undefined") {
                    $("#loading").show();
                    $.getJSON( "${base}/api/ships/" + id, function(ship) {
                        $("#name").val(ship.name);
                        $("#imo").val(ship.imo);
                        $("#callsign").val(ship.callsign);
                        $("#mmsi").val(ship.mmsi);
                        $("#depth").val(ship.depth);
                    })
                        .fail(function() {
                            $("#error").show().text("Could not load information")
                        })
                        .always(function() {
                            $("#loading").hide();
                        });
                }
            }
            document.onload = retrieveShip($('form').data('id'));
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">${fn:escapeXml(action)} Ship<c:if test="${not empty app}">: ${fn:escapeXml(app)}</c:if></h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <a class="btn btn-sm btn-outline-secondary" href="${base}/ships">Go back</a>
                </div>
            </div>
        </div>

        <div class="alert alert-danger" id="error" role="alert" style="display:none">
            A simple danger alert with <a href="#" class="alert-link">an example link</a>. Give it a click if you like.
        </div>

        <div class="alert alert-info" id="loading" role="alert" style="display:none">
            Loading
        </div>

        <form <c:if test="${not empty app}">data-id="${fn:escapeXml(app)}"</c:if>action="${formUrl}" method="${method}">
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
                            <td>IMO</td>
                            <td>
                                <input type="text" placeholder="12345AB" id="imo" name="imo" autocomplete="off" required>
                            </td>
                        </tr>
                        <tr>
                            <td>Name</td>
                            <td>
                                <input type="text" placeholder="McBoatFace" id="name" name="name" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Callsign</td>
                            <td>
                                <input type="text" placeholder="BF45" id="callsign" name="callsign" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>MMSI</td>
                            <td>
                                <input type="text" placeholder="456465ABC" id="mmsi" name="mmsi" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Depth</td>
                            <td>
                                <input type="number" step="0.01" min="1" max="999" placeholder="5.5" id="depth" name="depth" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
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
                                    ship
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>



        <%--<div class="row">--%>
            <%--<div class="col-sm-8">--%>
                <%--<h2 style="margin: 20px" >Add Ship</h2>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-sm-12">	--%>
          <%--<div class="table-responsive" style="margin: 35px">--%>
            <%--<table class="table table-striped table-sm">--%>
              <%--<thead>--%>
                <%--<tr>--%>
                  <%--<th><h5>Field</h5></th>--%>
                  <%--<th><h5>Data</h5></th>--%>
                <%--</tr>--%>
              <%--</thead>--%>
              <%--<tbody>--%>
                <%--<tr>--%>
                  <%--<td>IMO</td> --%>
                  <%--<td>--%>
                	<%--<form	>--%>
		     			 <%--<input type="text" placeholder=12345AB id="addimo" autocomplete="off">--%>
		    		<%--</form>--%>
                  <%--</td>--%>
                <%--</tr>--%>
 				<%--<tr>--%>
                  <%--<td>Name</td> --%>
                  <%--<td><form>--%>
		     			 <%--<input type="text" placeholder=" McBoatFace " id="addname" autocomplete="off">--%>
		    		<%--</form>--%>
		    		<%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<tr>--%>
                  <%--<td>Callsign</td> --%>
                  <%--<td>--%>
                	<%--<form	>--%>
		     			 <%--<input type="text" placeholder=" BF45" id="addcallsign" autocomplete="off">--%>
		    		<%--</form>--%>
                  <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<tr>--%>
                  <%--<td>MMSI</td> --%>
                  <%--<td>--%>
                	<%--<form	>--%>
		     			 <%--<input type="text"  placeholder=" 456465ABC" id="addmmsi" autocomplete="off">--%>
		    		<%--</form>--%>
                  <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                  <%--<td>Depth</td> --%>
                  <%--<td>--%>
                	<%--<form	>--%>
		     			 <%--<input type="number" step="0.01" min="1" max="999" placeholder=" 5.5 " id="adddepth" autocomplete="off">--%>
		    		<%--</form>--%>
                  <%--</td>--%>
                  <%--</tr>--%>
                  <%--<tr>--%>
                	<%--<td> </td>--%>
                  <%--<td>--%>
                  	<%--<button type="button" class="btn" onclick="addShip()">--%>
					    	<%--Add Information --%>
					<%--</button>--%>
		    		<%--</td>--%>
                <%--</tr>--%>
              <%----%>
              <%--</tbody>--%>
            <%--</table>--%>
          <%--</div>   --%>
    <%----%>
			<%--</div>--%>
    </jsp:body>
</t:dashboard>