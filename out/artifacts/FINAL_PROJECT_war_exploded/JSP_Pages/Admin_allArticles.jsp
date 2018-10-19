<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.CommentsPOJO" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 15/10/2018
  Time: 10:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    try (ArticleDAO newArticleDAO = new ArticleDAO()) {

        List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticlesAdmin();

        List<CommentsPOJO> allComments = new ArrayList<>();

        %>

        <table>
            <thead>
            <tr>
                <th>Author ID</th>
                <th>Article ID</th>
                <th>Article Title</th>
                <th>Article Visibility</th>
                <th>Show/Hide Article</th>
            </tr>
            </thead>
            <tbody>
            <%
                 for (ArticlePOJO a : allArticles) {
                     out.println("<tr>");
                     out.println("<td>" + a.getAuthor_id() + "</td>");
                     out.println("<td>" + a.getArticle_id() + "</td>");
                     out.println("<td>" + a.getTitle() + "</td>");
                     out.println("<td>" + a.isArticle_visibility() + "</td>");
                     out.println("<td>");
                     int articleID = a.getArticle_id();
                     out.print("<form action=\"/AdminServlet\" method=\"get\">");
                     out.print("<input type=\"submit\" value=\"Show/Hide Article\" name=\"article_visibility_button\"\">");
                     out.print("<input type=\"hidden\" name=\"articleID\" value=\"" + articleID + "\">");
                     out.print("</form>");
                     out.println("</td");
                     out.println("</tr>");

                     List<CommentsPOJO> singleArticleComments = newArticleDAO.getCommentsByArticleAdmin("" + articleID);

                     for (CommentsPOJO c: singleArticleComments){
                         allComments.add(c);
                         System.out.println(c.isCommentsVisibility());
                     }

        }
        %>

            </tbody>
        </table>

        <hr>

        <table>
            <thead>
            <tr>
                <th>Comment ID</th>
                <th>User ID</th>
                <th>Article ID</th>
                <th>Article Comment</th>
                <th>Comment Visibility</th>
                <th>Show/Hide Comment</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (CommentsPOJO c : allComments) {
                    out.println("<tr>");
                    out.println("<td>" + c.getCommentID() + "</td>");
                    out.println("<td>" + c.getUserID() + "</td>");
                    out.println("<td>" + c.getArticleID() + "</td>");
                    out.println("<td>" + c.getComments() + "</td>");
                    out.println("<td>" + c.isCommentsVisibility() + "</td>");
                    out.println("<td>");
                    int commentID = c.getCommentID();
                    out.print("<form action=\"/AdminServlet\" method=\"get\">");
                    out.print("<input type=\"submit\" value=\"Show/Hide Comment\" name=\"comment_visibility_button\"\">");
                    out.print("<input type=\"hidden\" name=\"commentID\" value=\"" + commentID + "\">");
                    out.print("</form>");
                    out.println("</td");
                    out.println("</tr>");
                }
            %>

            </tbody>
        </table>

        <%
    }
    catch (Exception e){
        System.out.println(e.getMessage());
    }

%>

</body>
</html>
