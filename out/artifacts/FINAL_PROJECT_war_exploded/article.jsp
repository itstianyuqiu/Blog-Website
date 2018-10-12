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
                            <li><a href="homepage.jsp">Home Page</a></li>
                            <%--<li><button>My Account</button></li>--%>
                            <%--<li><a href="#">Other Articles</a></li>--%>
                            <li><a onclick="loadAllArticle()">Other Articles</a></li>
                            <li><a onclick="loadAllArticle()">Other Articles</a></li>

                            <li class="current_page_item"><a href="article.jsp">Current Article</a></li>

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
                                    <a href="http://facebook.com/DreametryDoodle" class="image image-full"><img src="images/pic01.jpg" alt="" /></a>
                                    <header>
                                        <h2>TEST WORD</h2>
                                        <span class="byline">Lorem ipsum dolor sit amet feugiat</span>
                                    </header>
                                    <p>
                                        Vestibulum scelerisque ultricies libero id hendrerit. Vivamus malesuada quam faucibus ante dignissim auctor
                                        hendrerit libero placerat. Nulla facilisi. Proin aliquam felis non arcu molestie at accumsan turpis commodo.
                                        Proin elementum, nibh non egestas sodales, augue quam aliquet est, id egestas diam justo adipiscing ante.
                                        Pellentesque tempus nulla non urna eleifend ut ultrices nisi faucibus.
                                        Vestibulum scelerisque ultricies libero id hendrerit. Vivamus malesuada quam faucibus ante dignissim auctor
                                        hendrerit libero placerat. Nulla facilisi. Proin aliquam felis non arcu molestie at accumsan turpis commodo.
                                        Proin elementum, nibh non egestas sodales, augue quam aliquet est, id egestas diam justo adipiscing ante.
                                    </p>
                                    <p>
                                        Praesent a dolor leo. Duis in felis in tortor lobortis volutpat et pretium tellus. Vestibulum ac ante nisl,
                                        a elementum odio. Duis semper risus et lectus commodo fringilla. Maecenas sagittis convallis justo vel mattis.
                                        placerat, nunc diam iaculis massa, et aliquet nibh leo non nisl vitae porta lobortis, enim neque fringilla nunc,
                                        eget faucibus lacus sem quis nunc suspendisse nec lectus sit amet augue rutrum vulputate ut ut mi. Aenean
                                        elementum, mi sit amet porttitor lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor.
                                    </p>

                                    <div id ="articles">


                                    </div>
                                    <section>
                                        <header>
                                            <h3>Something else</h3>
                                        </header>
                                        <p>
                                            Elementum odio duis semper risus et lectus commodo fringilla. Maecenas sagittis convallis justo vel mattis.
                                            placerat, nunc diam iaculis massa, et aliquet nibh leo non nisl vitae porta lobortis, enim neque fringilla nunc,
                                            eget faucibus lacus sem quis nunc suspendisse nec lectus sit amet augue rutrum vulputate ut ut mi. Aenean
                                            elementum, mi sit amet porttitor lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor
                                            sit amet nullam consequat feugiat dolore tempus.
                                            Elementum odio duis semper risus et lectus commodo fringilla. Maecenas sagittis convallis justo vel mattis.
                                            placerat, nunc diam iaculis massa, et aliquet nibh leo non nisl vitae porta lobortis, enim neque fringilla nunc,
                                            eget faucibus lacus sem quis nunc suspendisse nec lectus sit amet augue rutrum vulputate ut ut mi. Aenean
                                            elementum, mi sit amet porttitor lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor.
                                        </p>
                                        <p>
                                            Nunc diam iaculis massa, et aliquet nibh leo non nisl vitae porta lobortis, enim neque fringilla nunc,
                                            eget faucibus lacus sem quis nunc suspendisse nec lectus sit amet augue rutrum vulputate ut ut mi. Aenean
                                            elementum, mi sit amet porttitor lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor
                                            sit amet nullam consequat feugiat dolore tempus.
                                        </p>
                                    </section>
                                    <section>
                                        <header>
                                            <h3>So in conclusion ...</h3>
                                        </header>
                                        <p>
                                            Nunc diam iaculis massa, et aliquet nibh leo non nisl vitae porta lobortis, enim neque fringilla nunc,
                                            eget faucibus lacus sem quis nunc suspendisse nec lectus sit amet augue rutrum vulputate ut ut mi. Aenean
                                            elementum, mi sit amet porttitor lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor
                                            sit amet nullam consequat feugiat dolore tempus. Elementum odio duis semper risus et lectus commodo fringilla.
                                            Maecenas sagittis convallis justo vel mattis.
                                        </p>
                                    </section>
                                    <footer class="actions">
                                        <%--<a href="#" class="button  ">next</a>--%>
                                        <%--<button class="nextArticleButtom " type="submit"  name="next article" value="Next Article" >Next Article</button>--%>
                                        <a href="#" class="">comments</a>


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
    <button onclick="loadUserArticle()">My Articles </button>
    <br>
    <button  onclick="loadAllArticle()"></button>
    <br>
    <button onclick="addNewArticle()">Add a new article </button>
    <br>

    <button>My Account</button>
</div>




</body>
</html>
