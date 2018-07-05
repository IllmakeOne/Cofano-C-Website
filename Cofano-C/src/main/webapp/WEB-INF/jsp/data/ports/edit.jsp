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
                    data: JSON.stringify({"unlo": $("#unlo").val(), "name": $("#name").val()}),
                    success: function(data) {
                        window.location.replace("${base}/ports");
                    },
                    error: function(data) {
                        $("#error").show().text("Something went wrong: " + data.responseJSON.description)
                    },
                    contentType: "application/json",
                    dataType: 'json'
                });
                return false; // prevent default
            });

            function retrievePort(id) {
                if ($('form').attr('method') === "put" && id !== "undefined") {
                    $("#loading").show();
                    $.getJSON( "${base}/api/ports/" + id, function(port) {
                        $("#name").val(port.name);
                        $("#unlo").val(port.unlo);
                    })
                    .fail(function() {
                        $("#error").show().text("Could not load information")
                    })
                    .always(function() {
                        $("#loading").hide();
                    });
                }
            }
            document.onload = retrievePort($('form').data('id'));
        </script>


    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">${fn:escapeXml(action)} Port<c:if test="${not empty app}">: ${fn:escapeXml(app)}</c:if></h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <a class="btn btn-sm btn-outline-secondary" href="${base}/ports">Go back</a>
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
                <legend>Port data</legend>
                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">Name</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="TestName" id="name" name="name" autocomplete="off" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">UNLO:</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="UnloExample" id="unlo" name="unlo" autocomplete="off">
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
                            port
                        </button>
                    </div>
                </div>
            </fieldset>
        </form>
    </jsp:body>
</t:dashboard>