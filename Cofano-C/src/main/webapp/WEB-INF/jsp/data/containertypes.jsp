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
            var restServlet = "https://localhost:8080/Cofano-C/rest/data/ships";

            function loadAll() {
                var xmlhttp = new XMLHttpRequest();
                var txt = "";
                xmlhttp.onreadystatechange == 4 && this.status == 200 {
                    console.log("made it");
                    myObj = JSON.parse(this.responseText);
                    txt += " " +
                            "<div class=\"table-responsive\" style=\"margin: 5px\">" +
                            "<table id=\"items\" class=\"table table-striped\">" +
                            "<thead>" +
                            "<tr>" +
                            "<th><h5>ID</h5></th>" +
                            "<th><h5>Name</h5></th>" +
                            "<th><h5>ISO <Code></Code></h5></th>" +
                            "<th><h5>Description <Code></Code></h5></th>" +
                            "<th><h5>Length</h5></th>" +
                            "<th><h5>Height <Code></Code></h5></th>" +
                            "<th><h5>Reefer <Code></Code></h5></th>"

                }
            }
        </script>
    </jsp:attribute>
</t:dashboard>