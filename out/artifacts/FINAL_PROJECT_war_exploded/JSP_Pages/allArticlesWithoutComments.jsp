<%@ page import="DAO.ArticleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="POJO.UserPOJO" %>
<%@ page import="POJO.ImagePOJO" %><%--
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
    <link rel="stylesheet" href="../homepageCSS/popUpCss.css">
    <link rel="stylesheet" href="../mainPageCSS/new_index.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../myJS.js"></script>
</head>

<body>

<%

    /* This page displays a list of all the articles in the database, provided their visibility is set to TRUE and the date of the article is equal to or
     * before the current date. This page is visible regardless of if the user is logged in or not, and is displayed on the index.jsp page */

    try (ArticleDAO newArticleDAO = new ArticleDAO()){
    List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticles();

    for (ArticlePOJO a : allArticles) {
        out.println(" <div class=\"6u\" >");
        out.println("<section class=\"box\">");
        out.println(" <a href=\"#\" class=\"image image-full\"><img src=\"images/pic09.jpg\" alt=\"\"  height=\"272\"/></a>");

        //Add author's name to article when displaying all articles

        UserPOJO user = newArticleDAO.getUserName(String.valueOf(a.getAuthor_id())); //added method in DAO to return user's name details

        out.println("<header>");
        out.println("<h3>" + user.getFirstName() + " " + user.getLastName() + "</h3>");
        out.println("<br>");
        out.println("<i>" + user.getUsername() + "</i>");
        out.println("</header>");
        out.println("<br>");

        // --------------------------------------------------------------------------------

        out.println("<header>");
        out.println("<h3>" + a.getTitle() + "</h3>");
        out.println("</header>");
        out.println("<br>");
        out.println("<i>" + "Publishing Date: " + a.getArticle_date() + "</i>");
        out.println("<br>");
        out.println("<p>" + a.getContent() + "</p>");
        out.println("<br>");

        List <ImagePOJO> allImages = newArticleDAO.loadImageFromArticle(a.getArticle_id());
        for (ImagePOJO i : allImages ) {
            out.println("<img src=\"../Article_Photos/" + i.getSource() + "\"" + "width=\"200\">");
        }


////
//        out.println("<br>");
//        out.println(" <footer class=\"actions\">\n" +
//                " <a href=\"#popup\" class=\"button button-icon button-icon-1\">comments</a>\n");
//        out.println(" <div class=\"popup\" id=\"popup\">");
//        out.println(" <div class=\"popup-inner\">");
//        out.println(" <div class=\"popup__photo\">\n" +
//                " <img src=\"images/pic07.jpg\" alt=\"\">\n" +
//                "   </div>");
//        out.println("<div class=\"popup__text\">\n" +
//                " <h1>Please Login or Sign up!</h1>\n" +
//                "   </div>");
//        out.println("<a class=\"buttonPopUp popUp1\" href=\"index_login.jsp\">Login</a>");
//        out.println(" <a class=\"buttonPopUp popUp2\" href=\"index_signup.jsp\">Sign Up</a>");
//        out.println("<a class=\"popup__close\" href=\"#\">X</a>");
////
////        var len = xhr.length<4?xhr.length:4;
//
//            out.println("<div class=\"box\">");
//            out.println("     <div class=\"card\" >");
//            out.println("<a href=\"article.html\"><img src=\"images/test1.jpg\" alt=\"Avatar\" style=\"width:100%\" ></a>");
//            out.println("<div class=\"container\">");
//            out.println("<h4><b>" + a.getTitle() + "</b></h4>");
//
//            out.println("<p>" + a.getContent() + "</p>");
//
//        out.println("</div>");
//        out.println("</div>");
//        out.println("</div>");



    }
    }
    catch (Exception e){
        e.getMessage();
    }





%>
</body>
</html>
