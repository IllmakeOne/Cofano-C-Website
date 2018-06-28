<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>
    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${base}/css/selectize.css"/>
        <link rel="stylesheet" type="text/css" href="${base}/css/selectize.bootstrap3.css"/>
    </jsp:attribute>
    <jsp:attribute name="footer">
        <script type="text/javascript" src="${base}/js/selectize.min.js"></script>
        <script type="text/javascript">

            var labelSelect = $('#labels').selectize({
                persist: false,
                create: true
            })[0].selectize;

            var tankSpecialProvisionsSelect = $('#tankSpecialProvisions').selectize({
                persist: false,
                create: true
            })[0].selectize;

            var tankcodesSelect = $('#tankcodes').selectize({
                persist: false,
                create: true
            })[0].selectize;


            $("form").submit(function(event){
                event.preventDefault();

                console.log(labelSelect.getValue());

                // console.log(labelSelect.getItem(labelSelect.getValue()).text())
                var selectedLabels = [];
                $.each(labelSelect.getValue(), function (key, entry) {
                    selectedLabels.push(
                        labelSelect.getItem(entry).text()
                    )
                });

                var selectedTankSpecialProvisions = [];
                $.each(tankSpecialProvisionsSelect.getValue(), function (key, entry) {
                    selectedTankSpecialProvisions.push(
                        tankSpecialProvisionsSelect.getItem(entry).text()
                    )
                });

                var selectedTankcodes = [];
                $.each(tankcodesSelect.getValue(), function (key, entry) {
                    selectedTankcodes.push(
                        tankcodesSelect.getItem(entry).text()
                    )
                });

                $.ajax({
                    type: $("form").attr('method'),
                    url: $("form").attr('action'),
                    data: JSON.stringify({
                        "transportForbidden": $("#transportForbidden").is(":checked"),
                        "collective": $("#collective").is(":checked"),
                        "notApplicable": $("#notApplicable").is(":checked"),
                        "classificationCode": $("#classificationCode").val(),
                        "unNo": $("#unNo").val(),
                        "classification": $("#classification").val(),
                        "packingGroup": $("#packingGroup").val(),
                        "hazardNo": $("#hazardNo").val(),
                        "station": $("#station").val(),
                        "transportCategory": $("#transportCategory").val(),
                        "tunnelCode": $("#tunnelCode").val(),
                        "vehicleTankCarriage": $("#vehicleTankCarriage").val(),
                        "labels": selectedLabels,
                        "tankSpecialProvisions": selectedTankSpecialProvisions,
                        "tankCode": selectedTankcodes
                    }),
                    success: function(data) {
                        window.location.replace("${base}/undgs");
                    },
                    error: function(data) {
                        $("#error").show().text("Something went wrong: " + data)
                    },
                    contentType: "application/json",
                    dataType: 'json'
                });
                return false; // prevent default
            });

            var labels, tankSpecialProvisions, tankcodes;


            function retrieveUndgs(id) {

                if ($('form').attr('method') === "put" && id !== "undefined") {
                    $("#loading").show();
                    $.getJSON( "${base}/api/undgs/" + id, function(undgs) {
                        $("#unNo").val(undgs.unNo);
                        $("#transportForbidden").prop('checked', undgs.transportForbidden);
                        $("#collective").prop('checked', undgs.collective);
                        $("#notApplicable").prop('checked', undgs.notApplicable);
                        $("#classificationCode").val(undgs.classificationCode);
                        $("#classification").val(undgs.classification);
                        $("#pakcingGroup").val(undgs.packingGroup);
                        $("#hazardNo").val(undgs.hazardNo);
                        $("#station").val(undgs.station);
                        $("#transportCategory").val(undgs.transportCategory);
                        $("#tunnelCode").val(undgs.tunnelCode);
                        $("#vehicleTankCarriage").val(undgs.vehicleTankCarriage);
                        labels = undgs.labels;
                        tankSpecialProvisions = undgs.tankSpecialProvisions;
                        tankcodes = undgs.tankCode;

                        if (labelSelect.options !== "undefined" && labelSelect.options.length > 0) {
                            var selected = [];
                            $.each(labels, function( index, value ) {
                                selected.push(labelSelect.search(value).items[0].id)
                            });
                            labelSelect.setValue(selected, false)
                        }

                        if (tankSpecialProvisionsSelect.options !== "undefined" && tankSpecialProvisionsSelect.options.length > 0) {
                            var selected = [];
                            $.each(tankSpecialProvisions, function( index, value ) {
                                selected.push(tankSpecialProvisionsSelect.search(value).items[0].id)
                            });
                            tankSpecialProvisionsSelect.setValue(selected, false)
                        }

                        if (tankcodesSelect.options !== "undefined" && tankcodesSelect.options.length > 0) {
                            var selected = [];
                            $.each(tankcodes, function( index, value ) {
                                selected.push(tankcodesSelect.search(value).items[0].id)
                            });
                            tankcodesSelect.setValue(selected, false)
                        }


                    })
                    .fail(function() {
                        $("#error").show().text("Could not load information")
                    })
                    .always(function() {
                        $("#loading").hide();
                    });
                }

                // Populate dropdown with list of labels
                $.getJSON("${base}/api/undgs/labels", function (data) {
                    $.each(data, function (key, entry) {
                        labelSelect.addOption({
                            value: entry.id,
                            text: escapeHtml(entry.name),
                        });
                    })
                    if (labels !== "undefined" && labels != "") {
                        var selected = [];
                        $.each(labels, function( index, value ) {
                            selected.push(labelSelect.search(value).items[0].id)
                        });
                        labelSelect.setValue(selected, false)
                    }
                });

                // Populate dropdown with list of tank special provisions
                $.getJSON("${base}/api/undgs/tankspecialprovisions", function (data) {
                    $.each(data, function (key, entry) {
                        tankSpecialProvisionsSelect.addOption({
                            value: entry.id,
                            text: escapeHtml(entry.name),
                        });
                    })
                    if (tankSpecialProvisions !== "undefined" && tankSpecialProvisions != "") {
                        var selected = [];
                        $.each(tankSpecialProvisions, function( index, value ) {
                            selected.push(tankSpecialProvisionsSelect.search(value).items[0].id)
                        });
                        tankSpecialProvisionsSelect.setValue(selected, false)
                    }
                });

                // Populate dropdown with list of tank codes
                $.getJSON("${base}/api/undgs/tankcodes", function (data) {
                    $.each(data, function (key, entry) {
                        tankcodesSelect.addOption({
                            value: entry.id,
                            text: escapeHtml(entry.name),
                        });
                    })
                    if (tankcodes !== "undefined" && tankcodes != "") {
                        var selected = [];
                        $.each(tankcodes, function( index, value ) {
                            selected.push(tankcodesSelect.search(value).items[0].id)
                        });
                        tankcodesSelect.setValue(selected, false)
                    }
                });




            }
            document.onload = retrieveUndgs($('form').data('id'));


        </script>
        
    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">${fn:escapeXml(action)} Undg<c:if test="${not empty app}">: ${fn:escapeXml(app)}</c:if></h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <a class="btn btn-sm btn-outline-secondary" href="${base}/undgs">Go back</a>
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
                            <td>unNo</td>
                            <td>
                                <input type="number" class="form-control" placeholder="0" id="unNo" name="unNo" autocomplete="off" required>
                            </td>
                        </tr>
                        <tr>
                            <td>Transport forbidden</td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="transportForbidden">
                                    <label class="form-check-label" for="transportForbidden">
                                        Transport forbidden
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Collective</td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="collective">
                                    <label class="form-check-label" for="collective">
                                        Collective
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Not applicable</td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="notApplicable">
                                    <label class="form-check-label" for="notApplicable">
                                        Not applicable
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Classification Code</td>
                            <td>
                                <input type="text" class="form-control" placeholder="1.1D" id="classificationCode" name="classificationCode" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Classification</td>
                            <td>
                                <input type="text" class="form-control" placeholder="1" id="classification" name="classification" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Packing Group</td>
                            <td>
                                <input type="number" class="form-control" placeholder="0" id="packingGroup" name="packingGroup" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Hazard No</td>
                            <td>
                                <input type="text" class="form-control" placeholder="30" id="hazardNo" name="hazardNo" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Station</td>
                            <td>
                                <input type="text" class="form-control" placeholder="S20" id="station" name="station" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Transport category</td>
                            <td>
                                <input type="text" class="form-control" placeholder="1" id="transportCategory" name="transportCategory" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Tunnel code</td>
                            <td>
                                <input type="text" class="form-control" placeholder="B1000C" id="tunnelCode" name="tunnelCode" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Vehicle Tank Carriage</td>
                            <td>
                                <input type="text" class="form-control" placeholder="AT" id="vehicleTankCarriage" name="tunnelCode" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td>Labels</td>
                            <td style="max-width:10px">
                                <select id="labels" name="labels[]" multiple class="select" placeholder="Select labels...">
                                    <option value="">Select labels...</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Tank Special Provisions</td>
                            <td style="max-width:10px">
                                <select id="tankSpecialProvisions" name="tankSpecialProvisions[]" multiple class="select" placeholder="Select tank special provisions...">
                                    <option value="">Select tank special provisions...</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Tank Codes</td>
                            <td style="max-width:10px">
                                <select id="tankcodes" name="tankcodes[]" multiple class="select" placeholder="Select tank codes...">
                                    <option value="">Select tank codes...</option>
                                </select>
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
                                    undgs
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