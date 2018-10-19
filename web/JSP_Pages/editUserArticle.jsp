<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ImagePOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 5/10/2018
  Time: 3:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Article</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="../TianCSS/article_edit.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
</head>
<body>

    <%

    /* This page displays a form where the user is able to update the details of the article they wish to edit. The existing details
    * of the article are passed on from the previous page so they are prepopulated in the fields so they can edit if they wish and don't
    * have to start again*/

    ArticlePOJO apj = (ArticlePOJO) request.getSession().getAttribute("editArticle");
%>

<form action="/ArticleUpload" method="post" enctype="multipart/form-data">
    <div id="container">
        <div id="nav">
            <img id="index_logo" src="images/icon_logo.png">
            <input type="search" id="search_bar" placeholder=" Search..."/>
        </div>
        <div id="container2">
            <div id="main">
                <div class="wrapper">
                    <div class="one">
                        <div class="card">
                            <div class="container">
                                <br>
                                <section>
                                    <b>New Heading: </b>
                                    <input id="edit_article_title" type="text" name="article_heading"
                                           value="<%=apj.getTitle()%>">
                                    <br>
                                    <br>
                                    <b>New Content: </b>
                                    <form method="post">
                                        <textarea id="summernote"
                                                  name="article_content"><%=apj.getContent()%></textarea>
                                    </form>

                                    <script>
                                        $(document).ready(function () {
                                            $('#summernote').summernote();
                                        });
                                    </script>
                                    <br>
                                    <br>

                                    <%--<textarea name="article_content" rows="10" cols="10"><%=apj.getContent()%></textarea>--%>
                                    <b>Publishing Date:</b>
                                    <input id="theDate" type="date" name="article_date"
                                           value="<%=apj.getArticle_date()%>">
                                    <br>
                                    <br>
                                    <b>Choose the images you want to delete: </b>
                                    <br>
                                    <br>
                                    <%
                                        try (ArticleDAO newArticleDAO = new ArticleDAO()) {
                                            List<ImagePOJO> allImages = newArticleDAO.loadImageFromArticle(apj.getArticle_id());
                                            request.getSession().setAttribute("allImages", allImages);
                                            for (ImagePOJO i : allImages) {
                                                out.println("<img src=\"../Uploaded_Images/" + i.getSource() + "\"" + "width=\"200\">");
                                                out.println("<input type=\"checkbox\" name=\"checkbox_" + i.getImage_id() + "\" value=\"" + i.getImage_id() + "\">");
                                            }
                                            out.println("<input type=\"file\" id=\"picture\" name=\"picture\" accept=\"image/png, image/jpeg\" multiple>");
                                        } catch (Exception e) {
                                            e.getMessage();
                                        }
                                    %>

                                    <br>
                                    <br>
                                    <b>Add more images: </b>
                                    <br>
                                    <br>
                                    <input id="btn_update_article" type="submit" name="updateArticle" value="Update">
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<a href="../homepage.jsp">
    <button id="edit_cancel">Cancel</button>
</a>
