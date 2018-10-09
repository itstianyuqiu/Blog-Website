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
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>

<body>

<%

    ArticleDAO newArticleDAO = new ArticleDAO();
    List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticles();


    for (ArticlePOJO a : allArticles) {
        out.println("<h4>" + a.getTitle() + "</h4>");
        out.println("<br>");
        out.println("<p>" + a.getContent() + "</p>");
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
