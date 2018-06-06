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

        <div class="table-responsive">
        <table class="table table-striped table-sm">
            <thead>
            <tr>
                <th>#</th>
                <th>Header</th>
                <th>Header</th>
                <th>Header</th>
                <th>Header</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1,001</td>
                <td>Lorem</td>
                <td>ipsum</td>
                <td>dolor</td>
                <td>sit</td>
            </tr>
            <tr>
                <td>1,002</td>
                <td>amet</td>
                <td>consectetur</td>
                <td>adipiscing</td>
                <td>elit</td>
            </tr>
            <tr>
                <td>1,003</td>
                <td>Integer</td>
                <td>nec</td>
                <td>odio</td>
                <td>Praesent</td>
            </tr>
            <tr>
                <td>1,003</td>
                <td>libero</td>
                <td>Sed</td>
                <td>cursus</td>
                <td>ante</td>
            </tr>
            <tr>
                <td>1,004</td>
                <td>dapibus</td>
                <td>diam</td>
                <td>Sed</td>
                <td>nisi</td>
            </tr>
            <tr>
                <td>1,005</td>
                <td>Nulla</td>
                <td>quis</td>
                <td>sem</td>
                <td>at</td>
            </tr>
            <tr>
                <td>1,006</td>
                <td>nibh</td>
                <td>elementum</td>
                <td>imperdiet</td>
                <td>Duis</td>
            </tr>
            <tr>
                <td>1,007</td>
                <td>sagittis</td>
                <td>ipsum</td>
                <td>Praesent</td>
                <td>mauris</td>
            </tr>
            <tr>
                <td>1,008</td>
                <td>Fusce</td>
                <td>nec</td>
                <td>tellus</td>
                <td>sed</td>
            </tr>
            <tr>
                <td>1,009</td>
                <td>augue</td>
                <td>semper</td>
                <td>porta</td>
                <td>Mauris</td>
            </tr>
            <tr>
                <td>1,010</td>
                <td>massa</td>
                <td>Vestibulum</td>
                <td>lacinia</td>
                <td>arcu</td>
            </tr>
            <tr>
                <td>1,011</td>
                <td>eget</td>
                <td>nulla</td>
                <td>Class</td>
                <td>aptent</td>
            </tr>
            <tr>
                <td>1,012</td>
                <td>taciti</td>
                <td>sociosqu</td>
                <td>ad</td>
                <td>litora</td>
            </tr>
            <tr>
                <td>1,013</td>
                <td>torquent</td>
                <td>per</td>
                <td>conubia</td>
                <td>nostra</td>
            </tr>
            <tr>
                <td>1,014</td>
                <td>per</td>
                <td>inceptos</td>
                <td>himenaeos</td>
                <td>Curabitur</td>
            </tr>
            <tr>
                <td>1,015</td>
                <td>sodales</td>
                <td>ligula</td>
                <td>in</td>
                <td>libero</td>
            </tr>
            </tbody>
        </table>


    </jsp:body>
</t:dashboard>