<%@ page import="DAO.ArticleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.CommentsPOJO" %>
<%@ page import="POJO.ArticlePOJO" %><%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 8/10/2018
  Time: 12:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Article comments</title>
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<body>

<%

    ArticleDAO newArticleDAO = new ArticleDAO();

    List<CommentsPOJO> listOfComments = newArticleDAO.getAllComments(request.getSession().getAttribute("articleID_comment").toString());
    List<ArticlePOJO> listOfArticles = newArticleDAO.loadAllArticles();


            for (CommentsPOJO cpj: listOfComments){
                out.println("<b>" + cpj.getUserID() + "</b>");
                out.println("<p>" + cpj.getComments() + "</p>");
                out.println("<br>");
                out.println("---");
            }

    out.print("<form action=\"/CommentServlet\" method=\"get\">");
    out.print("<input type=\"text\" name=\"comments_content\">");
    out.print("<input type=\"submit\" value=\"Add New Comment\" name=\"add_comment_button\"\">");
    out.print("</form>");



%>

</body>
</html>
