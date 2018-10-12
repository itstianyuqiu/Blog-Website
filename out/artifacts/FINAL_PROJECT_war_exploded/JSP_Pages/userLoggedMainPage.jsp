<%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 5/10/2018
  Time: 12:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User_Main_Page</title>
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<body >

<div id ="side_nav">
    <button onclick="loadUserArticle()">My Articles </button>
    <br>
    <button onclick="loadAllArticleWithComments()">All Articles </button>
    <br>
    <button onclick="addNewArticle()">Add a new article </button>
    <br>

    <button>My Account</button>
</div>

<div id ="articles">
</div>

</body>
</html>
