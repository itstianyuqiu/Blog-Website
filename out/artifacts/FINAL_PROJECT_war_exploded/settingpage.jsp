<!DOCTYPE html>
<html lang="en">
<head>
    <title>Personal page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <link rel="stylesheet" href="TianCSS/settingpage.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<%--<body onload="loadAllArticleWithComments()">--%>
<body class="is-preload">

<!-- Header -->
<header id="header">
    <div class="inner">
        <!--Avatar-->
        <a href="#" class="image avatar">
            <img id="image_avatar" src="${userPOJO.getAvatar()}" alt="loading..."/>
        </a>
        <!--Username & Description-->
        <span id="user_name">
                    <h1>
                        <strong>${userPOJO.getFirstName()} ${userPOJO.getLastName()}</strong>
                    </h1>
            </span>
        <p>${userPOJO.getDescription()}</p>

    </div>
</header>

<!--research-->


<div id="main">

    <section id="zero">
        <div id="zone_search_icon">
            <span id="zone_search">
                <input type="search" id="search_bar" placeholder=" Search..."/>
            </span>

            <span id="zone_icon">
                <a href="index.jsp">
                    <img id="icon_home" src="images/icon_logo.png">
                </a>
                <a href="homepage.jsp">
                    <img id="icon_setting" src="images/icon_home.png">
                </a>
                <a href="/UserLogOutServlet">
                    <img id="icon_logout" src="images/icon_logout.png">
                </a>
            </span>
        </div>
    </section>

    <section id="one">
        <form action="/UserUpdateAccountServlet" id="update" method="post">
            <h2>General Account Settings</h2>
            <br>
            <p class="sub_title">Username</p>
            <input type="text" name="username" id="setting_username" class="setting_text_field"
                   value="${userPOJO.getUsername()}"/>
            <br>
            <br>
            <p class="sub_title">Email address</p>
            <input type="text" name="emailaddress" id="setting_emailaddress" class="setting_text_field"
                   value="${userPOJO.getEmail()}"/>
            <br>
            <br>
            <p class="sub_title">Country</p>
            <input type="text" name="country" id="setting_country" class="setting_text_field"
                   value="${userPOJO.getCountry()}"/>
            <br>
            <br>
            <p class="sub_title">Describe yourself in one sentence</p>
            <input type="text" name="description" id="setting_description" class="setting_text_field"
                   value="${userPOJO.getDescription()}"/>
            <br>
            <br>
            <button type="submit" class="btn_savechange" name="savechange1" value="savechange1">Save change</button>
        </form>
    </section>

    <section id="two">
        <form action="/UserUpdateAccountServlet" method="post">
            <h2>Security</h2>
            <br>
            <!--Email address-->
            <!--<br>-->
            <!--<input type="text" id="security_emailaddress" class="setting_text_field_long"/>-->
            <!--<br>-->
            <!--<button type="button" id="btn_sendcode" value="sendcode"> Send verification code</button>-->
            <p class="sub_title">Security question</p>
            <select id="form_securityquestion" name="securityquestion">
                <option value="-">select a question</option>
                <option value="1">What is your favourite movie?</option>
                <option value="2">Where are you born?</option>
                <option value="3">What is your first pet's name?</option>
            </select>
            <br>
            <br>
            <p class="sub_title">Answer</p>
            <input type="text" id="security_questionanswer" class="setting_text_field"/>
            <br>
            <br>
            <p class="sub_title">New password</p>
            <input type="text" name="newpwd" id="security_password" class="setting_text_field"/>
            <br>
            <br>
            <p class="sub_title">Confirm password</p>
            <input type="text" name="confirmpwd" id="security_conpassword" class="setting_text_field"/>
            <br>
            <br>
            <button type="submit" class="btn_savechange" name="savechange2" value="savechange2">Save change</button>
            <br>
            <br>
        </form>
    </section>

    <section id="three">
        <h2>Delete Account</h2>
        <br>
        <button type="button" id="delete_user_account_button" onclick="showDeleteUserAccountForm()">Delete Account</button>
        <div id="delete_user_account" style="display: none">
        <form action="/UserDeleteAccountServlet" method="post">
            <p>Deleting an account will delete all your information. Do you want to continue?</p>
            <br>
            <button type="submit" id="btn_delete" value="delete">Yes, delete my account</button>
        </form>
            <button id="delete_cancel_account" onclick="cancelDeleteUserAccountForm()">Cancel</button>
        </div>
    </section>


</div>


<!-- change avatar -->

<div id="change_avatar">
    <!-- avatar content -->
    <div class="avatar_update_content">
        <div class="avatar_update_header">
            <span class="close">&times;</span>
        </div>
        <div class="avatar_update_body">
            <%--<a href="/UserUpdateAccountServlet"><img src="images/icon_home.png" name="images/icon_home.png"></a>--%>
            <%--<a href="/UserUpdateAccountServlet"><img src="images/icon_login.png" name="images/icon_login.png"></a>--%>
            <%--<a href="/UserUpdateAccountServlet"><img src="images/icon_logo.png" name="images/icon_logo.png"></a>--%>
            <%--<a href="/UserUpdateAccountServlet"><img src="images/icon_setting.jpg" name="images/icon_setting.jpg"></a>--%>
        </div>
        <div class="avatar_update_footer">
            <form id="avatar" action="/UserUpdateAccountServlet" method="post" enctype="multipart/form-data">
                <input type="file" accept="image/*" name="avatar">
                <button type="submit" name="submit_btn">Submit</button>
                <%--<button type="submit" name="cancel_btn">Cancel</button>--%>
            </form>
        </div>
    </div>
</div>


</body>
<script>
    $("#image_avatar").click(function () {
        $("#change_avatar").show(100);
    });
    $(".close").click(function () {
        $("#change_avatar").hide(100);
    });
</script>
</html>