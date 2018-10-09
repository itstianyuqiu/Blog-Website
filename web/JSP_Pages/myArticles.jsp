<%@ page import="java.util.List" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="DAO.ArticleDAO" %><%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 5/10/2018
  Time: 12:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    ArticleDAO newArticleDAO = new ArticleDAO();
    List<ArticlePOJO> listOfUserArticles = newArticleDAO.loadUserArticles(request.getSession().getAttribute("userID").toString());

    for (ArticlePOJO apj: listOfUserArticles){
        out.println("<h4>" + apj.getTitle() + "</h4>");
        out.println("<br>");
        out.println("<p>" + apj.getContent() + "</p>");
        out.println("<hr>");
        int articleID = apj.getArticle_id();
        out.print("<form action=\"/UpdateArticleDatabase\" method=\"get\">");
        out.print("<input type=\"submit\" value=\"Delete\" name=\"delete_button\"\">");
        out.print("<input type=\"submit\" value=\"Edit\" name=\"edit_button\"\">");
        out.print("<input type=\"hidden\" name=\"articleID\" value=\"" + articleID + "\">");
        out.print("</form>");
    }
%>


</body>
</html>
