<%@ page import="DAO.ArticleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.ArticlePOJO" %><%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 5/10/2018
  Time: 10:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Articles</title>
    <link rel="stylesheet" href="../homepageCSS/cssStyle.css">
    <link rel="stylesheet" href="../homepageCSS/rowPart.css">
    <link rel="stylesheet" href="../homepageCSS/otherCss.css">
    <link rel="stylesheet" href="../homepageCSS/containerCSS.css">
    <link rel="stylesheet" href="../homepageCSS/imageCSS.css">
    <link rel="stylesheet" href="../homepageCSS/popUpCss.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../myJS.js"></script>
</head>

<body>

<%
    ArticleDAO newArticleDAO = new ArticleDAO();
    List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticles();

    for (ArticlePOJO a : allArticles) {
        out.println(" <div class=\"6u\" >");
        out.println("<section class=\"box\">");
        out.println(" <a href=\"http://facebook.com/DreametryDoodle\" class=\"image image-full\"><img src=\"images/pic09.jpg\" alt=\"\"  height=\"272\"/></a>");
        out.println("<header>");
        out.println("<h3>" + a.getTitle() + "</h3>");
        out.println("</header>");
        out.println("<br>");
        out.println("<p>" + a.getContent() + "</p>");
        out.println("<br>");
        out.println(" <footer class=\"actions\">\n" +
                "                                        <a href=\"#popup\" class=\"button button-icon button-icon-1\">comments</a>\n");
        out.println(" <div class=\"popup\" id=\"popup\">");
        out.println(" <div class=\"popup-inner\">");
        out.println(" <div class=\"popup__photo\">\n" +
                " <img src=\"images/pic07.jpg\" alt=\"\">\n" +
                "   </div>");
        out.println("<div class=\"popup__text\">\n" +
                " <h1>Please Login or Sign up!</h1>\n" +
                "   </div>");
        out.println("<a class=\"buttonPopUp popUp1\" href=\"index_login.jsp\">Login</a>");
        out.println(" <a class=\"buttonPopUp popUp2\" href=\"index_signup.jsp\">Sign Up</a>");
        out.println("<a class=\"popup__close\" href=\"#\">X</a>");
        out.println("</div>");
        out.println("</div>");
        out.println(" </footer>");
        out.println("</section>");
        out.println("</div>");
        out.println("<br>");


        out.println("<hr>");
    }
%>
</body>
</html>
