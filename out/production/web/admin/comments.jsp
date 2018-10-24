<%@ page import="DAO.ArticleDAO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.CommentsPOJO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <title>Comments &laquo; Admin</title>
  <link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.css">
  <link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.css">
  <link rel="stylesheet" href="../adminCSS/admin.css">

</head>
<body>
    <div class="container-fluid">
      <div class="page-title">
        <h1>COMMENS</h1>
      </div>
      <!-- when have incorrect message -->
      <!-- <div class="alert alert-danger">
        <strong>错误！</strong>发生XXX错误
      </div> -->
      <div class="page-action">
        <!-- show when multiple checked -->
        <div class="btn-batch" style="display: inline-block">
          <button class="btn btn-info btn-sm">All Show</button>
          <button class="btn btn-warning btn-sm">All Hidden</button>
        </div>
        <ul class="pagination pagination-sm pull-right">
          <li><a href="#">PRO</a></li>
          <li><a href="#">1</a></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">NEXT</a></li>
        </ul>
      </div>
      <table class="table table-striped table-bordered table-hover">
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
          try (ArticleDAO newArticleDAO = new ArticleDAO()) {

            List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticlesAdmin();

            List<CommentsPOJO> allComments = new ArrayList<>();

            for (ArticlePOJO a : allArticles) {
              int articleID = a.getArticle_id();
              List<CommentsPOJO> singleArticleComments = newArticleDAO.getCommentsByArticleAdmin("" + articleID);
              for (CommentsPOJO c : singleArticleComments) {
                allComments.add(c);
              }
            }

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
          }
          catch (Exception e){
            e.getMessage();
          }
        %>

        </tbody>
      </table>
    </div>
</body>


  <script src="../JQuery_lib/jquery-3.3.1.js"></script>
  <script src="../vendors/bootstrap/js/bootstrap.js"></script>


</html>
