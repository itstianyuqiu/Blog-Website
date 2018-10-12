<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Log in</title>
    <link rel="stylesheet" href="TianCSS/index.css">
    <script src="myJS.js"></script>
</head>
<body>

<form action="/UserLoginServlet" method="post">
    <div id="login_frame">
        <p id="image_logo"><img src="images/icon_logo.png" width="100px"></p>

        <input placeholder="  Username " type="text" name="username" id="username" class="login_text_field"/>
        <br>
        <br>
        <input placeholder="  Password " type="password" name="password" id="password" class="login_text_field"/>
        <br>
        <br>
        <div id="login_control">
            <button type="submit" id="btn_login" name="login" value="login" >Log in</button>
            <a id="forget_pwd" href="index_forget_pwd.jsp">Forgotten Pasword？</a>
        </div>
    </div>
</form>
</div>


</body>
</html>