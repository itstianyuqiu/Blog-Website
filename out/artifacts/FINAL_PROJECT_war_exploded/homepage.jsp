<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Personal page</title>
    <link rel="stylesheet" href="TianCSS/homepage.css">
    <link rel="stylesheet" href="homepageCSS/rowPart.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">

    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
</head>
<%--<body onload="loadAllArticleWithComments()">--%>
<body>
<div id="side_both" class="container " align="center">
    <!--research-->
    <div id="zone_search_icon">
        <span id="zone_search">
        <input type="search" id="search_bar" placeholder=" Search..."/>
        </span>
        <!--icon_setting_logout-->
        <span id="icon_logout&setting">
            <a href="settingpage.jsp">
                <img id="icon_setting" src="images/icon_setting.jpg">
            </a>
            <a href="/UserLogOutServlet">
                <img id="icon_logout" src="images/icon_logout.png" width="40px">
            </a>
        </span>
    </div>

    <div id="zone_avatar_main" class="row">
        <div id="zone_left" class="col-lg-4" align="center">

            <!--Avatar-->
            <a href="#">
                <img id="image_avatar" src="images/image_default_avatar.png" alt=""/>
            </a>
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

        <div class="col-lg-8" align="left">
            <div id="zone_right">
                <section id="article_top">
                    <%--<h2>Welcome !</h2>--%>
                    <img id="icon_welcome"
                         src="http://www.runnymedecollegiate.com/wp-content/uploads/2018/01/welcome.jpg">
                    <br>
                    <p>If we don't offer ourselves to the unknown, our world becomes small and we lose our sense of
                        wonder.
                        our experience is restricted as we pass our days in a routine that is both comforting and
                        limiting.
                    </p>
                </section>

                <!--article_my article_all articile-->
                <br>
                <div class="row">
                    <section id="article_my_articles">
                        <h2>Blog List</h2>
                        <hr>
                        <%--<div id="my_articles"></div>--%>
                        <div id="justForButtom">
                            <button id="btn_my_articles" onclick="loadUserArticle()">Manage my articles</button>
                            <button id="btn_all_articles" onclick="loadAllArticleWithComments()">View other people's
                                articles
                            </button>
                        </div>


                    </section>
                </div>
                <br>
                <hr>
                <%--show all articles--%>
                <div class="row">
                    <section id="article_all_articles">
                        <h2>Recent Blog</h2>


                        <div id="articles">
                            <%
                                String fromPage = request.getSession().getAttribute("page").toString();
                                if (fromPage.equals("myArticles")){
                            %>
                                <script>
                                    loadUserArticle();
                                </script>
                            <%
                                }
                                else if (fromPage.equals("allArticles")) {
                            %>
                                <script>
                                    loadAllArticleWithComments();
                                </script>
                            <%
                                }

                            %>
                        </div>

                        <br>
                    </section>
                </div>
                <!--Add_new_article-->
                <section id="article_new_article">

                    <br>
                    <button id="btn_add_new_article" onclick="addNewArticle()">Add a new article</button>
                    <br>

                        <%--<article id="article_recent_one">--%>
                        <%--<a href="article.jsp">--%>
                        <%--<h3>Demo Article I</h3>--%>
                        <%--</a>--%>
                        <%--<p>Preview of the article...</p>--%>
                        <%--</article>--%>

                        <%--<article id="article_recent_two">--%>
                        <%--<a href="article.jsp">--%>
                        <%--<h3>Demo Article II</h3>--%>
                        <%--</a>--%>
                        <%--<p>Preview of the article...</p>--%>
                        <%--</article>--%>
                </section>


        </div>
        </div>
    </div>
</div>
</body>
</html>