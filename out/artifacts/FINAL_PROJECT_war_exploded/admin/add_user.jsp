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
                <input type="hidden" name="adminuser" value="adduser">
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
                    <label for="firstname">First Name</label>
                    <input id="firstname" class="form-control" name="firstname" type="text" placeholder="First Name">
                </div>
                <div class="form-group">
                    <label for="lastname">Last Name</label>
                    <input id="lastname" class="form-control" name="lastname" type="text" placeholder="Last Name">
                </div>
                <div class="form-group">
                    <label for="dob">Birth</label>
                    <input id="dob" class="form-control" name="dob" type="date" placeholder="Date of Birth">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" class="form-control" name="email" type="email" placeholder="Email">
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <input id="description" class="form-control" name="description" type="text"
                           placeholder="Description">
                </div>
                <div class="form-group" id="countries">
                    <label for="countrySelect">Country (two letters)</label>
                    <input type="text" id="countrySelect" name="country"  class="form-control">
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
