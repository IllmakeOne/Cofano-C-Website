<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            
    	    <div class="col-sm-4">
         		 <div class="dropdown">
	  				<button class="btn btn-primary dropdown-toggle btn" type="button" data-toggle="dropdown">+
					  <span class="caret"></span></button>
					<ul class="dropdown-menu">
				    <li class="dropdown-item"><a href="${(empty base) ? '.' : base}/ships/add">Ship</a></li>
			    	<li class="dropdown-item"><a href="${(empty base) ? '.' : base}/applications/add">Application</a></li>
				    <li class="dropdown-item"><a href="${(empty base) ? '.' : base}/containers/add">Container Type</a></li>
			    	<li class="dropdown-item"><a href="${(empty base) ? '.' : base}/terminals/add">Terminal</a></li>
				    <li class="dropdown-item"><a href="${(empty base) ? '.' : base}/undgs/add">UNDG</a></li>
			    	<li class="dropdown-item"><a href="${(empty base) ? '.' : base}/ports/add">Port</a></li>
					 </ul>
				</div>
			</div>
        </div>