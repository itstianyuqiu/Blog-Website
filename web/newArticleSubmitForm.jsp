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
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="TianCSS/newArticleSubmitForm.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <title>Add New Article</title>
</head>
<body>

<form action="/UpdateArticleDatabase" method="get">
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
                                    <br>
                                    <br>
                                    <h5>New Heading: </h5>
                                    <input id="add_article_title" type="text" name="new_article_heading">
                                    <br>
                                    <br>
                                    <h5>New Content: </h5>
                                    <textarea id="add_article_content" name="new_article_content" rows="10" cols="30"></textarea>
                                    <br>
                                    <br>
                                    <button type="submit" id="btn_add_article" name="updateArticle" value="Update">Submit</button>
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
