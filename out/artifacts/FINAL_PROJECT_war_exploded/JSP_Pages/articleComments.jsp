<%@ page import="DAO.ArticleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.CommentsPOJO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="POJO.UserPOJO" %><%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 8/10/2018
  Time: 12:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Article comments</title>
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<body>


<%

    try (ArticleDAO newArticleDAO = new ArticleDAO()){
        String current_article = request.getSession().getAttribute("current_article").toString();

        System.out.println(current_article);

        List<CommentsPOJO> listOfComments = newArticleDAO.getCommentsByArticle(current_article);
            for (CommentsPOJO cpj: listOfComments){
                out.print("<div id =\"comment_" + cpj.getCommentID() +"\">");
                out.println("<b>" + cpj.getUserID() + "</b>");
                out.println("<p>" + cpj.getComments() + "</p>");
                int commentID = cpj.getCommentID();

                String userID = request.getSession().getAttribute("userID").toString();

                if (userID.equals("" + cpj.getUserID())){
                    out.println("<form action=\"/CommentServlet\" method=\"get\">");
                    out.println("<input type=\"submit\" value=\"Delete Comment\" name=\"delete_comment_button\"\">");
                    out.println("<input type=\"hidden\" name=\"comment_ID\" value=\"" + commentID + "\">");
                    out.println("</form>");
                }

                out.println("<form action=\"/CommentServlet\" method=\"get\">");
                out.println("<input type=\"text\" name=\"comments_content\">");
                out.println("<input type=\"submit\" value=\"Comment On Comment\" name=\"comment_on_comment_button\"\">");
                out.println("</form>");

                out.println("<br>");
                out.println("<hr>");
                out.print("</div>");
            }

            out.println("<hr>");
            out.println("<form action=\"/CommentServlet\" method=\"get\">");
            out.println("<input type=\"text\" name=\"comments_content\">");
            out.println("<input type=\"submit\" value=\"Add New Comment\" name=\"add_comment_button\"\">");
            out.println("</form>");

    } catch (Exception e) {
        e.printStackTrace();
    }


%>

</body>
</html>
