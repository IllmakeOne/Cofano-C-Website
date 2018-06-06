<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 6/6/18
  Time: 12:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            var myObj;
            var restServlet = "./rest/data/ships";

            function loadAll() {
                var xmlhttp = new XMLHttpRequest();
                var txt = "";
                xmlhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        console.log("made it");
                        myObj = JSON.parse(this.responseText);
                        txt += " " +
                            "<div class=\"table-responsive\" style=\"margin: 5px\">" +
                            "<table id=\"items\" class=\"table table-striped\">" +
                            "<thead>" +
                            "<tr>" +
                            "<th><h5>ID</h5></th>" +
                            "<th><h5>Name</h5></th>" +
                            "<th><h5>ISO Code<Code></Code></h5></th>" +
                            "<th><h5>Description <Code></Code></h5></th>" +
                            "<th><h5>Length</h5></th>" +
                            "<th><h5>Height <Code></Code></h5></th>" +
                            "<th><h5>Reefer <Code></Code></h5></th>" +
                            "</tr>" +
                            "</thead>"

                        for (x in myObj) {
                            txt += "<tr>" +
                                "<td>" + myObj[x].id + "</td>" +
                                "<td>" + myObj[x].displayName + "</td>" +
                                "<td>" + myObj[x].isoCode + "</td>" +
                                "<td>" + myObj[x].description + "</td>" +
                                "<td>" + myObj[x].length + "</td>" +
                                "<td>" + myObj[x].height + "</td>" +
                                "<td>" + myObj[x].reefer + "</td>" +
                                "<td><div class=\"btn-group\"> <button type=\"button\" class=\"btn btn-outline-light btn-sm \">" +
                                "<img src=\"img/edit.svg\" class=\"img-rounded\"></button>" +
                                "<button type=\"button\" class=\"btn btn-outline-danger btn-sm \">" +
                                "<img src=\"img/trash-2.svg\" class=\"img-rounded\"> </button></div>" +
                                "</td>" +
                                "</tr>";
                        }

                        txt += "</table></div>"
                        document.getElementById("items").innerHTML = txt;
                    }

                    console.log(txt);
                };

                xmlhttp.open("GET", restServlet + "all", true);
                xmlhttp.send();
            }

            windows.onload = loadAll();
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="row">
            <div class="col-sm-8">
                <h2 style="margin: 20px">Container types</h2>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-4">
                <div class="search-container">
                    <form action="/action_page.php">
                        <input type="text" placeholder="Search..." name="search" style="margin-left: 10px">
                        <button type="button" class="btn  btn-sm">
                            <span data-feather="search"></span>
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-sm-4">
                <div class="dropdown">
                    <button type="button" class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown">
                        Order By
                    </button>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">ID </a>
                        <a class="dropdown-item" href="#">Name</a>
                        <a class="dropdown-item" href="#">ISO Code</a>
                        <a class="dropdown-item" href="#">Description</a>
                        <a class="dropdown-item" href="#">Length</a>
                        <a class="dropdown-item" href="#">Height</a>
                        <a class="dropdown-item" href="#">Reefer</a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4">
                <button type="button" class="btn   "
                        onClick="location.href='AddDatabase.html'">
                    Add Info <span data-feather="plus-circle"></span></button>
            </div>


            <div class="col-sm-11">
                <div id="results">
                    <div id="items">
                        <p>No items found so far!</p>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:dashboard>