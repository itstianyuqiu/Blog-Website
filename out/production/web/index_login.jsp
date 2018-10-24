<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Log in</title>
    <link rel="stylesheet" href="TianCSS/index.css">
    <script src="http://www.google.com/recaptcha/api.js" async defer></script>
    <script SRC="JQuery_lib/jquery-3.3.1.js"></script>
    <script SRC="JQuery_lib/jQuery.md5.js"></script>
    <script src="myJS.js"></script>
    <style>
        .g-recaptcha{
            padding: 15px 46px 0;
        }
        .errorMsg{
            width: 60px;
            height: 35px;
            color: red;
        }

    </style>
</head>
<body>

<div id="login_frame">
    <div class="errorMsg">
        <p></p>
    </div>
    <p id="image_logo"><img src="images/icon_logo.png" width="113px"></p>

    <input placeholder="  Username " type="text" name="username" id="username" class="login_text_field"/>
    <br>
    <br>
    <input placeholder="  Password " type="password" name="password" id="password" class="login_text_field"/>
    <br>
    <br>
    <div id="login_control">
        <button type="button" id="btn_login" name="login" value="login">Log in</button>
        <a id="forget_pwd" href="index_forget_pwd.jsp">Forgotten Pasword&quest;</a>
    </div>
    <div class="g-recaptcha" data-sitekey="6Lfkp3UUAAAAAF26TrKkeofLcFidZExKMthqYE_s" ></div>
</div>
</body>


<script>
    $('#btn_login').click(function () {
        var $grecaptcha=grecaptcha.getResponse()

        if($grecaptcha!=null){$.post('/UserLoginServlet', {
            'grecaptcha':$grecaptcha,
            'username': $("#username").val(),
            'password': $.md5($('#password').val())
        }, function (xhr) {
            var xhr= xhr.split(':')
            if(xhr[0]=='error'){
                $('.errorMsg p').text(xhr[1])
            } else {
                location.href="/homepage.jsp"
            }
        });}else {
            alert("You didn't click grecaptcha ")
        }
    });

</script>

</html>
