<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.ImagePOJO" %><%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 18/10/2018
  Time: 4:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
    <style>
        .images{
            margin: 10px;
            border: solid black 3px;
        }

        .audios{
            margin: 10px;
            border: solid red 3px;
        }

        .videos{
            margin: 10px;
            border: solid aqua 3px;
        }

    </style>
</head>
<body>

<%
    try (ArticleDAO newArticleDAO = new ArticleDAO()) {
        List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticles();

        out.println("<h3>All Images: </h3>");
        for (ArticlePOJO eachArticle: allArticles){
            List<ImagePOJO> images = newArticleDAO.loadImageFromArticle(eachArticle.getArticle_id());
            for (ImagePOJO singleImage: images){
                out.print("<img class =\"images\" src=\"../Uploaded_Images/" + singleImage.getSource() + "\"" + "width=\"200\">");
            }
        }

        out.println("<h3> All Audio: </h3>");
        for (ArticlePOJO eachArticle: allArticles){
            if (eachArticle.getArticle_audio() != null){
                out.println("<audio controls>");
                out.println("<source class =\"audios\" src=\"../Uploaded_Audio/" + eachArticle.getArticle_audio() + "\" type=\"audio/mp3\">");
                out.println("</audio>");
            }
        }

        out.println("<h3>All Video: </h3>");
        for (ArticlePOJO eachArticle: allArticles) {
            if (eachArticle.getArticle_video() != null){
                out.println("<video width=\"200px\" height=\"150px\" controls>");
                out.println("<source class =\"audios\" src=\"../Uploaded_Video/" + eachArticle.getArticle_video() + "\" type=\"video/mp4\">");
                out.println("</video>");
            }
        }


    }
    catch (Exception e){

    }


%>

</body>
</html>
