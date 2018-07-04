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
                    data: JSON.stringify({"name": $("#name").val()}),
                    success: function(data) {
                        window.location.replace("${base}/applications");
                    },
                    error: function(data) {
                        $("#error").show().text("Something went wrong: " + data)
                    },
                    contentType: "application/json",
                    dataType: 'json'
                });
                return false; // prevent default
            });

            
            // $(document).keypress(function (e) {
            // 	  if(e.which == 13 && e.target.nodeName != "TEXTAREA") return false;
            // });


            function retrieveApp(id) {
                console.log("BLABLABLA")
                if ($('form').attr('method') === "put" && id !== "undefined") {
                    $("#loading").show();
                    $.getJSON( "${base}/api/applications/" + id, function(app) {
                        $("#name").val(app.name);
                        console.log("HEHYHEYE")
                    })
                    .fail(function() {
                        $("#error").show().text("Could not load information")
                    })
                    .always(function() {
                        $("#loading").hide();
                    });
                }
            }
            document.onload = retrieveApp($('form').data('id'));
        </script>
    </jsp:attribute>

    <jsp:body>

        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">${fn:escapeXml(action)} Application<c:if test="${not empty app}">: ${fn:escapeXml(app)}</c:if></h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <a class="btn btn-sm btn-outline-secondary" href="${base}/applications">Go back</a>
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
            <fieldset>
                <legend>Application data</legend>
                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">Name:</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="0" id="name" name="name" autocomplete="off" required>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-12">
                        <button type="submit" class="btn btn-primary">
                            <c:choose>
                                <c:when test="${method eq 'put'}">
                                    Save
                                </c:when>
                                <c:otherwise>
                                    Add
                                </c:otherwise>
                            </c:choose>
                            Application
                        </button>
                    </div>
                </div>
            </fieldset>

            <%--<div class="col-sm-10">--%>
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
                      <%--<td>Company Name</td>--%>
                      <%--<td>--%>
                          <%--<input type="text" placeholder=" Name Example " id="name" name="name" autocomplete="off">--%>
                      <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                      <%--<td></td>--%>
                      <%--<td>--%>
                        <%--<button type="submit" class="btn btn-sm btn-outline">--%>
                            <%--<c:choose>--%>
                                <%--<c:when test="${method eq 'put'}">--%>
                                    <%--Edit--%>
                                <%--</c:when>--%>
                                <%--<c:otherwise>--%>
                                    <%--Add--%>
                                <%--</c:otherwise>--%>
                            <%--</c:choose>--%>
                            <%--information--%>
                        <%--</button>--%>
                      <%--</td>--%>
                    <%--</tr>--%>
                  <%--</tbody>--%>
                <%--</table>--%>
              <%--</div>--%>
            <%--</div>--%>
        </form>
    </jsp:body>
</t:dashboard>