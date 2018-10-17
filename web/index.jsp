<%--
  Created by IntelliJ IDEA.
  User: Crystal
  Date: 2018/10/16
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>mainPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="mainPageCSS/new_index.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>

</head>
<body>
<div id="container">

    <div id="nav" >
        <img id="index_logo" src="images/icon_logo.png">
        <!--<input type="search" id="search_bar" placeholder=" Search..."/>-->
        <a href="index_login.jsp"><button id="index_login">Login</button></a>
        <a href="index_signup.jsp"><button id="index_register">Register</button></a>
    </div>
    <div id="container2">
        <div id="main">
            <div class="wrapper">

                <div id="all_articles">

                    <script>
                        start();
                    </script>
                </div>
            </div>
        </div>


    </div>
</div>


</body>
</html>
