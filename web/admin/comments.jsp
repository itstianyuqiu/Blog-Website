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
            <th class="text-center" width="40"><input type="checkbox"></th>
            <th>Author</th>
            <th>Comment</th>
            <th>Which Comment</th>
            <th>Day</th>
            <th>Status</th>
            <th class="text-center" width="100">Operation</th>
          </tr>
        </thead>
        <tbody>
          <tr class="danger">
            <td class="text-center"><input type="checkbox"></td>
            <td>aaa</td>
            <td>aaaaaaaaaaaa</td>
            <td>aaaaaaaaaaa</td>
            <td>2016/10/07</td>
            <td>hidden</td>
            <td class="text-center">
              <a href="post-add.html" class="btn btn-info btn-xs">show</a>
              <a href="javascript:;" class="btn btn-danger btn-xs">hidden</a>
            </td>
          </tr>

        </tbody>
      </table>
    </div>
</body>


  <script src="../JQuery_lib/jquery-3.3.1.js"></script>
  <script src="../vendors/bootstrap/js/bootstrap.js"></script>


</html>
