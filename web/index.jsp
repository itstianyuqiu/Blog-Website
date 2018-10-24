<%@ page import="POJO.UserPOJO" %><%--
  Created by IntelliJ IDEA.
  User: Crystal
  Date: 2018/10/16
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>mainPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="mainPageCSS/new_index.css">
    <link rel="stylesheet" href="vendors/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
    <% UserPOJO userPOJO=(UserPOJO)request.getSession().getAttribute("userPOJO");%>
    <style>


        .search-bar {
            float: left;
            margin-top: 30px;
            margin-left: 50px;
        }

        .btns {
            margin-top: 15px;
            margin-right: 30px;
            float: right;
        }

        .article {
            width: 400px;
            height: 600px;
            margin-top: 30px;
            margin-left: 10px;
            background-color: snow;
            /*position: absolute;*/
            border-radius: 20px;
            float: left;
        }

        .article .image {
            width: 398px;
            height: 350px;

        }

        .article .content {
            width: 398px;

        }

        .article .footer {
            width: 398px;
            height: 40px;
        }

        .image img {
            width: 398px;
            height: 350px;
        }

        #all_articles > div {
            display: inline-block;
        }
    </style>
    <script>
        function getdate() {
            var mydate = new Date();
            return mydate.getFullYear() + '-' + (mydate.getMonth() + 1) + '-' + mydate.getDate()
        }

        function randomImgNo() {
            return Math.ceil(Math.random() * 8)
        }

        (function () {
            var $datebegin = $(".datebegin").val() || '1970-01-01';
            var $dateend = $(".dateend").val() || getdate();
            console.log("$datebegin========" + $datebegin + "$dateend====" + $dateend)
            $.getJSON("/QuaryUserArtServlet", {
                'text': '$_init_load',
                'datebegin': $datebegin,
                'dateend': $dateend
            }, function (xhr) {
                var len = xhr.length <= 20 ? xhr.length : 20
                for (var i = 0; i < len; i++) {

                    $li = $("<li></li>")
                    $a = $('<a href="" class="articlecontent">')
                    $artDv = $(' <div class="article">')
                    $imgDv = $(' <div class="image"></div>')
                    $contentDv = $(' <div class="content"></div>')
                    $footerDv = $(' <div class="footer"></div>')
                    $title = $(' <h3 class="title"></h3>')
                    $auth = $(' <h4 class="author"></h4>')
                    $artContent = $(' <p class="artContent"></p>')
                    $.each(xhr[i], function (j) {

                        if (xhr[i][j] != null) {
                            console.log(xhr[i][j])
                            $.each(xhr[i][j], function (k) {
                                if (k == 'imagePOJOS') {
                                    if (xhr[i][j][k] != null && xhr[i][j][k] != '') {
                                        $img = $('<img></img>').attr('src', 'Uploaded_Images/'+xhr[i][j][k][0]['source'])
                                        $imgDv.append($img)
                                    } else {
                                        $img = $('<img></img>').attr('src', 'images/pic0' + randomImgNo() + '.jpg')
                                        $imgDv.append($img)
                                    }
                                }
                                if (k == 'title') $title.text(xhr[i][j][k].length <= 16 ? xhr[i][j][k] : xhr[i][j][k].substring(0, 15) + '...');
                                if (k == 'username') $auth.text(xhr[i][j][k])
                                if (k == 'content') $artContent.html(xhr[i][j][k].length <= 200 ? xhr[i][j][k] : xhr[i][j][k].substring(0, 15) + '...')
                            })
                        }
                        if (j == 'ap') {
                            $.each(xhr[i][j], function (k) {
                                if (k == 'article_id') $li.attr("id", xhr[i][j][k])
                            })
                        }
                    });

                    $imgDv.append($img)
                    $contentDv.append($title).append($auth).append($artContent)
                    $footerDv.append("<button class=\"btn btn-info show-art-del\">Show The whole Article</button>")
                    $artDv.append($imgDv).append($contentDv).append($footerDv).appendTo($li)
                    // $a.append($artDv).appendTo($li)
                    $li.appendTo("#all_articles")


                }

                $(".show-art-del").click(function () {
                    showdetail($(this).parent().parent().parent().attr("id"))
                })

            })
        }());


        function showdetail($id) {
            location.href="/ShowArtDetileServlet?articleid="+$id;
        }

    </script>
