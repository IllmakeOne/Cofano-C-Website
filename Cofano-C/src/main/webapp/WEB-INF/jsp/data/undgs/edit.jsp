<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>
    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${base}/css/selectize.css"/>
        <link rel="stylesheet" type="text/css" href="${base}/css/selectize.bootstrap3.css"/>
        <link rel="stylesheet" type="text/css" href="${base}/css/flag-icon.min.css"/>
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

            function loadLanguages() {
                var languages = [
                    {code: "nl", name: "Nederlands"},
                    {code: "de", name: "Deutsch"},
                    {code: "fr", name: "Français"},
                    {code: "en", name: "English"},
                ];


                $('select[name^=language-selectize]').selectize({
                    maxItems: 1,
                    labelField: 'name',
                    valueField: 'code',
                    searchField: ['name', 'code'],
                    options: languages,
                    preload: true,
                    persist: false,
                    render: {
                        item: function (item, escape) {
                            var language = item.code == "en" ? "gb" : item.code;
                            return "<div><span class='flag-icon flag-icon-" + escapeHtml(language) + "' />&nbsp;" + escapeHtml(item.name) + "</div>";
                        },
                        option: function (item, escape) {
                            var language = item.code == "en" ? "gb" : item.code;
                            return "<div><span class='flag-icon flag-icon-" + escapeHtml(language) + "' />&nbsp;" + escapeHtml(item.name) + "</div>";
                        }
                    },
                });

                feather.replace();
            }


            $("form").submit(function (event) {
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

                var descriptions = [];
                $('select[name^="language-selectize"]').each(function (index) {
                    console.log($('input[name^="description"]').eq(index).val());
                    descriptions.push({
                        "description": $('input[name^="description"]').eq(index).val(),
                        "language": $(this).val()
                    })
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
                        "tankCode": selectedTankcodes,
                        "descriptions": descriptions
                    }),
                    success: function (data) {
                        window.location.replace("${base}/undgs");
                    },
                    error: function (data) {
                        $("#error").show().text("Something went wrong: " + data)
                    },
                    contentType: "application/json",
                    dataType: 'json'
                });
                return false; // prevent default
            });

            var labels, tankSpecialProvisions, tankcodes, descriptions;


            function retrieveUndgs(id) {
                loadLanguages();

                if ($('form').attr('method') === "put" && id !== "undefined") {
                    $("#loading").show();
                    $.getJSON("${base}/api/undgs/" + id, function (undgs) {
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
                        descriptions = undgs.descriptions;

                        if (labelSelect.options !== "undefined" && labelSelect.options.length > 0) {
                            var selected = [];
                            $.each(labels, function (index, value) {
                                selected.push(labelSelect.search(value).items[0].id)
                            });
                            labelSelect.setValue(selected, false)
                        }

                        if (tankSpecialProvisionsSelect.options !== "undefined" && tankSpecialProvisionsSelect.options.length > 0) {
                            var selected = [];
                            $.each(tankSpecialProvisions, function (index, value) {
                                selected.push(tankSpecialProvisionsSelect.search(value).items[0].id)
                            });
                            tankSpecialProvisionsSelect.setValue(selected, false)
                        }

                        if (tankcodesSelect.options !== "undefined" && tankcodesSelect.options.length > 0) {
                            var selected = [];
                            $.each(tankcodes, function (index, value) {
                                selected.push(tankcodesSelect.search(value).items[0].id)
                            });
                            tankcodesSelect.setValue(selected, false)
                        }

                        if (descriptions !== "undefinded" && descriptions.length > 0) {
                            $.each(descriptions, function (index, description) {
                                if (index > 0) {
                                    var descriptionTemplate = $('#description-template').html();
                                    descriptionTemplate = descriptionTemplate.replace(/{deleteLang}/g, description.language);
                                    $("div.descriptions").append(descriptionTemplate);
                                }
                                loadLanguages();
                                $('select[name^="language-selectize"]').eq(index)[0].selectize.setValue(description.language, false);
                                $('input[name^="description"]').eq(index).val(description.description)
                            });
                        }

                    })
                        .fail(function () {
                            $("#error").show().text("Could not load information")
                        })
                        .always(function () {
                            $("#loading").hide();
                        });


                    loadLanguages();
                }

                // Populate dropdown with list of labels
                $.getJSON("${base}/api/undgs/labels", function (data) {
                    $.each(data, function (key, entry) {
                        labelSelect.addOption({
                            value: entry.id,
                            text: escapeHtml(entry.name),
                        });
                    });
                    if (labels !== "undefined" && labels != "") {
                        var selected = [];
                        $.each(labels, function (index, value) {
                            selected.push(labelSelect.search(escapeHtml(value)).items[0].id)
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
                    });
                    if (tankSpecialProvisions !== "undefined" && tankSpecialProvisions != "") {
                        var selected = [];
                        $.each(tankSpecialProvisions, function (index, value) {
                            selected.push(tankSpecialProvisionsSelect.search(escapeHtml(value)).items[0].id)
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
                    });
                    if (tankcodes !== "undefined" && tankcodes != "") {
                        var selected = [];
                        $.each(tankcodes, function (index, value) {
                            selected.push(tankcodesSelect.search(escapeHtml(value)).items[0].id)
                        });
                        tankcodesSelect.setValue(selected, false)
                    }
                });

            }
            document.onload = retrieveUndgs($('form').data('id'));


            $(document).on('click', '#add-description', function () {
                var descriptionTemplate = $('#description-template').html();
                // descriptionTemplate.replace(/{}/g, u)
                descriptionTemplate = descriptionTemplate.replace(/{deleteLang}/g, "");
                $("div.descriptions").append(descriptionTemplate);
                loadLanguages()
            });

            var deletingRow;
            $(document).on('click', '.btn-delete', function () {
                if ($(this).attr('data-delete-lang') && $(this).data('delete-lang') != "") {
                    $('#delete-name').text($(this).closest('.language-description').find('select[name^=language-selectize]')[0].selectize.getValue());
                    $('#delete-confirm').data('delete-url', "${base}/api/undgs/" + $('form').data('id') + "/description/" + $(this).data('delete-lang'));
                    $('#deleteModal').modal('show');
                    deletingRow = $(this).closest('.language-description');
                } else {
                    $(this).closest('.language-description').remove();
                }
            });

            $(document).on('click', '#delete-confirm', function () {
                $.ajax({
                    type: "delete",
                    url: $('#delete-confirm').data('delete-url'),
                    beforeSend: function (xhr) {
                        $("#delete-error").hide();
                    },
                    success: function (data) {
                        $('#deleteModal').modal('hide');
                        deletingRow.remove();
                    },
                    error: function (data) {
                        $("#delete-error").show();
                    },
                });
            });


        </script>

        <script type="text/template" id="description-template">
            <div class="form-group row language-description">
                <div class="col-sm-3">
                    <select name="language-selectize[]" placeholder="Select a Language">
                        <option value="">Select a language...</option>
                    </select>
                </div>
                <div class="col-sm-5">
                    <input type="text" name="description[]" class="form-control" placeholder="Description"
                           autocomplete="off">&nbsp;
                </div>
                <div class="form-group row">
                    <div class="col-sm-12" style="padding-top: 0.3rem;">
                        <button type="button" class="btn btn-danger btn-sm btn-delete" data-delete-lang="{deleteLang}">
                            <span data-feather="trash-2"></span></button>
                    </div>
                </div>
            </div>
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

        <form <c:if test="${not empty app}">data-id="${fn:escapeXml(app)}" </c:if>action="${formUrl}" method="${method}"
              class="container-fluid">
            <fieldset>
                <legend>UNDG descriptions</legend>
                <div class="descriptions">
                    <div class="form-group row">
                        <div class="col-sm-3">
                            <select name="language-selectize[]" placeholder="Select a Language">
                                <option value="">Select a language...</option>
                            </select>
                        </div>
                        <div class="col-sm-5">
                            <input type="text" name="description[]" class="form-control" placeholder="Description"
                                   autocomplete="off" required>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <button type="button" id="add-description" class="btn btn-outline-primary btn-sm">Add new
                            description
                        </button>
                    </div>
                </div>
                    <%--<div class="form-group">--%>
                    <%--<label for="subject" class="col-sm-3 control-label">Subject</label>--%>
                    <%--<div class="col-sm-5">--%>
                    <%--<div class="container">--%>

                    <%--</div>--%>

                    <%--</div>--%>
                    <%--</div>--%>
            </fieldset>

            <fieldset>
                <legend>UNDG data</legend>
                <div class="form-group row">
                    <label for="unNo" class="col-sm-3 col-form-label">unNo</label>
                    <div class="col-sm-5">
                        <input type="number" class="form-control" placeholder="0" id="unNo" name="unNo"
                               autocomplete="off" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="transportForbidden" class="col-sm-3 col-form-label">Transport forbidden</label>
                    <div class="col-sm-5">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="transportForbidden">
                            <label class="form-check-label" for="transportForbidden">
                                Transport forbidden
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="collective" class="col-sm-3 col-form-label">Collective</label>
                    <div class="col-sm-5">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="collective">
                            <label class="form-check-label" for="collective">
                                Collective
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="notApplicable" class="col-sm-3 col-form-label">Not applicable</label>
                    <div class="col-sm-5">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="notApplicable">
                            <label class="form-check-label" for="notApplicable">
                                Not applicable
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="classificationCode" class="col-sm-3 col-form-label">Classification Code</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="0" id="classificationCode"
                               name="classificationCode" autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="classification" class="col-sm-3 col-form-label">Classification</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="0" id="classification"
                               name="classification" autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="packingGroup" class="col-sm-3 col-form-label">Packing Group</label>
                    <div class="col-sm-5">
                        <input type="number" class="form-control" placeholder="0" id="packingGroup" name="packingGroup"
                               autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="hazardNo" class="col-sm-3 col-form-label">Hazard No.</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="30" id="hazardNo" name="hazardNo"
                               autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="station" class="col-sm-3 col-form-label">Station</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="S20" id="station" name="station"
                               autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="transportCategory" class="col-sm-3 col-form-label">Transport Category</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="0" id="transportCategory"
                               name="transportCategory" autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="tunnelCode" class="col-sm-3 col-form-label">Tunnel Code</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="1" id="tunnelCode" name="tunnelCode"
                               autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vehicleTankCarriage" class="col-sm-3 col-form-label">Vehicle Tank Carriage</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" placeholder="AT" id="vehicleTankCarriage"
                               name="vehicleTankCarriage" autocomplete="off">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vehicleTankCarriage" class="col-sm-3 col-form-label">Labels</label>
                    <div class="col-sm-5">
                        <select id="labels" name="labels[]" multiple class="select" placeholder="Select labels...">
                            <option value="">Select labels...</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vehicleTankCarriage" class="col-sm-3 col-form-label">Tank Special Provisions</label>
                    <div class="col-sm-5">
                        <select id="tankSpecialProvisions" name="tankSpecialProvisions[]" multiple class="select"
                                placeholder="Select tank special provisions...">
                            <option value="">Select tank special provisions...</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="vehicleTankCarriage" class="col-sm-3 col-form-label">Tank Codes</label>
                    <div class="col-sm-5">
                        <select id="tankcodes" name="tankcodes[]" multiple class="select"
                                placeholder="Select tank codes...">
                            <option value="">Select tank codes...</option>
                        </select>
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
                <%--<td>unNo</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="number" class="form-control" placeholder="0" id="unNo" name="unNo" autocomplete="off" required>&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Transport forbidden</td>--%>
                <%--<td>--%>
                <%--<div class="form-check">--%>
                <%--&lt;%&ndash;<input class="form-check-input" type="checkbox" value="" id="transportForbidden">&ndash;%&gt;--%>
                <%--<label class="form-check-label" for="transportForbidden">--%>
                <%--Transport forbidden--%>
                <%--</label>--%>
                <%--</div>--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Collective</td>--%>
                <%--<td>--%>
                <%--<div class="form-check">--%>
                <%--&lt;%&ndash;<input class="form-check-input" type="checkbox" value="" id="collective">&ndash;%&gt;--%>
                <%--<label class="form-check-label" for="collective">--%>
                <%--Collective--%>
                <%--</label>--%>
                <%--</div>--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Not applicable</td>--%>
                <%--<td>--%>
                <%--<div class="form-check">--%>
                <%--&lt;%&ndash;<input class="form-check-input" type="checkbox" value="" id="notApplicable">&ndash;%&gt;--%>
                <%--<label class="form-check-label" for="notApplicable">--%>
                <%--Not applicable--%>
                <%--</label>--%>
                <%--</div>--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Classification Code</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="1.1D" id="classificationCode" name="classificationCode" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Classification</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="1" id="classification" name="classification" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Packing Group</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="number" class="form-control" placeholder="0" id="packingGroup" name="packingGroup" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Hazard No</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="30" id="hazardNo" name="hazardNo" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Station</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="S20" id="station" name="station" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Transport category</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="1" id="transportCategory" name="transportCategory" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Tunnel code</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="B1000C" id="tunnelCode" name="tunnelCode" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Vehicle Tank Carriage</td>--%>
                <%--<td>--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="AT" id="vehicleTankCarriage" name="tunnelCode" autocomplete="off">&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Labels</td>--%>
                <%--<td style="max-width:10px">--%>
                <%--&lt;%&ndash;<select id="labels" name="labels[]" multiple class="select" placeholder="Select labels...">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<option value="">Select labels...</option>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</select>&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Tank Special Provisions</td>--%>
                <%--<td style="max-width:10px">--%>
                <%--&lt;%&ndash;<select id="tankSpecialProvisions" name="tankSpecialProvisions[]" multiple class="select" placeholder="Select tank special provisions...">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<option value="">Select tank special provisions...</option>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</select>&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                <%--<td>Tank Codes</td>--%>
                <%--<td style="max-width:10px">--%>
                <%--&lt;%&ndash;<select id="tankcodes" name="tankcodes[]" multiple class="select" placeholder="Select tank codes...">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<option value="">Select tank codes...</option>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</select>&ndash;%&gt;--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--</tbody>--%>
                <%--</table>--%>
                <%--</div>--%>
                <%--</div>--%>

            <fieldset>
                <legend>Save</legend>
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
                            UNDG's
                        </button>
                    </div>
                </div>
            </fieldset>


        </form>

        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="delete modal"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm deletion</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert" id="delete-error"
                             style="display:none">
                            <strong>Holy guacamole!</strong> Something went wrong while deleting
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <p>Are you really sure you want to delete the <code id="delete-name"></code> description?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-delete-url="" id="delete-confirm">Yes delete
                            it
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:dashboard>