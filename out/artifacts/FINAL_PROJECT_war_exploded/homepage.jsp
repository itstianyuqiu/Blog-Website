<!DOCTYPE html>
<html lang="en">
<head>
    <title>Personal page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <link rel="stylesheet" href="TianCSS/homepage.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<%--<body onload="loadAllArticleWithComments()">--%>
<body class="is-preload" onload="load_article()">

<!-- Header -->
<header id="header">
    <div class="inner">
        <!--Avatar-->
        <img id="image_avatar" src="${userPOJO.getAvatar()}" alt="loading..."/>
        <!--Username & Description-->
        <span id="user_name">
                    <h1>
                        <strong>
                            ${userPOJO.getFirstName()} ${userPOJO.getLastName()}
                        </strong>
                    </h1>
            </span>
        <p>${userPOJO.getDescription()}</p>

    </div>
</header>


<!--research-->


<div id="main">
    <section id="one">
        <div id="zone_search_icon">

            <span id="zone_search">
                <input type="search" id="search_bar" placeholder=" Search..."/>
            </span>

            <span id="zone_icon">
                <a href="index.jsp">
                    <img id="icon_home" src="images/icon_home.png">
                </a>
                <a href="settingpage.jsp">
                    <img id="icon_setting" src="images/icon_setting.jpg">
                </a>
                <a href="/UserLogOutServlet">
                    <img id="icon_logout" src="images/icon_logout.png">
                </a>
            </span>
        </div>
    </section>

    <!--Add_new_article-->
    <section id="two">
        <h2>Write a New Article</h2>
        <br>
        <div id="add_new_articles"></div>
        <a href="newArticleSubmitForm.jsp">
            <button id="btn_add_new_article">Add a new article</button>
        </a>
    </section>

    <section id="three">
        <h2>Manage My Articles</h2>
        <br>
        <div id="my_articles"></div>
    </section>

    <section id="four">
        <h2>Read Everyone's Articles</h2>
        <button id="btn_all_articles" onclick="loadAllArticleWithComments()">Read everyone's article</button>
        <br>
        <br>
        <div id="all_articles"></div>
    </section>


</div>
</body>

</html>