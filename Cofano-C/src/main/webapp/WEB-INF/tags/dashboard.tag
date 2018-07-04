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
    <link href="${(empty base) ? '.' : base}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <c:choose>
        <c:when test="${user.isDarkMode()}">
            <link href="${(empty base) ? '.' : base}/css/darkDashboard.css" rel="stylesheet">
        </c:when>
        <c:otherwise>
            <link href="${(empty base) ? '.' : base}/css/dashboard.css" rel="stylesheet">
        </c:otherwise>
    </c:choose>

    <!-- Favicons -->
    <link rel="apple-touch-icon" sizes="76x76" href="${(empty base) ? '.' : base}/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${(empty base) ? '.' : base}/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${(empty base) ? '.' : base}/img/favicons/favicon-16x16.png">
    <link rel="manifest" href="${(empty base) ? '.' : base}/img/favicons/site.webmanifest">
    <link rel="mask-icon" href="${(empty base) ? '.' : base}/img/favicons/safari-pinned-tab.svg" color="#5bbad5">
    <link rel="shortcut icon" href="${(empty base) ? '.' : base}/img/favicons/favicon.ico">
    <meta name="msapplication-TileColor" content="#00aba9">
    <meta name="msapplication-config" content="${(empty base) ? '.' : base}/img/favicons/browserconfig.xml">

    <jsp:invoke fragment="header"/>
</head>

<body>
<c:import url="/WEB-INF/jsp/sidebar-up.jsp"/>
<div class="container-fluid">
    <div class="row">
        <c:import url="/WEB-INF/jsp/sidebar.jsp"/>
        <main role="main" class="cofano-main col-md-9 ml-sm-auto col-lg-10 px-4">


            <jsp:doBody/>
        </main>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script
        src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script>window.jQuery</script>
<script src="${(empty base) ? '.' : base}/js/popper.min.js"></script>

<script src="${(empty base) ? '.' : base}/js/bootstrap.min.js"></script>
<script type="text/javascript">
    var entityMap = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#39;',
        '/': '&#x2F;',
        '`': '&#x60;',
        '=': '&#x3D;'
    };

    function escapeHtml(string) {
        return String(string).replace(/[&<>"'`=\/]/g, function (s) {
            return entityMap[s];
        });
    }
</script>

<!-- Icons -->
<script src="${(empty base) ? '.' : base}/js/feather.min.js"></script>

<%--<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>--%>
<jsp:invoke fragment="footer"/>
<script>
    feather.replace()
</script>
</body>
</html>