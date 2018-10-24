<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>Password reset &laquo; User</title>
    <link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="../adminCSS/admin.css">

</head>
<body>

<div class="main">
    <%
        if (request.getParameter("security-Key") == null || request.getParameter("security-Key").equals("")) {
            response.sendRedirect("../index.jsp");
        }
        ;
    %>
    <div class="container-fluid">
        <div class="page-title">
            <h1>Change Password</h1>
        </div>
        <!-- when have incorrect message -->
        <div class="alert alert-danger">
            <strong>error！</strong>
        </div>
        <div class="form-group">
            <label for="password" class="col-sm-3 control-label">New password</label>
            <div class="col-sm-7">
                <input id="password" class="form-control" id="password" type="password" placeholder="New password">
            </div>
        </div>
        <div class="form-group">
            <label for="confirm" class="col-sm-3 control-label">Confirm password</label>
            <div class="col-sm-7">
                <input id="confirm" class="form-control" id="confirm" type="password" placeholder="Confirm password">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-7">
                <button type="button" id="change-password" class="btn btn-primary">Change Password</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title alert" id="myModalLabel"></h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary cancel" data-dismiss="modal" aria-hidden="true">cancel
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
<script src="../JQuery_lib/jquery-3.3.1.js"></script>
<script src="../JQuery_lib/jQuery.md5.js"></script>
<script src="../vendors/bootstrap/js/bootstrap.js"></script>

<script>
    $("#change-password").click(function () {
        console.log(11111111);
        $.post("/UserResetPasswordServlet", {
                'securityKey': '<%out.print(request.getParameter("security-Key"));%>',
                'password': $.md5($('#password').val()),
                'confirm': $.md5($('#password').val())

            },
            function (xhr) {
                if (xhr == '0') {
                    $('#myModalLabel').text("Success");
                    $('.modal-body').text('your password is changed!')
                    $('#myModal').modal()
                    $(".cancel").on('click',function () {
                        location.href='../index.jsp'
                    })
                    // location.href = "../index.jsp"
                } else {
                    $('#myModalLabel').text('Error')
                    $('.modal-body').text(xhr);
                    $('#myModal').modal()
                }
            });
    })


</script>
</html>
