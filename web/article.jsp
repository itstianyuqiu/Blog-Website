<%@ page import="POJO.UserPOJO" %>
<%@ page import="POJO.ArticlePOJO" %>
<%@ page import="POJO.JoinQueryDataModel" %>
<%@ page import="POJO.ImagePOJO" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.ArticleDAO" %>
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
                <section id="headerArticle">


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
                                    <%--<c:forEach items="${article.ap.imagePOJOS}" var="item">--%>
                                    <a href="#" class="image image-full">
                                        <%--<img src="Uploaded_Images/${item.source}" alt="" />--%>
                                        <img src="images/pic01.jpg" alt="">
                                    </a>
                                    <%--</c:forEach>--%>

                                    <header>
                                        <h3>Title: ${article.ap.title}</h3>

                                        <hr>
                                        <h3>Author: ${article.up.username}</h3>

                                        <hr>
                                        <h3>Date: ${article.ap.article_date}</h3>

                                    </header>

                                        <hr>
                                        <p> ${article.ap.content} </p>


                                        <hr>
                                        <h3>Comments: </h3>



                                    <footer class="actions">
                                        <%--<a href="#" class="button  ">next</a>--%>
                                        <%--<button class="nextArticleButtom " type="submit"  name="next article" value="Next Article" >Next Article</button>--%>

                                            <%if (userPOJO!=null){%>
                                            <br>
                                            <%
                                            request.getSession().setAttribute("page","singleArticle");
                                            request.getSession().setAttribute("current_article", request.getSession().getAttribute("current_article"));
                                            %>
                                            <div id ="${article.ap.article_id}">
                                                <script>
                                                    loadSingleArticleComments(${article.ap.article_id});
                                                </script>
                                            </div>
                                           <% } else {%>
                                            <br>
                                            <button onclick="login()">Show Comments </button>
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



<script>

    function login() {
        if(confirm("you didn't login ,you can't comment")==1){
            location.href="/index_login.jsp"
        }
    }
</script>

</body>
</html>
