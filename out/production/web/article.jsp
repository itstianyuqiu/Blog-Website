<%@ page import="POJO.UserPOJO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="POJO.JoinQueryDataModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Crystal
  Date: 2018/10/9
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>article</title>
    <link rel="stylesheet" href="homepageCSS/cssStyle.css">
    <link rel="stylesheet" href="homepageCSS/rowPart.css">
    <link rel="stylesheet" href="homepageCSS/otherCss.css">
    <link rel="stylesheet" href="homepageCSS/containerCSS.css">
    <link rel="stylesheet" href="homepageCSS/imageCSS.css">
    <link rel="stylesheet" href="homepageCSS/articleCSS.css">
    <script type="text/javascript" src="JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>

    <% UserPOJO userPOJO=(UserPOJO)request.getSession().getAttribute("userPOJO");%>


</head>
<body >



<!-- Header Wrapper -->
<div id="header-wrapper">
    <div class="container">
        <div class="row">
            <div class="12u">

                <!-- Header -->
                <section id="header">

                    <!-- Logo -->
                    <h1><a href="#">Dopetrope</a></h1>

                    <!-- Nav -->
                    <nav id="nav">
                        <ul>
                                <%if (userPOJO!=null&&userPOJO.getUsername()!=null&&!userPOJO.getUsername().equals("")){%>
                                    <li><a href="homepage.jsp">Home Page</a></li>

                                <% } %>


                            <li><a href="index.jsp">Other Articles</a></li>

                            <li class=/ShowArtDetileServlet?articleid=+${article.ap.article_id}"><a href="article.jsp">Current Article</a></li>

                        </ul>
                    </nav>



                </section>

            </div>
        </div>
    </div>
</div>



<div id="main-wrapper">
    <div class="container">
        <div class="row">
            <div class="12u">

                <!-- Article -->
                <section>
                    <div>
                        <div class="row">
                            <div class="12u skel-cell-mainContent">

                                <!-- Content -->
                                <article class="box is-post">
                                    <c:forEach items="${article.ap.imagePOJOS}" var="item">
                                    <a href="#" class="image image-full"><img src="Uploaded_Images/${item.source}" alt="" /></a>
                                    </c:forEach>
                                    <header>
                                        <h2 class="art-title">${article.ap.title} </h2>
                                        <span class="byline"><h4 class="auth-name">${article.up.username}</h4></span>
                                        <span class="byline"><h4 class="artdate">${article.ap.article_date}</h4></span>
                                    </header>


                                    <div id ="article-cotent">
                                        ${article.ap.content}


                                    </div>


                                    <footer class="actions">
                                        <%--<a href="#" class="button  ">next</a>--%>
                                        <%--<button class="nextArticleButtom " type="submit"  name="next article" value="Next Article" >Next Article</button>--%>

                                            <%if (userPOJO!=null){%>
                                            <br>
                                            <button onclick="loadArticleCommentsJSP(${article.ap.article_id})">Comments </button>
                                            <br>
                                           <% } else {%>
                                            <br>
                                            <button onclick="login()">Comments </button>
                                            <br>
                                            <%  }%>



                                    </footer>
                                </article>

                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </div>
    </div>
</div>


<div id ="side_nav">

    <%if(userPOJO!=null){%>
         <br>
    <button onclick="addNewArticle()">Add a new article </button>
    <button>My Account</button>
    <br>
   <% }%>

</div>

<script>

    function login() {
        if(confirm("you didn't login ,you can't comment")==1){
            location.href="/index_login.jsp"
        }
    }
</script>

</body>
</html>
