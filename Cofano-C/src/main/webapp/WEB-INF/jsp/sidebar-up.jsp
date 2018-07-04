<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow collapse show">
    <div class="navbar-brand title">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidebar" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="user-sidebar">
            <div class="user-options">
                <div class="dropdown">
                    <a id="settings-dopdown" href="#" class="dropdown-toggle push-right button" data-toggle="dropdown" role="button" aria-expanded="false" aria-haspopup="true">

                    </a>
                    <ul class="dropdown-menu" aria-labelledby="settings-dropdown">
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><a class="dropdown-item" href="${(empty base) ? '.' : base}/darkmode">Dark mode</a></li>
                        <li><a class="dropdown-item" href="./logout">Sign out</a></li>
                    </ul>
                </div>
            </div>
            <div class="user-image">
                <c:choose>
                    <c:when test="${empty userImageUrl}">
                        <div class="media-object circle-text small">${fn:escapeXml(userFullName.charAt(0))}</div>
                    </c:when>
                    <c:otherwise>
                        <img class="media-object img-circle" src="${fn:escapeXml(userImageUrl)}" alt="">
                        <br />
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-info">
                <p class="person">${fn:escapeXml(userFullName)}</p>
                <p class="firm">Cofano B.V.</p>
            </div>
        </div>
    </div>
</nav>