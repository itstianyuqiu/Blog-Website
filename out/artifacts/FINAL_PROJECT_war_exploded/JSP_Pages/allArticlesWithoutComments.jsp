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
    <link rel="stylesheet" href="../homepageCSS/popUpCss.css">
    <link rel="stylesheet" href="../mainPageCSS/new_index.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../myJS.js"></script>
</head>

<body>

<%
    ArticleDAO newArticleDAO = new ArticleDAO();
    List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticles();

    for (ArticlePOJO a : allArticles) {
//
//        var len = xhr.length<4?xhr.length:4;

            out.println("<div class=\"box\">");
            out.println("     <div class=\"card\" >");
            out.println("<a href=\"article.html\"><img src=\"images/test1.jpg\" alt=\"Avatar\" style=\"width:100%\" ></a>");
            out.println("<div class=\"container\">");
            out.println("<h4><b>" + a.getTitle() + "</b></h4>");

            out.println("<p>" + a.getContent() + "</p>");

        out.println("</div>");
        out.println("</div>");
        out.println("</div>");



    }





%>
</body>
</html>
