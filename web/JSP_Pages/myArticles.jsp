<%@ page import="java.util.List" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ImagePOJO" %><%--
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
    <link rel="stylesheet" href="../TianCSS/homepage_my_article_add_comments.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../myJS.js"></script>
</head>
<body>

<%


    try (ArticleDAO newArticleDAO = new ArticleDAO()){

        //generate a list of Articles based on the current userID
        List<ArticlePOJO> allArticles = newArticleDAO.loadUserArticles(request.getSession().getAttribute("userID").toString());

        //looping through the generated list
        for (ArticlePOJO a : allArticles) {
            out.println("<hr>");
            //get current article info
            int articleID = a.getArticle_id();
            String articleTitle = a.getTitle();
            String articleContent = a.getContent();
            String articleDate = a.getArticle_date();

            String formattedContent = "";

            String [] parts = articleContent.split("\"");
            for (int i = 0; i < parts.length; i++){
                if (i != parts.length - 1){
                    formattedContent = formattedContent + parts[i] +"&quot;";
                }
                else {
                    formattedContent = formattedContent + parts[i];
                }
            }

            System.out.println(formattedContent);

            //generate & print out article title, publishing date and content
            out.println("<h4>" + articleTitle + "</h4>");
            out.println("<br>");
            out.println("<i>" + "Publishing Date: " + articleDate + "</i>");
            out.println("<br>");
            out.println(articleContent);
            out.println("<br>");


            //generate and print images that belong to this article
            out.println("<h5>" + "Photos: " + "</h5>");
            List <ImagePOJO> allImages = newArticleDAO.loadImageFromArticle(articleID);
            for (ImagePOJO i : allImages ) {
                if (i != null){
                    out.println("<img src=\"../Uploaded_Images/" + i.getSource() + "\"" + "width=\"200\">");
                }
            }
            out.println("<br>");

            //generate and print the audio that belongs to this article
            if (a.getArticle_audio() != null){
                out.println("<h5>" + "Audio: " + "</h5>");
                out.println("<audio controls>");
                out.println("<source src=\"../Uploaded_Audio/" + a.getArticle_audio() + "\" type=\"audio/mp3\">");
                out.println("<source src=\"../Uploaded_Audio/" + a.getArticle_audio() + "\" type=\"audio/ogg\">");
                out.println("Your browser does not support the audio element");
                out.println("</audio>");
            }


            //generate and print the video that belongs to this article
            if (a.getArticle_video() != null){
                out.println("<h5>" + "Video: " + "</h5>");
                out.println("<video width=\"320px\" height=\"240px\" controls>");
                out.println("<source src=\"../Uploaded_Video/" + a.getArticle_video() + "\" type=\"video/mp4\">");
                out.println("<source src=\"../Uploaded_Video/" + a.getArticle_video() + "\" type=\"video/ogg\">");
                out.println("Your browser does not support the video tag.");
                out.println("</video>");
            }

            //generate and print the youtube that belongs to this article
            if (!a.getArticle_Youtube().equals("")){
                out.println("<h5>" + "Youtube: " + "</h5>");
                %>
                <iframe width="560" height="315" src="https://www.youtube.com/embed/<%=a.getArticle_Youtube()%>" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen> </iframe>
                <%
            }

            //generate a blank comment div (default visibility is false, true when clicked on show comment button)
            out.println("<div id=\"" + articleID + "\"" + ">Something</div>");

            //generate show/hide comment button
                %>

                <form action="/CommentServlet" method="get">
                    <input class="btn_show_hide"type="submit" id="button_<%=articleID%>" value="Show/Hide Comments" name="comment_button">
                    <input type="hidden" name="current_article" value="<%=articleID%>">
                    <input type="hidden" name="button_id" value="button_<%=articleID%>">
                    <input type="hidden" name="page" value="myArticles">
                </form>
                <%

                    if (request.getSession().getAttribute("firstLogin_MyArticles").toString().equals("true")){
                        request.getSession().setAttribute("button_" + articleID, false);
                        %>
                        <script>hideVisibility(<%=articleID%>);</script>
                        <%
                    }


            // get the session of current article and current button, if matches with the current iteration of the loop then show
            String currentArticle = request.getSession().getAttribute("current_article").toString();
            String currentButton = request.getSession().getAttribute("button_" + articleID).toString();

            //Get the current article & button session, if matches with the current iteration of the loop, then show & load the comments div.
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
                    <script>
                        hideVisibility(<%=articleID%>);
                    </script>
                <%
            }

            //create the Delete and Edit buttons, passing on current article ID
                %>
                <form action="/UpdateArticleDatabase" method="get">
                    <input class="btn_my_article_edit" type="submit" value="Edit" name="edit_button">
                    <input type="hidden" name="articleID" value="<%=articleID%>">
                    <input type="hidden" name="articleTitle" value="<%=articleTitle%>">
                    <input type="hidden" name="articleContent" value="<%=formattedContent%>">
                    <input type="hidden" name="articleDate" value="<%=articleDate%>">
                </form>
                <%


            // ----------------------------------------------------------------------------------------------


                    //Button to delete article; if clicked a form will be shown asking if they are sure they want to delete the article. If yes,
                    // then the article will be deleted, if no then it will go back to the previous state

                %>
                    <button type="button" id="del_article_button_<%=articleID%>" onclick="showDeleteArticleForm(<%=articleID%>)">Delete Article</button>
                        <div id="delete_article_<%=articleID%>" style="display: none">
                            <br>
                            <b>Are you sure you want to delete this article?</b>
                            <br>
                            <form action="/UpdateArticleDatabase" method="get">
                            <input id="btn_my_article_delete" type="submit" value="Yes, Delete" name="delete_button">
                            <input type="hidden" name="articleID" value="<%=articleID%>">
                            </form>
                            <button id="delete_cancel" onclick="cancelDeleteArticleForm(<%=articleID%>)">No</button>
                        </div>

                <%

            }

            request.getSession().setAttribute("firstLogin_MyArticles", false);

        }
        catch (Exception e){
        e.getMessage();
        }
%>


</body>
</html>




