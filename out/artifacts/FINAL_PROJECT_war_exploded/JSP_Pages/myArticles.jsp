<%@ page import="java.util.List" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="DAO.ArticleDAO" %><%--
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
    <link rel="stylesheet" href="../homepageCSS/cssStyle.css">
    <link rel="stylesheet" href="../homepageCSS/rowPart.css">
    <link rel="stylesheet" href="../homepageCSS/otherCss.css">
    <link rel="stylesheet" href="../homepageCSS/containerCSS.css">
    <link rel="stylesheet" href="../homepageCSS/imageCSS.css">
    <link rel="stylesheet" href="../homepageCSS/popUpCss.css">
    <%--<script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>--%>
    <%--<script type="text/javascript" src="../myJS.js"></script>--%>
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<body>



<%
    System.out.println("got to my articles");

    try (ArticleDAO newArticleDAO = new ArticleDAO()){

        List<ArticlePOJO> allArticles = newArticleDAO.loadUserArticles(request.getSession().getAttribute("userID").toString());

        for (ArticlePOJO a : allArticles) {

            out.println("<h4>" + a.getTitle() + "</h4>");
            out.println("<br>");
            out.println("<p>" + a.getContent() + "</p>");
            out.println("<br>");
            int articleID = a.getArticle_id();

//                out.println("<div id=\"" + articleID + "\"" + ">Something</div>");

                %>
                <%--<form action="/CommentServlet" method="get">--%>
                    <%--<input type="submit" id="button_<%=articleID%>" value="Show/Hide Comments" name="comment_button">--%>
                    <%--<input type="hidden" name="current_article" value="<%=articleID%>">--%>
                    <%--<input type="hidden" name="button_id" value="button_<%=articleID%>">--%>
                    <%--<input type="hidden" name="page" value="myArticles">--%>
                <%--</form>--%>
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
                    %><script>hideVisibility(<%=articleID%>);</script><%
                }

            out.print("<form action=\"/UpdateArticleDatabase\" method=\"get\">");
            out.print("<input type=\"submit\" value=\"Delete\" name=\"delete_button\"\">");
            out.print("<input type=\"submit\" value=\"Edit\" name=\"edit_button\"\">");
            out.print("<input type=\"hidden\" name=\"articleID\" value=\"" + articleID + "\">");
            out.print("</form>");
            }

        }
        catch (Exception e){
        e.getMessage();
        }
%>


</body>
</html>