</head>
<body>
<div id="container">
    <div id="nav">
        <div class="logo">
            <img id="index_logo" src="images/icon_logo.png">
        </div>


        <%--login btn--%>
        <div class="btns">
        <% if (userPOJO == null) {%>

            <a href="/JSP_Pages/mediaGalleryAll.jsp">
                <img style="width: 50px" id="icon_gallery" src="images/icon_gallery.png">
            </a>

            <a href="index_login.jsp">
                <button class="btn btn-primary ">Login</button>
            </a>
            <a href="index_signup.jsp">
                <button class="btn btn-info ">Register</button>
            </a>

        <% } else { %>

        <h3 class="user-login_name"> welcome <% out.print(userPOJO.getUsername());%></h3>
            <a href="/homepage.jsp">
                <button class="btn btn-info ">MyPage</button>
            </a>
        <%}%></div>

        <%--search_bar--%>

        <div class="col-md-6 search-bar">
            <div class="input-group">
                <input type="text" class="form-control col-md-6 bar1Typein" placeholder="Search here">
                <span class="input-group-btn">
                <input type="date" class="form-control col-md-3 datebegin" placeholder="begin">
                    </span>
                <span class="input-group-btn">
                <input type="date" class="form-control col-md-3 dateend" placeholder="end">
                        </span>
                <span class="input-group-btn">
                    <button class="btn btn-default search-btn" type="button">Go</button>
                </span>
            </div><!-- /input-group -->
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Quary Results</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped searchTable" id="searchTable">
                        <thead>
                        <tr>
                            <td class="CreatedDate">Created Date</td>
                            <td>Title</td>
                            <td>Author</td>
                        </tr>
                        </thead>
                        <tbody class="searchbody">

                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <div class="modal fade" id="article-detail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h2 class="article-title"></h2>
                    <h3 class="article-auth"></h3>
                    <h4 class="article-date"></h4>
                </div>
                <div class="modal-body">
                    <div class="article-img"></div>
                    <div class="article-content"></div>
                    <div class="article-comments">
                        <div></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div id="container2">
        <div id="main">
            <div class="wrapper">
                <ul id="all_articles">
                </ul>
            </div>
        </div>
    </div>
</div>
<script src="vendors/bootstrap/js/bootstrap.js"></script>
<script>


    $(".search-btn").click(function () {
        $seachbody = $(".searchbody")
        $seachbody.html("")
        var $datebegin = $(".datebegin").val() || '1970-01-01'
        var $dateend = $(".dateend").val() || getdate()
        var $seachtext = $(".bar1Typein").val() || '$_all'
        $seachtext = $seachtext.trim().replace(/\s+/g, "/+")
        $.getJSON("/QuaryUserArtServlet", {
            'text': $seachtext,
            'datebegin': $datebegin,
            'dateend': $dateend
        }, function (xhr) {
            if (xhr.length == 0) {
                $seachbody.html("<h2>Sorry! No data was found under this search condition!</h2>")
                $('#myModal').modal()
            }
            else {
                for (var i = 0; i < xhr.length; i++) {
                    $tr = $("<tr></tr>")
                    $.each(xhr[i], function (j) {
                        if (xhr[i][j] != null) {
                            $.each(xhr[i][j], function (k) {
                                k == 'article_date' ? $("<td></td>").html(xhr[i][j][k]).appendTo($tr) : ""
                                k == 'title' ? $("<td></td>").html(xhr[i][j][k]).appendTo($tr) : ""
                                k == 'username' ? $("<td></td>").html(xhr[i][j][k]).appendTo($tr) : ""
                            })
                        }
                    });
                    $tr.attr('id', xhr[i]['ap']['article_id'])

                    $seachbody.append($tr)
                    $('#myModal').modal()
                    $tr.click(function () {
                        showdetail($tr.attr('id'));
                    })
                }
            }


        })
    })
</script>
</body>
</html>
