<%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 5/10/2018
  Time: 1:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="TianCSS/homepage.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <title>Add New Article</title>
</head>
<body>

<form action="/UpdateArticleDatabase" method="get">
    <br>
    <br>
    <h5>Headings:</h5>
    <input type="text" id="newarticile_title" name="article_heading">
    <br>
    <br>
    <h5>Content:</h5>
    <textarea id="newarticile_content" name="article_content" rows="15"> </textarea>
    <br>
    <br>
    <button type="submit" id="btn_newarticle" name="addArticle" value="Add Now">Sumbit</button>

</form>

</body>
</html>
