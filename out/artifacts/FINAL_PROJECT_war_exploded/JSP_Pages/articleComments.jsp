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
    <link rel="stylesheet" href="../TianCSS/homepage_my_article_delet_comments_and_child.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
    <style>
        .child_comments{
            margin-left: 20px;
            color: blue;
        }
    </style>
</head>
<body>


<%

    try (ArticleDAO newArticleDAO = new ArticleDAO()){
        String current_article = request.getSession().getAttribute("current_article").toString();

        List<CommentsPOJO> listOfComments = newArticleDAO.getCommentsByArticle(current_article);
            for (CommentsPOJO cpj: listOfComments){
                int commentID = cpj.getCommentID();

                out.println("<div id =\"comment_" + commentID +"\">");

                UserPOJO user = newArticleDAO.getUserName(String.valueOf(cpj.getUserID())); //added method in DAO to return user's name details

                out.println("<b>" + user.getUsername() + "</b>");
                out.println("<p>" + cpj.getComments() + "</p>");

                // Code to get userID and ensure they can only delete comments that they have written
                String userID = request.getSession().getAttribute("userID").toString();
                String pageFrom = request.getSession().getAttribute("page").toString();

                if (userID.equals("" + cpj.getUserID()) || (pageFrom.equals("myArticles"))){
                    out.println("<form action=\"/CommentServlet\" method=\"get\">");
                    out.println("<input id=\"btn_delete_comments\"type=\"submit\" value=\"Delete Comment\" name=\"delete_comment_button\"\">");
                    out.println("<input type=\"hidden\" name=\"comment_ID\" value=\"" + commentID + "\">");
                    out.println("</form>");
                }


                // Check if this comment is a parent comment, if yes then display the childs with userID, comments, and delete button (if written by user).
                if (cpj.isIs_parent()){
                    List<CommentsPOJO> listOfChild = newArticleDAO.getChildComments(commentID);
                    for (CommentsPOJO child: listOfChild){
                        out.println("<div class=\"child_comments\" id =\"child_comment_" + child.getCommentID() +"\">");

                        out.println("<b>" + user.getUsername() + "</b>");
                        out.println("<p>" + child.getComments() + "</p>");

                        if (userID.equals("" + child.getUserID()) || (pageFrom.equals("myArticles"))){
                            out.println("<form action=\"/CommentServlet\" method=\"get\">");
                            out.println("<input id=\"btn_delete_child_comments\"type=\"submit\" value=\"Delete Comment\" name=\"delete_child_comment_button\"\">");
                            out.println("<input type=\"hidden\" name=\"comment_ID\" value=\"" + child.getCommentID() + "\">");
                            out.println("</form>");
                        }

                        out.print("</div>");

                    }
                }


                // Button to make replies to a comment
                out.println("<form action=\"/CommentServlet\" method=\"get\">");
                out.println("<input id=\"text_my_article_add_reply\" type=\"text\" name=\"comment_reply_content\">");
                out.println("<input id=\"btn_my_article_add_reply\" type=\"submit\" value=\"Reply\" name=\"comment_reply\"\">");
                out.println("<input type=\"hidden\" name=\"parent_ID\" value=\"" + commentID + "\">");
                out.println("</form>");

                out.println("<br>");
                out.println("<hr>");
                out.print("</div>");
            }

            out.println("<hr>");
            out.println("<form action=\"/CommentServlet\" method=\"get\">");
            out.println("<input id=\"text_my_article_add_comments\"type=\"text\" name=\"comments_content\">");
            out.println("<input id=\"btn_my_article_add_comments\"type=\"submit\" value=\"Add New Comment\" name=\"add_comment_button\"\">");
            out.println("</form>");

    } catch (Exception e) {
        e.printStackTrace();
    }


%>

</body>
</html>
