<%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 5/10/2018
  Time: 1:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New Article</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="TianCSS/article_add.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
</head>
<body>

<form action="/ArticleUpload" method="post" enctype="multipart/form-data">
    <div id="container">
        <div id="nav">
            <img id="index_logo" src="images/icon_logo.png">
            <input type="search" id="search_bar" placeholder=" Search..."/>
        </div>
        <div id="container2">
            <div id="main">
                <div class="wrapper">
                    <div class="one">
                        <div class="card">
                            <div class="container">
                                <br>
                                <section>
                                    <h5>Headings:</h5>
                                    <input type="text" id="newarticile_title" name="article_heading">
                                    <br>
                                    <br>
                                    <h5>Content:</h5>
                                    <form method="post">
                                        <textarea id="summernote" name="article_content"></textarea>
                                    </form>

                                    <script>
                                        $(document).ready(function () {
                                            $('#summernote').summernote();
                                        });
                                    </script>

                                    <br>
                                    <br>
                                    <b> Upload Image: </b>
                                    <input type="file" id="picture" name="picture" accept="image/png, image/jpeg" multiple>
                                    <br>
                                    <br>
                                    <b> Upload Audio: </b>
                                    <input type="file" id="audioUpload" name="audioUpload" accept="audio/*">
                                    <br>
                                    <br>
                                    <b> Upload Video: </b>
                                    <input type="file" id="videoUpload" name="videoUpload" accept="video/*">
                                    <br>
                                    <br>
                                    <b> Youtube Link: </b>
                                    <input type="text" id="youtubeLink" name="youtubeLink">
                                    <br>
                                    <br>
                                    <h5>Publishing Date:</h5>
                                    <input id="theDate" type="date" name="article_date">
                                    <script>
                                        loadCurrentDate();
                                    </script>
                                    <br>
                                    <br>
                                    <button type="submit" id="btn_newarticle" name="addArticle" value="Add Now">Submit
                                    </button>
                                    <a href="../homepage.jsp"><button id="add_new_cancel">Cancel</button></a>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>


</body>
</html>
