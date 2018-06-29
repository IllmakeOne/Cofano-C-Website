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
                <a id="dashboard" class="nav-link<c:if test="${fn:endsWith(pageContext.request.requestURI, '/Cofano-C/')}"> active</c:if>" href="${(empty base) ? '.' : base}/">
                    <span data-feather="home"></span>
                    Dashboard
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item">
                <a id="recent_data" class="nav-link<c:if test="${fn:contains(pageContext.request.requestURI, 'history')}"> active</c:if>" href="${(empty base) ? '.' : base}/history">
                    <span data-feather="clock"></span>
                    Recently added data
                </a>
            </li>
            <li class="nav-item">
                <a id="conflicts" class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'conflicts')}"> active</c:if>" href="${(empty base) ? '.' : base}#">
                    <span data-feather="alert-triangle"></span>
                    Conflicts
                </a>
            </li>
            <li class="nav-item">
                <a id="users" class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'users')}"> active</c:if>" href="${(empty base) ? '.' : base}/users">
                    <span data-feather="users"></span>
                    Users
                </a>
            </li>
        </ul>

	<div class="row">
      <div class="col-sm-8">  <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
            <span>DATA</span>
            </h6></div>
          
	</div>
			
        <ul class="nav flex-column">
            <li class="nav-item">
                <a id="applications" class="nav-link<c:if test="${fn:contains(pageContext.request.requestURI, 'apps')}"> active</c:if>" href="${(empty base) ? '.' : base}/applications">
                    <span data-feather="aperture"></span>
                    Applications
                </a>
            </li>
            <li class="nav-item">
                <a id="ships" class="nav-link<c:if test="${fn:contains(pageContext.request.requestURI, 'ships')}"> active</c:if>" href="${(empty base) ? '.' : base}/ships">
                    <span data-feather="anchor"></span>
                    Ships
                </a>
            </li>
            <li class="nav-item">
                <a id="container_types" class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'containers')}"> active</c:if>" href="${(empty base) ? '.' : base}/containers">
                    <span data-feather="package"></span>
                    Container Types
                </a>
            </li>
            <li class="nav-item">
                <a id="terminals" class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'terminals')}"> active</c:if>" href="${(empty base) ? '.' : base}/terminals">
                    <span data-feather="terminal"></span>
                    Terminals
                </a>
            </li>

            <li class="nav-item">
                <a id="UNDGs" class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'undgs')}"> active</c:if>" href="${(empty base) ? '.' : base}/undgs">
                    <span data-feather="box"></span>
                    UNDGs
                </a>
            </li>
            <li class="nav-item">
                <a id="ports" class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'ports')}"> active</c:if>" href="${(empty base) ? '.' : base}/ports">
                    <span data-feather="map-pin"></span>
                    Ports
                </a>
            </li>
        </ul>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
            <span>ADMINISTRATION</span>
        </h6>
        <ul class="nav flex-column mb-3">
            <a class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'api')}"> active</c:if>" href="#">
                <span data-feather="book-open"></span>
                API-documentation
            </a>
            <a id="settings" class="nav-link <c:if test="${fn:contains(pageContext.request.requestURI, 'settings')}"> active</c:if>" href="${(empty base) ? '.' : base}/settings">
                <span data-feather="settings"></span>
                Settings
            </a>
        </ul>
    </div>
</nav>