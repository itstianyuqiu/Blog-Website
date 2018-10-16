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
            <img id="image_avatar" src="images/image_default_avatar.png" alt=""/>
        </a>
        <!--Username & Description-->
        <span id="user_name">
                    <h1>
                        <strong>
                            ${UserPOJO.getFirstName()} ${userPOJO.getLastName()}
                        </strong>
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
                    <img id="icon_setting" src="images/icon_home.png" width="40px">
                </a>
                <a href="/UserLogOutServlet">
                    <img id="icon_logout" src="images/icon_logout.png">
                </a>
            </span>
        </div>
    </section>

    <section id="one">
    <h2>General Account Settings</h2>
    <br>
    <p class="sub_title">Username</p>
    <input type="text" name="username" id="setting_username" class="setting_text_field" value="${userPOJO.getUsername()}"/>
    <br>
    <br>
    <p class="sub_title">Email address</p>
    <input type="text" name="emailaddress" id="setting_emailaddress" class="setting_text_field" value="${userPOJO.getEmail()}"/>
    <br>
    <br>
    <p class="sub_title">Country</p>
    <input type="text" name="country" id="setting_country" class="setting_text_field" value="${userPOJO.getCountry()}"/>
    <br>
    <br>
    <p class="sub_title">Describe yourself in one sentence</p>
    <input type="text" name="description" id="setting_description" class="setting_text_field" value="${userPOJO.getDescription()}"/>
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
            <input type="text"  id="security_questionanswer" class="setting_text_field"/>
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
        <form action="/UserDeleteAccountServlet" method="post">
            <h2>Delete Account</h2>
            <br>
            <p>Deleting an account will delete all your information. Do you want to continue?</p>
            <br>
            <button type="submit" id="btn_delete" value="delete">Yes, delete my account</button>
        </form>
    </section>


</div>
</body>
</html>