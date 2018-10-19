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
    <title>Title</title>
</head>
<body>

<%

    /* This page displays a form where the user is able to update the details of the article they wish to edit. The existing details
    * of the article are passed on from the previous page so they are prepopulated in the fields so they can edit if they wish and don't
    * have to start again*/

    ArticlePOJO apj = (ArticlePOJO) request.getSession().getAttribute("editArticle");
%>

<form action="/ArticleUpload" method="post" enctype="multipart/form-data">
    <b>New Heading: </b>
    <input type="text" name="article_heading" value="<%=apj.getTitle()%>">
    <b>New Content: </b>
    <textarea name="article_content" rows="10" cols="10"><%=apj.getContent()%></textarea>
    <b>Date: </b>
    <input id="theDate" type="date" name="article_date" value="<%=apj.getArticle_date()%>">
    <br>
    <%
        try (ArticleDAO newArticleDAO = new ArticleDAO()){
            List<ImagePOJO> allImages = newArticleDAO.loadImageFromArticle(apj.getArticle_id());
            request.getSession().setAttribute("allImages", allImages);
            for (ImagePOJO i : allImages ) {
                out.println("<img src=\"../Article_Photos/" + i.getSource() + "\"" + "width=\"200\">");
                out.println("<input type=\"checkbox\" name=\"checkbox_" + i.getImage_id() + "\" value=\"" + i.getImage_id() + "\">");

            }
                out.println("<input type=\"file\" id=\"picture\" name=\"picture\" accept=\"image/png, image/jpeg\" multiple>");
        }
        catch (Exception e){
            e.getMessage();
        }
    %>>
    <input type="submit" name="updateArticle" value="Update">
</form>
    <a href="../homepage.jsp"><button id="edit_cancel">Cancel</button></a>

</body>
</html>
