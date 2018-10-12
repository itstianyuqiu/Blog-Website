<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Crystal
  Date: 2018/10/11
  Time: 15:20
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
                "                                        <a href=\"#popup\" class=\"button button-icon button-icon-1\">Read the whole article</a>\n");
        out.println(" <a href=\"#popup\" class=\"button button-alt button-icon button-icon-2\">comments</a>");

        out.println(" </footer>");
        out.println("</section>");
        out.println("</div>");
        out.println("<br>");
        int articleID = a.getArticle_id();

        if (request.getSession().getAttribute("userLogged") != null) {
            out.println("<div class=\"comments\" visibility=\"visible\" id=\"" + articleID + "\"" + "></div>");
            if (Boolean.parseBoolean(request.getSession().getAttribute("buttonClicked").toString()) == false) {
                    %>
                        <script>
                            hideVisibility();
                        </script>
                    <%
            }
            out.println("<form action=\"/CommentServlet\" method=\"get\">");
            out.println("<input onclick=\"showVisibility()\" type=\"submit\" value=\"Comments\" name=\"comment_button\">");
                     %>
                    <script>
                         loadArticleCommentsJSP();
                    </script>
<%
            out.println("<input type=\"hidden\" name=\"articleID_comment\" value=\"" + articleID + "\">");
            out.println("</form>");
        }
        out.println("<hr>");
    }
%>
</body>
</html>
