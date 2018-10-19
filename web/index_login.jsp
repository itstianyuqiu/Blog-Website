<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Log in</title>
    <link rel="stylesheet" href="TianCSS/index.css">
    <script src=“https://www.recaptcha.net/recaptcha/api.js” async defer></script>
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
            <div id='recaptcha' class="g-recaptcha"
                 data-sitekey="6Lfkp3UUAAAAAF26TrKkeofLcFidZExKMthqYE_s"
                 data-callback="onSubmit"
                 data-size="invisible">

            </div>
            <button type="submit" id="btn_login" name="login" value="login">Log in</button>
            <a id="forget_pwd" href="index_forget_pwd.jsp">Forgotten Pasword&quest;</a>
        </div>

    </div>
</form>

<%--<script>--%>
    <%--function onSubmit(token) {--%>
        <%--alert('thanks ' + document.getElementById('field').value);--%>
    <%--}--%>

    <%--function validate(event) {--%>
        <%--event.preventDefault();--%>
        <%--if (!document.getElementById('field').value) {--%>
            <%--alert("You must add text to the required field");--%>
        <%--} else {--%>
            <%--grecaptcha.execute();--%>
        <%--}--%>
    <%--}--%>

    <%--function onload() {--%>
        <%--var element = document.getElementById('btn_login');--%>
        <%--element.onclick = validate;--%>
    <%--}--%>
    <%--onload();--%>
<%--</script>--%>


<%--<script>--%>
<%--function onSubmit(token) {--%>
<%--document.getElementById("user_login").submit();--%>
<%--}--%>
<%--</script>--%>
</body>
</html>
