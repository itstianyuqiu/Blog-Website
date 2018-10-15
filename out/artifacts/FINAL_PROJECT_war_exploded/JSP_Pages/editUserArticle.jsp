<%@ page import="POJO.ArticlePOJO" %><%--
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

<%
    //Displays the existing value of article title and content in the edit article form

    ArticlePOJO apj = (ArticlePOJO) request.getSession().getAttribute("editArticle");
    System.out.println(apj.getTitle());
    System.out.println(apj.getContent());
%>

<form action="/UpdateArticleDatabase" method="get">
    <b>New Heading: </b>
    <input type="text" name="new_article_heading" value="<%=apj.getTitle()%>">
    <b>New Content: </b>
    <textarea name="new_article_content" rows="10" cols="10"><%=apj.getContent()%></textarea>
    <br>
    <input type="submit" name="updateArticle" value="Update">
</form>

</body>
</html>
