<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.UserPOJO" %><%--
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

            UserPOJO user = newArticleDAO.getUserName(String.valueOf(a.getAuthor_id())); //added method in DAO to return user's name details

            out.println("<header>");
            out.println("<h3>" + user.getFirstName() + " " + user.getLastName() + "</h3>");
            out.println("<br>");
            out.println("<h5>" + user.getUsername() + "</h5>");
            out.println("</header>");
            out.println("<br>");

            out.println("<h4>" + a.getTitle() + "</h4>");
            out.println("<br>");
            out.println("<p>" + a.getContent() + "</p>");
            out.println("<br>");
            int articleID = a.getArticle_id();

                out.println("<div id=\"" + articleID + "\"" + ">Something</div>");

                //If this is first login, set all comments button to false & hide all comments div
                if (request.getSession().getAttribute("firstLogin_AllArticles").toString().equals("true")){
                    request.getSession().setAttribute("button_" + articleID, false);
                    %>
                    <script>hideVisibility(<%=articleID%>);</script>
                    <%
                 }

                // Code to create show/hide comments button. When submit passing on current article ID & current button ID & current page "all articles"
                %>
                <form action="/CommentServlet" method="get">
                    <input type="submit" id="button_<%=articleID%>" value="Show/Hide Comments" name="comment_button">
                    <input type="hidden" name="current_article" value="<%=articleID%>">
                    <input type="hidden" name="button_id" value="button_<%=articleID%>">
                    <input type="hidden" name="page" value="allArticles">
                </form>
                <%

                // Get the current article & button session, if matches with the current iteration of the loop, then show & load the comments div.
                String currentArticle = request.getSession().getAttribute("current_article").toString();
                String currentButton = request.getSession().getAttribute("button_" + articleID).toString();

                if ((articleID == Integer.parseInt(currentArticle)) && (currentButton.equals("true"))){
                    %>
                        <script>
                            showVisibility(<%=currentArticle%>);
                            loadArticleCommentsJSP(<%=currentArticle%>);
                        </script>
                    <%
                }
                else {
                    %>
                        <script>hideVisibility(<%=articleID%>);</script>
                    <%
                }

        }
            request.getSession().setAttribute("firstLogin_AllArticles", false);
        }
        catch (Exception e){
            e.getMessage();
        }
        %>
</body>
</html>
