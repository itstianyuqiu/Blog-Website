<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset password</title>
    <link rel="stylesheet" href="TianCSS/index.css">
    <script src="myJS.js"></script>

</head>
<body>

<form action="/UserForgetPasswordServlet" method="post">
    <div id="login_frame_resetpassword">
        <p id="image_logo"><img src="images/icon_logo.png" width="100px"></p>
        <input placeholder="  Username " type="text" name="username" class="signup_text_field_usernameemailpassword"/>
        <br>
        <br>
        <input placeholder="  Email address " type="text" name="emailaddress" id="emailaddress" class="signup_text_field_usernameemailpassword"/>
        <br>
        <br>

        <%--Security question:--%>
        <%--<select id="form_securityquestion" name="securityquestion">--%>
            <%--<option value="-">Question</option>--%>
            <%--<option value="1">What is your favourite movie?</option>--%>
            <%--<option value="2">Where are you born?</option>--%>
            <%--<option value="3">What is your first pet's name?</option>--%>
        <%--</select>--%>
        <%--<br>--%>
        <%--<br>--%>
        <%--<input placeholder="  My answer " type="text" id="security_answer" class="signup_text_field_usernameemailpassword"/>--%>
        <%--<br>--%>
        <%--<br>--%>
        <%--<input placeholder="  New password " type="text" id="newpassword" class="signup_text_field_usernameemailpassword"/>--%>
        <%--<br>--%>
        <%--<br>--%>
        <%--<input placeholder="  Confirm password " type="text" id="confirmpassword" class="signup_text_field_usernameemailpassword"/>--%>
        <%--<br>--%>
        <%--<br>--%>
        <button type="submit" id="btn_confirm" value="confirm" >Confirm</button>
    </div>
</form>
</div>
</body>
</html>