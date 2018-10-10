<%@ page import="POJO.UserPOJO" %>
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
        <a href="homepage.jsp"><img id="image_home" src="images/1.png" width="40px"></a>
        <a href="/UserLogOutServlet"><img id="image_logout" src="images/logout_user_login_account-512.png" width="40px"></a>
        <span class="icon">
            <i class="fa fa-search"></i>
        </span>
        <input type="search" id="search" placeholder="Search..."/>
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
            <input type="text" name="username" id="setting_username" class="setting_text_field_long"
                   value="${userPOJO.getUsername()}"/>
            <br>
            <br>
            Email address
            <br>
            <input type="text" name="emailaddress" id="setting_emailaddress" class="setting_text_field_long"
                   value="${userPOJO.getEmail()}"/>
            <br>
            <br>
            Country
            <br>
            <input type="text" name="country" id="setting_country" class="setting_text_field_long"
                   value="${userPOJO.getCountry()}"/>
            <br>
            <br>
            Describe yourself in one sentence
            <br>
            <input type="text" name="description" id="setting_description" class="setting_text_field_long"
                   value="${userPOJO.getDescription()}"/>
            <br>
            <br>
            <button type="submit" id="btn_savechange" name="savechange1" value="savechange1">
                Save change
            </button>
            <br>
        </form>
    </section>

    <section id="two">
        <form action="/UserUpdateAccountServlet" method="post">
            <h2>Security</h2>
            Email address
            <br>
            <input type="text" name="emailaddress" id="security_emailaddress" class="setting_text_field_long"/>
            <br>
            <button type="submit" id="btn_sendcode" value="sendcode"> Send verification code</button>
            <br>
            <br>
            New password
            <br>
            <input type="text" name="newpwd" id="security_password" class="setting_text_field_long"/>
            <br>
            <br>
            Confirm password
            <br>
            <input type="text" name="confirmpwd" id="security_conpassword" class="setting_text_field_long"/>
            <br>
            <br>
            Verification code
            <br>
            <input type="text" id="security_vcode" class="setting_text_field_long"/>
            <br>
            <br>
            <button type="submit" id="btn_savechange_security" name="savechange2" value="savechange2">Save change
            </button>
            <br>
        </form>
    </section>

    <section id="three">
        <form action="/UserDeleteAccountServlet" method="post">
            <h2>Delete Account</h2>
            <p>Deleting an account will delete all your information. Do you want to continue?</p>
            <button type="submit" id="btn_delet" name="delete" value="${userPOJO.getUser_id()}">Yes, delete my account</button>
        </form>
    </section>
</div>
</body>
</html>