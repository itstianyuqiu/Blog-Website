<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <title>Sign in &laquo; Admin</title>
  <link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.css">
  <link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.css">
  <link rel="stylesheet" href="../adminCSS/admin.css">
</head>
<body>
  <div class="login">
    <div class="login-wrap" >
      <img class="avatar" src="../images/default.png">
       <!--when have incorrect message -->
      <div class="alert alert-danger">
        <strong></strong>
      </div>
      <div class="form-group">
        <label for="username" class="sr-only">Admin User Name</label>
        <input id="username" type="username" class="form-control" placeholder=" Admin User Name " autofocus>
      </div>
      <div class="form-group">
        <label for="password" class="sr-only">Password</label>
        <input id="password" type="password" class="form-control" placeholder="password">
      </div>
      <button id="login-btn"class="btn btn-primary btn-block">Login In</button>
    </div>
  </div>
</body>
<script src="../JQuery_lib/jquery-3.3.1.js"></script>
<script src="../JQuery_lib/jQuery.md5.js"></script>

<script>
$("#login-btn").click(function () {
    $.get('/AdminLoginServlet',{'username':$('#username').val(),
        'password':$('#password').val()},function (xhr) {

        var str=xhr.split(':')
        if(str[0]=="error") {
            $(".alert-danger").css('display','block')
            $(".alert-danger strong").text(str[1])
        }else{
           location.href="/admin/index.jsp";
        }
    })
});
</script>
</html>
