<%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 5/10/2018
  Time: 3:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


<form action="/UpdateArticleDatabase" method="get">
    <b>New Heading: </b>
    <input type="text" name="new_article_heading">
    <b>New Content: </b>
    <textarea name="new_article_content" rows="10" cols="10"> </textarea>
    <br>
    <input type="submit" name="updateArticle" value="Update">
</form>

</body>
</html>
