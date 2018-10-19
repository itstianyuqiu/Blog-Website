<%@ page import="POJO.AdminPOJO" %>
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
            <th class="text-center" width="40"><input type="checkbox"></th>
            <th>Title</th>
            <th>Author</th>

            <th class="text-center">Created Date</th>
            <th class="text-center">Status</th>
            <th class="text-center" width="150">Operation</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="text-center"><input type="checkbox"></td>
            <td>aaaaaaaaaaaaaaaaa</td>
            <td>aaaaaaaaaaaaa</td>
            <td>aaaaaaaaaaaaaaaaa</td>
            <td class="text-center">2016/10/07</td>
            <td class="text-center">
              <a href="javascript:;" class="btn btn-default btn-xs">show</a>
              <a href="javascript:;" class="btn btn-danger btn-xs">hidden</a>
            </td>
          </tr>
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
