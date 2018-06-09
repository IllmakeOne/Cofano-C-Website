<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<nav class="col-md-2 d-none d-md-block bg-light sidebar collapse navbar-collapse" id="sidebar">
    <div class="sidebar-sticky">
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
            <span>MAIN</span>
        </h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="./">
                    <span data-feather="home"></span>
                    Dashboard
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <span data-feather="clock"></span>
                    Recently added data
                </a>
            </li>
        </ul>


        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
            <span>DATA</span>
        </h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="./applications">
                    <span data-feather="aperture"></span>
                    Applications
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="./ships">
                    <span data-feather="anchor"></span>
                    Ships
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="#">
                    <span data-feather="users"></span>
                    Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="./containertypes">
                    <span data-feather="anchor"></span>
                    Container types
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="#">
                    <span data-feather="terminal"></span>
                    Terminals
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="#">
                    <span data-feather="alert-triangle"></span>
                    Conflicts
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="#">
                    <span data-feather="box"></span>
                    UNDGs
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link " href="#">
                    <span data-feather="map-pin"></span>
                    Ports
                </a>
            </li>
        </ul>


        <%--<script type="text/javascript">--%>
        <%--$(document).ready(function() {--%>
        <%--"use strict";--%>

        <%--$('ul.nav-item > li > a').click(function(e) {--%>
        <%--e.preventDefault();--%>
        <%--$('ul.nav-item > li > a').removeClass('active');--%>
        <%--$(this).addClass('active');--%>
        <%--});--%>
        <%--});--%>
        <%--</script>--%>

        <%--<script type="text/javascript">--%>
        <%--var path = window.location.pathname;--%>
        <%--path = path.replace(/\$/, "");--%>
        <%--path = decodeURIComponent(path);--%>

        <%--$(".nav a").each(function () {--%>
        <%--var href = $(this).attr('href');--%>
        <%--if (path.substring(0, href.length) === href) {--%>
        <%--$(this).closest('li').addClass('active');--%>
        <%--}--%>
        <%--});--%>
        <%--</script>--%>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
            <span>ADMINISTRATION</span>
        </h6>
        <ul class="nav flex-column mb-3">
            <a class="nav-link" href="#">
                <span data-feather="book-open"></span>
                API-documentation
            </a>
            <a class="nav-link" href="#">
                <span data-feather="settings"></span>
                Settings
            </a>
        </ul>
    </div>
</nav>