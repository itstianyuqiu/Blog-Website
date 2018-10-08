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

    List<CommentsPOJO> listOfComments = newArticleDAO.getAllComments(request.getSession().getAttribute("userID").toString(), request.getSession().getAttribute("articleID_comment").toString());

    List<ArticlePOJO> listOfArticles = newArticleDAO.loadAllArticles();

    System.out.println("c" + listOfComments.get(0).getComments());
    System.out.println("a" + listOfArticles.get(0).getTitle());

    for (ArticlePOJO apj : listOfArticles){
        if (apj.getArticle_id() == Integer.parseInt(request.getSession().getAttribute("articleID_comment").toString())){
            for (CommentsPOJO cpj: listOfComments){
                out.println("<h4>" + cpj.getUserID() + "</h4>");
                out.println("<br>");
                out.println("<p>" + cpj.getComments() + "</p>");
                out.println("<hr>");
            }
        }
    }


%>

</body>
</html>
