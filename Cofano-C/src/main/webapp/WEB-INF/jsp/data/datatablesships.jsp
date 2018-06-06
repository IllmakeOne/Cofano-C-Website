<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            var myObj;
            var restServlet = "http://localhost:8080/Cofano-C/rest/data/ships/";

            function loadAll(){
                var	xmlhttp = new XMLHttpRequest();
                var txt = "";
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        console.log("made it");
                        myObj = JSON.parse(this.responseText);
                        txt += " <div class=\"table-responsive\" style=\"margin: 5px\"> <table id=\"items\" class=\"table table-striped \"><thead>"
                            + "<tr><th><h5>ID</h5></th>"+
                            "<th><h5>Name</h5></th><th>"+
                            "<h5>IMO</h5></th>"+
                            "<th><h5>CallSign</h5></th>"
                            + "<th><h5>MMSI</h5></th>"+
                            "<th><h5>Depth</h5></th>"+
                            "<th><h5>Changes</h5></th></tr> </thead>";
                        for (x in myObj) {
                            txt += "<tr><td>" + myObj[x].id + "</td><td>"
                                +  myObj[x].name + "</td><td>" + myObj[x].imo + "</td>" + "</td><td>" + myObj[x].callsign +
                                "</td><td>" + myObj[x].mmsi + "</td><td>" + myObj[x].depth +
                                "<td><div class=\"btn-group\"> <button type=\"button\" class=\"btn btn-outline-light btn-sm \">" +
                  				 "<img src=\"img/edit.svg\" class=\"img-rounded\"></button>"+
                  				 "<button type=\"button\" class=\"btn btn-outline-danger btn-sm \">" +
                  				 "<img src=\"img/trash-2.svg\" class=\"img-rounded\"> </button></div></td></tr>";


                        }
                        txt += "</table></div>"
                        document.getElementById("items").innerHTML = txt;
                    }

                    console.log(txt);

                };

                xmlhttp.open("GET", restServlet + "all", true);
                xmlhttp.send();

            }

            window.onload = loadAll();
        </script>

    </jsp:attribute>

    <jsp:body>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">DatatablesTest</h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-group mr-2">
                    <button class="btn btn-sm btn-outline-secondary">Share</button>
                    <button class="btn btn-sm btn-outline-secondary">Export</button>
                </div>
                <button class="btn btn-sm btn-outline-secondary dropdown-toggle">
                    <span data-feather="calendar"></span>
                    This week
                </button>
            </div>
        </div>


    </jsp:body>
</t:dashboard>