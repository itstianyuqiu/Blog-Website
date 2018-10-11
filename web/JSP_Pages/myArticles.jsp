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
    <link rel="stylesheet" href="../homepageCSS/cssStyle.css">
    <link rel="stylesheet" href="../homepageCSS/rowPart.css">
    <link rel="stylesheet" href="../homepageCSS/otherCss.css">
    <link rel="stylesheet" href="../homepageCSS/containerCSS.css">
    <link rel="stylesheet" href="../homepageCSS/imageCSS.css">
    <link rel="stylesheet" href="../homepageCSS/popUpCss.css">
    <%--<script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>--%>
    <%--<script type="text/javascript" src="../myJS.js"></script>--%>
</head>
<body>

<%
    ArticleDAO newArticleDAO = new ArticleDAO();
    List<ArticlePOJO> listOfUserArticles = newArticleDAO.loadUserArticles(request.getSession().getAttribute("userID").toString());

    for (ArticlePOJO apj: listOfUserArticles){
        out.println(" <div class=\"6u\" >");
        out.println("<section class=\"box\">");
        out.println(" <a href=\"http://facebook.com/DreametryDoodle\" class=\"image image-full\"><img src=\"images/pic09.jpg\" alt=\"\"  height=\"272\"/></a>");
        out.println("<header>");
        out.println("<h3>" + apj.getTitle() + "</h3>");
        out.println("</header>");
        out.println("<br>");
        out.println("<p>" + apj.getContent() + "</p>");
        out.println("<hr>");
        out.println("</section>");
        out.println("</div>");
        out.println("<br>");
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
