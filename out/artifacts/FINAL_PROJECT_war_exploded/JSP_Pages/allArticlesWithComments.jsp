<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.UserPOJO" %>
<%@ page import="POJO.ImagePOJO" %><%--
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
    <link rel="stylesheet" href="../TianCSS/homepage_all_article_add_comments.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../myJS.js"></script>
</head>

<body>
<%

    /* This page displays a list of all the articles in the database, provided their visibility is set to TRUE and the date of the article is equal to or
     * before the current date. This page is only visible if the user is logged in */

    try (ArticleDAO newArticleDAO = new ArticleDAO()){

        List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticles();

        for (ArticlePOJO a : allArticles) {

            //get current article info
            int articleID = a.getArticle_id();
            String articleTitle = a.getTitle();
            String articleContent = a.getContent();
            String articleDate = a.getArticle_date();

            //get user info based on the author_id (i.e. who wrote the article)
            UserPOJO user = newArticleDAO.getUserName(String.valueOf(a.getAuthor_id()));

            //display user First Name, Last Name and Username
            out.println("<header>");
            out.println("<h3>" + user.getFirstName() + " " + user.getLastName() + "</h3>");
            out.println("<br>");
            out.println("<i>" + user.getUsername() + "</i>");
            out.println("</header>");
            out.println("<br>");

            //generate & print out article title, publishing date and content
            out.println("<h4>" + "Heading: " + articleTitle + "</h4>");
            out.println("<br>");
            out.println("<i>" + "Publishing Date: " + articleDate + "</i>");
            out.println("<br>");
            out.println("<p>" + "Content: " +  articleContent + "</p>");
            out.println("<br>");

            //generate and print images that belong to this article
            List <ImagePOJO> allImages = newArticleDAO.loadImageFromArticle(articleID);
            for (ImagePOJO i : allImages ) {
                out.println("<img src=\"../Uploaded_Photos/" + i.getSource() + "\"" + "width=\"200\">");
            }
            out.println("<br>");

            //generate a blank comment div (default visibility is false, true when clicked on show comment button)
            out.println("<div id=\"" + articleID + "\"" + ">Something</div>");

                //If this is first login, set all comments button to false & hide all comments div


                // Code to create show/hide comments button. When submit passing on current article ID & current button ID & current page "all articles"
                %>
                <form action="/CommentServlet" method="get">
                    <input class="btn_show_hide_all"type="submit" id="button_<%=articleID%>" value="Show/Hide Comments" name="comment_button">
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
            //Sets the first_login session to false (outside the loop so after all articles have been loaded)
            request.getSession().setAttribute("firstLogin_AllArticles", false);
        }
        catch (Exception e){
            e.getMessage();
        }
        %>
</body>
</html>
