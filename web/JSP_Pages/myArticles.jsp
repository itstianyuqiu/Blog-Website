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
    <link rel="stylesheet" href="../TianCSS/homepage.css">
    <%--<link rel="stylesheet" href="../homepageCSS/cssStyle.css">--%>
    <%--<link rel="stylesheet" href="../homepageCSS/rowPart.css">--%>
    <%--<link rel="stylesheet" href="../homepageCSS/otherCss.css">--%>
    <%--<link rel="stylesheet" href="../homepageCSS/containerCSS.css">--%>
    <%--<link rel="stylesheet" href="../homepageCSS/imageCSS.css">--%>
    <%--<link rel="stylesheet" href="../homepageCSS/popUpCss.css">--%>
    <%--<script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>--%>
    <%--<script type="text/javascript" src="../myJS.js"></script>--%>
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<body>

<%


    try (ArticleDAO newArticleDAO = new ArticleDAO()){

        //generate a list of Articles based on the current userID
        List<ArticlePOJO> allArticles = newArticleDAO.loadUserArticles(request.getSession().getAttribute("userID").toString());


        //looping through the generated list
        for (ArticlePOJO a : allArticles) {

            //get current article info
            int articleID = a.getArticle_id();
            String articleTitle = a.getTitle();
            String articleContent = a.getContent();
            String articleDate = a.getArticle_date();

            //generate & print out article title, publishing date and content
            out.println("<h4>" + articleTitle + "</h4>");
            out.println("<br>");
            out.println("<i>" + "Publishing Date: " + articleDate + "</i>");
            out.println("<br>");
            out.println("<p>" + articleContent + "</p>");
            out.println("<br>");

            //generate and print images that belong to this article
            List <ImagePOJO> allImages = newArticleDAO.loadImageFromArticle(articleID);
            for (ImagePOJO i : allImages ) {
                out.println("<img src=\"../Article_Photos/" + i.getSource() + "\"" + "width=\"200\">");
            }
            out.println("<br>");

            //generate a blank comment div (default visibility is false, true when clicked on show comment button)
            out.println("<div id=\"" + articleID + "\"" + ">Something</div>");

            //generate show/hide comment button
                %>
                <form action="/CommentServlet" method="get">
                    <input type="submit" id="button_<%=articleID%>" value="Show/Hide Comments" name="comment_button">
                    <input type="hidden" name="current_article" value="<%=articleID%>">
                    <input type="hidden" name="button_id" value="button_<%=articleID%>">
                    <input type="hidden" name="page" value="myArticles">
                </form>
                <%

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
            out.print("<form action=\"/UpdateArticleDatabase\" method=\"get\">");
            out.print("<input type=\"submit\" value=\"Delete\" name=\"delete_button\"\">");
            out.print("<input type=\"submit\" value=\"Edit\" name=\"edit_button\"\">");
            out.print("<input type=\"hidden\" name=\"articleID\" value=\"" + articleID + "\">");
            out.print("<input type=\"hidden\" name=\"articleTitle\" value=\"" + articleTitle + "\">");
            out.print("<input type=\"hidden\" name=\"articleContent\" value=\"" + articleContent + "\">");
            out.print("</form>");

            }

        }
        catch (Exception e){
        e.getMessage();
        }
%>


</body>
</html>




