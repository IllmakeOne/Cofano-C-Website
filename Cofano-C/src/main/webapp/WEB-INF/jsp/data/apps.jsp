<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            var myObj;
            var restServlet = "http://localhost:8080/Cofano-C/rest/data/applications";

            function loadAll() {
                var xmlhttp = new XMLHttpRequest();
                var txt = "";
                xmlhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        console.log("made it");
                        myObj = JSON.parse(this.responseText);
                        txt += " <div class=\"table-responsive\" style=\"margin: 10px\"> <table id=\"items\" class=\"table table-striped \"><thead>"
                            + "<tr>  <th><h5>ID</h5></th>  <th><h5>Name</h5></th>  <th><h5>API Key</h5></th> <th><h5>Changes</h5></th> </tr> </thead>";
                        for (x in myObj) {
                            txt += "<tr><td>" + myObj[x].id + "</td><td>"
                                + myObj[x].name + "</td><td>" + myObj[x].apikey + "</td>" +
                                "<td><div class=\"btn-group\"> <button type=\"button\" class=\"btn btn-outline-light btn-sm \">" +
                                "<img src=\"img/edit.svg\" class=\"img-rounded\"></button>" +
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

            };

            window.onload = loadAll();
        </script>

    </jsp:attribute>

    <jsp:body>
        <div class="row">
            <div class="col-sm-8">
                <h2 style="margin: 20px">Applications</h2>
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
                        <a class="dropdown-item" href="#">Name </a>
                        <a class="dropdown-item" href="#">Id</a>
                        <a class="dropdown-item" href="#">Boat</a>
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