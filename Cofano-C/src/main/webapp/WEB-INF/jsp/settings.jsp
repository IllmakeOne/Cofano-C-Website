<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:dashboard>

    <jsp:attribute name="footer">
        <script type="text/javascript">
            var myObj;
            var restServlet = "http://localhost:8080/Cofano-C/rest/data/ships/";

            
            }

            
        </script>

    </jsp:attribute>

    <jsp:body>
        <div class="row">
            <div class="col-sm-8">
                <h2 style="margin: 20px" >Setting</h2>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-4" >
                <div class="search-container">
                    <form action="/action_page.php">
                        <input type="text" placeholder="Search..." name="search">
                        <button type="button" class="btn  btn-sm">
                            <span data-feather="search"></span>
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-sm-4">
                
            
            </div>
        </div>
    </jsp:body>
</t:dashboard>