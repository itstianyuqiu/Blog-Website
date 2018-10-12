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
    try (ArticleDAO newArticleDAO = new ArticleDAO()){

        List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticles();

        for (ArticlePOJO a : allArticles) {

            out.println("<h4>" + a.getTitle() + "</h4>");
            out.println("<br>");
            out.println("<p>" + a.getContent() + "</p>");
            out.println("<br>");
            int articleID = a.getArticle_id();
            if (request.getSession().getAttribute("userLogged") != null) {
                out.println("<div id=\"" + articleID + "\"" + ">Something</div>");
                if (request.getSession().getAttribute("firstLogin").toString().equals("true")){
                    request.getSession().setAttribute("button_" + articleID, false);

                %>
                <script>hideVisibility(<%=articleID%>);</script>
                <%
                 }
                %>
                <form action="/CommentServlet" method="get">
                    <input type="submit" id="button_<%=articleID%>" value="Show/Hide Comments" name="comment_button">
                    <input type="hidden" name="current_article" value="<%=articleID%>">
                    <input type="hidden" name="button_id" value="button_<%=articleID%>">
                    <input type="hidden" name="page" value="allArticles">
                </form>
                <%
                String currentArticle = request.getSession().getAttribute("current_article").toString();
                String currentButton = request.getSession().getAttribute("button_" + articleID).toString();
                request.getSession().setAttribute("commentsList", null);
                if ((articleID == Integer.parseInt(currentArticle)) && (currentButton.equals("true"))){
                %>
                <script>
                    showVisibility(<%=currentArticle%>);
                    loadArticleCommentsJSP(<%=currentArticle%>);
                </script>
                <%
            }
                else {
                %><script>hideVisibility(<%=articleID%>);</script><%;
                }
            }
        }
            request.getSession().setAttribute("firstLogin", false);
        }
        catch (Exception e){
            e.getMessage();
        }
        %>
</body>
</html>
