<%@ page import="POJO.AdminPOJO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Dashboard &laquo; Admin</title>
    <link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="../adminCSS/admin.css">
</head>
<style>
    iframe {
        display: none;
        border: 0;
    }
</style>
<body>

<div class="main">
    <nav class="navbar">
        <button class="btn btn-default navbar-btn fa fa-bars"></button>
        <ul class="nav navbar-nav navbar-right">
            <li><a class="logout"><em class="fa fa-sign-out"></em>log out ..</a></li>
        </ul>
    </nav>
    <iframe name="contentPage" width="1396px" height="682px" frameborder="no"></iframe>

    <div class="container-fluid">
        <div class="jumbotron text-center">
            <h1>One Belt, One Road</h1>
            <p>Thoughts, stories and ideas.</p>
            <p>balabalabalabalabalabalabalabalabalabalabalabalabalabalabalabalabalabalabalabalabalabala</p>
        </div>
    </div>
    </iframe>
</div>

<div class="aside">
    <div class="profile">
        <img class="avatar" src="../images/default.png">
        <h3 class="name">
            <% AdminPOJO managerPOJO = (AdminPOJO) session.getAttribute("admin");
                if (managerPOJO != null) {
                    out.print(managerPOJO.getAdminName());
                } else {
                    response.sendRedirect("admin/login.jsp");
                }
            %>
        </h3>
    </div>
    <ul class="nav">

        <li>
            <a href="articles.jsp" class="collapsed" target="contentPage">
                <em class="fa fa-thumb-tack"></em>Articles
            </a>
        </li>
        <li>
            <a href="comments.jsp" target="contentPage">
                <em class="fa fa-comments"></em>Comments
            </a>
        </li>
        <li>
            <a href="/AdminUserServlet?adminuser=getalluser&currentpage=1" target="contentPage">
                <em class="fa fa-users"></em>users
            </a>
        </li>
        <li>
            <a href="add_user.jsp" target="contentPage">
                <em class="fa fa-users"></em>Add User
            </a>
        </li>

    </ul>

</div>

</body>


<script src="../JQuery_lib/jquery-3.3.1.js"></script>
<script src="../vendors/bootstrap/js/bootstrap.js"></script>

<script>
    $(".nav li").click(function () {
        $("iframe").css("display", "block");
        $(".container-fluid").css("display", "none");
    });
    $(".logout").click(function () {
        location.href = "/AdminQuitServlet"
        return false;
    });
</script>

</html>
