<%--
  Created by IntelliJ IDEA.
  User: Yang
  Date: 2018/10/17
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add &laquo; User &laquo; Admin</title>
</head>
<link rel="stylesheet" href="../vendors/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../vendors/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="../adminCSS/admin.css">
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <form action="/AdminUserServlet" method="post">
                <h2>add new user</h2>
                <input type="hidden" name="adminuser" value="adduser" disabled>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input id="username" class="form-control" name="username" type="text" placeholder="Username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input id="password" class="form-control" name="password" type="password"
                           placeholder="Password">
                </div>
                <div class="form-group">
                    <label for="nickname">Name</label>
                    <input id="nickname" class="form-control" name="userrealname" type="text" placeholder="Name">
                </div>
                <div class="form-group">
                    <label for="gender">Gender</label>
                    <input id="gender" class="form-control" name="gender" type="text" placeholder="Gender">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" class="form-control" name="email" type="email" placeholder="Email">
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <area id="description" class="form-control" name="description" type="text"
                          placeholder="Description">
                </div>
                <div class="form-group">
                    <label for="country">Country</label>
                    <input id="country" class="form-control" name="country" type="text" placeholder="Country">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary" type="submit">ADD</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="../JQuery_lib/jquery-3.3.1.js"></script>
<script src="../vendors/bootstrap/js/bootstrap.js"></script>

</body>
</html>
