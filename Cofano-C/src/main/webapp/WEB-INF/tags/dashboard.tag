<%@tag description="Dashboard template" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>

<c:if test="${empty token}">
    <c:redirect url="/login"/>
</c:if>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Cofano-C dashboard">
    <meta name="author" content="">

    <title>Cofano-C dashboard</title>

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap core JS -->
    <script src="./js/bootstrap.min.js"></script>

    <!-- Custom styles for this template -->
    <link href="./css/dashboard.css" rel="stylesheet">

    <!-- Favicons -->
    <link rel="apple-touch-icon" sizes="76x76" href="./img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="./img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="./img/favicons/favicon-16x16.png">
    <link rel="manifest" href="./img/favicons/site.webmanifest">
    <link rel="mask-icon" href="./img/favicons/safari-pinned-tab.svg" color="#5bbad5">
    <link rel="shortcut icon" href="./img/favicons/favicon.ico">
    <meta name="msapplication-TileColor" content="#00aba9">
    <meta name="msapplication-config" content="./img/favicons/browserconfig.xml">
    <script src="./js/jquery-3.3.1.min.js"></script>
    <jsp:invoke fragment="header"/>
</head>

<body>

<c:import url="/WEB-INF/jsp/sidebar-up.jsp"/>
<div class="container-fluid">
    <div class="row">
        <c:import url="/WEB-INF/jsp/sidebar.jsp"/>
        <main role="main" class="cofano-main col-md-9 ml-sm-auto col-lg-10 px-4">
            <c:choose>
                <c:when test="${not empty page}">
                    <jsp:doBody/>
                </c:when>
                <c:otherwise>
                    <c:import url="/WEB-INF/jsp/home.jsp"/>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</div>
<!-- JQuery for changing active page -->
<%--<script type="text/javascript">
    $(document).ready(function () {
        "use strict";

        $('ul.nav > li').click(function (e) {
            e.preventDefault();
            $('ul.nav > li').removeClass('active');
            $(this).addClass('active');
        });
    });
</script>--%>
<%--<script type="text/javascript">
    $(document).ready(function () {
        $('ul.nav > li').click(function () {
            $('ul.nav > li').removeClass("active");
            $(this).addClass("active");
        });
    });
</script>--%>

<script type="text/javascript">
    $(document).ready(function () {
        var pathname = window.location.pathname;
        $('.nav > li > a[href="' + pathname + '"]').parent().addClass('active');
    })
</script>

<%--<script type="text/javascript">
    $(document).ready(function () {
        var url = window.location;
        $('ul.nav a[href="' + url + '"]').parent().addClass('active');
        $('ul.nav a').filter(function () {
            return this.href == url;
        }).parent().addClass('active');
    });--%>


<%--</script>--%>


<%--<!-- JS for marking the active page on the sidebar. -->
<script type="text/javascript">
    $(document).ready(function () {
        var url = window.location;
        //Normal method
        $('li.nav-item a[href="'+ url +'"]').addClass('active');
        //Fail safe
        $('li.nav-item a').filter(function () {
            return this.href === url;
        }).addClass('active');
    });

</script>--%>


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->


<!-- Icons -->
<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
<script>
    feather.replace()
</script>
<jsp:invoke fragment="footer"/>
</body>
</html>