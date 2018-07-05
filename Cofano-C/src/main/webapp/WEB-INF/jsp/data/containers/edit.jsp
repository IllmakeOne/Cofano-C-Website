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
                    data: JSON.stringify(
                        {
                            "displayName": $("#name").val(),
                            "isoCode": $("#iso").val(),
                            "description": $("#description").val(),
                            "length": $("#length").val(),
                            "height": $("#height").val(),
                            "reefer": $("#reefer").is(":checked")
                        }),
                    success: function(data) {
                        window.location.replace("${base}/containers");
                    },
                    error: function(data) {
                        $("#error").show().text("Something went wrong: " + data.responseJSON.description)
                    },
                    contentType: "application/json",
                    dataType: 'json'
                });
                return false; // prevent default
            });

            function retrieveContainer(id) {
                if ($('form').attr('method') === "put" && id !== "undefined") {
                    $("#loading").show();
                    $.getJSON( "${base}/api/containers/" + id, function(container) {
                        $("#name").val(container.displayName);
                        $("#iso").val(container.isoCode);
                        $("#description").val(container.description);
                        $("#length").val(container.length);
                        $("#height").val(container.height);
                        $("#reefer").prop('checked', container.reefer)
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

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">${fn:escapeXml(action)} Container<c:if test="${not empty app}">: ${fn:escapeXml(app)}</c:if></h1>
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

        <form <c:if test="${not empty app}">data-id="${fn:escapeXml(app)}"</c:if>action="${formUrl}" method="${method}">
            <fieldset>
                <legend>Container data</legend>
                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">Display Name</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="54JS" id="name" name="name" autocomplete="off" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">ISO:</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="23B4" id="iso" name="iso" autocomplete="off" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">Description:</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="Big squery thingy" id="description" name="description" autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">Length:</label>
                    <div class="col-sm-5">
                        <input type="number" class="form-control" min="1" max="999" placeholder="5" id="length" name="length" autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-3 col-form-label">Height:</label>
                    <div class="col-sm-5">
                        <input type="number" class="form-control" min="1" max="999" placeholder="5" id="height" name="height" autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="reefer" class="col-sm-3 col-form-label">Reefer</label>
                    <div class="col-sm-5">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="reefer">
                            <label class="form-check-label" for="reefer">
                                Reefer
                            </label>
                        </div>
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
                            container
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
                            <%--<td>Display Name</td>--%>
                            <%--<td>--%>
                                <%--&lt;%&ndash;<input type="text" placeholder="54JS" id="name" name="name" autocomplete="off" required>&ndash;%&gt;--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>ISO Code</td>--%>
                            <%--<td>--%>
                                <%--&lt;%&ndash;<input type="text" placeholder="23B4" id="iso" name="iso" autocomplete="off" required>&ndash;%&gt;--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>Description</td>--%>
                            <%--<td>--%>
                                <%--&lt;%&ndash;<input type="text" placeholder="Big squery thingy" id="description" name="description" autocomplete="off">&ndash;%&gt;--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>Length</td>--%>
                            <%--<td>--%>
                                <%--&lt;%&ndash;<input type="number" min="1" max="999" placeholder="5" id="length" name="length" autocomplete="off">&ndash;%&gt;--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>Height</td>--%>
                            <%--<td>--%>
                                <%--&lt;%&ndash;<input type="number" min="1" max="999" placeholder="5" id="height" name="height" autocomplete="off">&ndash;%&gt;--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>Reefer</td>--%>
                            <%--<td>--%>
                                <%--<input class="form-check-input" type="checkbox" value="" id="reefer">--%>
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
                                    <%--container--%>
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