<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    </head>

    <body>
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
                                <li><a class="dropdown-item" href="#">Dark mode</a></li>
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
            <!-- <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Cofano-C</a> -->
        </nav>

        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar collapse navbar-collapse" id="sidebar">
                    <div class="sidebar-sticky">

                        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
                            <span>MAIN</span>
                        </h6>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">
                                    <span data-feather="home"></span>
                                    dashboard <span class="sr-only">(current)</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="layers"></span>
                                    application integrations
                                </a>
                            </li>
                        </ul>

                        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
                            <span>DATABASES</span>
                        </h6>
                        <ul class="nav flex-column mb-2">
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="layers"></span>
                                    vessels
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <span data-feather="clock"></span>
                                    history
                                </a>
                            </li>
                        </ul>

                        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1">
                            <span>ADMINISTRATION</span>
                        </h6>
                        <ul class="nav flex-column mb-3">
                            <a class="nav-link" href="#">
                                <span data-feather="book-open"></span>
                                API-documentation
                            </a>
                        </ul>
                    </div>
                </nav>

                <main role="main" class="cofano-main col-md-9 ml-sm-auto col-lg-10 px-4">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Dashboard</h1>
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

                    <canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>

                    <h2>Section title</h2>
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
                    </div>
                </main>
            </div>
        </div>

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script>window.jQuery</script>
        <script src="./js/bootstrap.min.js"></script>

        <!-- Icons -->
        <script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
        <script>
            feather.replace()
        </script>

        <!-- Graphs -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
        <script>
            var ctx = document.getElementById("myChart");
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
                    datasets: [{
                        data: [15339, 21345, 18483, 24003, 23489, 24092, 12034],
                        lineTension: 0,
                        backgroundColor: 'transparent',
                        borderColor: '#007bff',
                        borderWidth: 4,
                        pointBackgroundColor: '#007bff'
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: false
                            }
                        }]
                    },
                    legend: {
                        display: false,
                    }
                }
            });
        </script>
    </body>
</html>
