<%@ page import="POJO.AdminPOJO" %>
<%@ page import="POJO.CommentsPOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="DAO.ArticleDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.rmi.server.ExportException" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Articles &laquo; Admin</title>
  <link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.css">
  <link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.css">
  <link rel="stylesheet" href="../adminCSS/admin.css">
</head>
<body>


    <div class="container-fluid">
      <div class="page-title">
        <h1>ALL ARTICLES</h1>
      </div>
      <!-- when have incorrect message -->
      <div class="alert alert-danger">
        <strong>error&excl;</strong>
      </div>
      <div class="page-action">
        <!-- show when multiple checked -->
        <a class="btn btn-danger btn-sm" href="javascript:;" style="display: none">all hidden</a>
        <form class="form-inline">
          <select name="" class="form-control input-sm">
            <option value="">Status</option>
            <option value="">Hidden</option>
            <option value="">Show</option>
          </select>
          <button class="btn btn-default btn-sm">GO</button>
        </form>
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
            <th>Author ID</th>
            <th>Article ID</th>

            <th class="text-center">Article Title</th>
            <th class="text-center">Article Visibility</th>
            <th class="text-center" width="150">Show/Hide Article</th>
          </tr>
        </thead>
        <tbody>
        <%
          try (ArticleDAO newArticleDAO = new ArticleDAO()) {

            List<ArticlePOJO> allArticles = newArticleDAO.loadAllArticlesAdmin();

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

            }
          }
          catch (Exception e){
              e.getMessage();
          }
        %>

        </tbody>
      </table>
      <script>
      function load() {
          $.getJSON('/AdminCommentServlet',{'adminArticles':"quaryAll"},function (xhr) {

          });
      }
      </script>
    </div>



  <script src="../JQuery_lib/jquery-3.3.1.js"></script>
  <script src="../vendors/bootstrap/js/bootstrap.js"></script>
</body>
</html>
