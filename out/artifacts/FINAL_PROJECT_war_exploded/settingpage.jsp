<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Personal page</title>
    <link rel="stylesheet" href="TianCSS/settingpage.css">
    <script src="myJS.js"></script>
</head>
<body>
<div class="box">
    <div class="container-2">
        <img id="image_home" src="images/1.png" width="40px">
        <!--<img id="image_setting" src="data:image/jpeg;base64,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" width="40px">-->
        <img id="image_logout" src="images/logout_user_login_account-512.png" width="40px">
        <span class="icon">
            <i class="fa fa-search"></i>
        </span>
        <input type="search" id="search" placeholder="Search..." />
    </div>
</div>

<div id="main">

    <section id="one">
        <form action="/UserUpdateAccountServlet" method="post">
        <h2>General Account Settings</h2>
        Change avatar
        <br>
        <img id="setting_avatar" src="images/no-photo.jpg" alt="" width="130px">
        <img id="setting_uploadicon" src="images/upload_avatar_182104.png" alt="" width="49px">
        <!--<button type="button" id="btn_uploadavatar" value="upload" >Upload</button>-->
        <br>
        <br>
        Username
        <br>
        <input type="text" name="username" id="setting_username" class="setting_text_field_long" value="${userPOJO.getUsername()}"/>
        <br>
        <br>
        Email address
        <br>
        <input type="text" name="emailaddress" id="setting_emailaddress" class="setting_text_field_long" />
        <br>
        <br>
        Country
        <br>
        <input type="text" name="country" id="setting_country" class="setting_text_field_long"/>
        <br>
        <br>
        Describe yourself in one sentence
        <br>
        <input type="text" name="description" id="setting_description" class="setting_text_field_long"/>
        <br>
        <br>
        <button type="submit" id="btn_savechange" value="savechange1" >Save change</button>
        <br>
        </form>
    </section>

    <section id="two">
        <h2>Security</h2>
        Email address
        <br>
        <input type="text" id="security_emailaddress" class="setting_text_field_long"/>
        <br>
        <button type="button" id="btn_sendcode" value="sendcode"> Send verification code</button>
        <br>
        <br>
        New password
        <br>
        <input type="text" id="security_password" class="setting_text_field_long"/>
        <br>
        <br>
        Confirm password
        <br>
        <input type="text" id="security_conpassword" class="setting_text_field_long"/>
        <br>
        <br>
        Verification code
        <br>
        <input type="text" id="security_vcode" class="setting_text_field_long"/>
        <br>
        <br>
        <button type="submit" id="btn_savechange_security" value="savechange2" >Save change</button>
        <br>
    </section>

    <section id="three">
        <h2>Delete Account</h2>
        <p>Deleting an account will delete all your information. Do you want to continue?</p>
        <button type="submit" id="btn_delet" value="delete" >Yes, delete my account</button>
    </section>
</div>
</body>
</html>