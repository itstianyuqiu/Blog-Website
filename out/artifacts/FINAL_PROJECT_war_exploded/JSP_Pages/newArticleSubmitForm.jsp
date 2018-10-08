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
    <title>Add New Article</title>
</head>
<body>

<form action="/UpdateArticleDatabase" method="get">

    <b>Headings: </b>
    <input type="text" name="article_heading">

    <b>Content: </b>
    <textarea name="article_content" rows="10" cols="10"> </textarea>

    <br>

    <input type="submit" name="addArticle" value="Add Now">

</form>

</body>
</html>
