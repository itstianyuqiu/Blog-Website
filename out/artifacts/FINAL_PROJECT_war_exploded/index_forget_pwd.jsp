<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset password</title>
    <link rel="stylesheet" href="TianCSS/index.css">
    <script src="myJS.js"></script>

</head>
<body>

<form action="/UserForgotPasswordServlet" method="post">
    <div id="login_frame_resetpassword">
        <p id="image_logo"><img src="images/icon_logo.png" width="100px"></p>
        <input placeholder="  Username " type="text" name="username" class="signup_text_field_usernameemailpassword"/>
        <br>
        <br>
        <input placeholder="  Email address " type="text" name="emailaddress" id="emailaddress"
               class="signup_text_field_usernameemailpassword"/>
        <br>
        <br>
        <div class="site">
            <div class="errMsg" style="display: none">
            </div>
        </div>
        <button type="submit" id="btn_confirm" value="confirm">SEND</button>
        <button type="button" id="return" value="return">HomePage</button>
    </div>
</form>
</div>
</body>
</html>