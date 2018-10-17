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
    //Displays the existing value of article title and content in the edit article form

    ArticlePOJO apj = (ArticlePOJO) request.getSession().getAttribute("editArticle");
%>

<form action="/UpdateArticleDatabase" method="get">
    <b>New Heading: </b>
    <input type="text" name="new_article_heading" value="<%=apj.getTitle()%>">
    <b>New Content: </b>
    <textarea name="new_article_content" rows="10" cols="10"><%=apj.getContent()%></textarea>
    <br>
    <%
        try (ArticleDAO newArticleDAO = new ArticleDAO()){
            List<ImagePOJO> allImages = newArticleDAO.loadImageFromArticle(apj.getArticle_id());
            request.getSession().setAttribute("allImages", allImages);
            for (ImagePOJO i : allImages ) {
                out.println("<img src=\"../Article_Photos/" + i.getSource() + "\"" + "width=\"200\">");
                out.println("<input type=\"checkbox\" name=\"checkbox_" + i.getImage_id() + "\" value=\"" + i.getImage_id() + "\">");

            }
        }
        catch (Exception e){
            e.getMessage();
        }
    %>>
    <input type="submit" name="updateArticle" value="Update">
</form>

</body>
</html>
