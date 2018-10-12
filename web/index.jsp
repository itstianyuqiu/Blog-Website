<%--
  Created by IntelliJ IDEA.
  User: kugn318
  Date: 4/10/2018
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
    <link rel="stylesheet" href="homepageCSS/cssStyle.css">
    <link rel="stylesheet" href="homepageCSS/rowPart.css">
    <link rel="stylesheet" href="homepageCSS/otherCss.css">
    <link rel="stylesheet" href="homepageCSS/containerCSS.css">
    <link rel="stylesheet" href="homepageCSS/imageCSS.css">
      <link rel="stylesheet" href="homepageCSS/popUpCss.css">
      <script type="text/javascript" src="JQuery_lib/jquery-3.3.1.js"></script>
      <script type="text/javascript" src="myJS.js"></script>
  </head>
  <body class="homepage">

  <!-- Header -->



  <%--heading--%>

  <!-- Header Wrapper -->
  <div id="header-wrapper">


        <div class="container">
                <%--<div id="research123"class="search bar1">--%>
                    <%--<form>--%>
                            <%--<input  class="bar1Typein" type="text" placeholder="Please typing in...">--%>
                        <%--<button type="submit"></button>--%>
                        <%--</form>--%>
                <%--</div>--%>


          <div class="row">
                <%--<div >--%>
            <div class="12u">


                <div class="login_signUp">
                        <%--<a href="index_login.jsp" class="image image-full login"><img src="images/login.png" alt="" /></a>--%>
                            <a href="index_login.jsp"><button class="login" type="submit" name="login" value="Log in" >Log in</button>
                            </a>
                            <a href="index_signup.jsp"><button class="signUp " type="submit" name="newAccount" value="Create new Account">Sign Up</button>
                            </a>
                        <%--<a href="index_login.jsp" class="login button">Log in</a>--%>
                        <%--<a href="index_signup.jsp" class="signUp button button-alt">Sign Up</a>--%>
                </div>

                        <!-- Header -->
                                <section id="header">
                                    <!-- Logo -->
                                    <h1><a href="#">Blog</a></h1>
                                </section>
            </div>
          </div>
        </div>
  </div>







    <div id="main-wrapper">
        <div class="container">

                    <%--blog--%>
                <div class="row">

                        <div class="12u">

                                <!-- Blog -->
                                <section>
                                    <header class="major">
                                        <h2>The Blog</h2>
                                    </header>
                                            <div>
                                                <div class="row">
                                                        <div class="6u" >
                                                                <section class="box">
                                                                        <a href="http://facebook.com/DreametryDoodle" class="image image-full">
                                                                            <img src="images/pic08.jpg" alt=""  height="272"/>
                                                                        </a>
                                                                            <header>
                                                                                <h3>Magna tempus consequat lorem</h3>
                                                                                <%--<span class="byline">Posted 45 minutes ago</span>--%>
                                                                            </header>
                                                                                <p>Lorem ipsum dolor sit amet sit veroeros sed et blandit consequat sed veroeros lorem et blandit  adipiscing feugiat phasellus tempus hendrerit, tortor vitae mattis tempor, sapien sem feugiat sapien, id suscipit magna felis nec elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos lorem ipsum dolor sit amet.</p>
                                                                            <br>
                                                                            <footer class="actions">
                                                                                <a href="article.jsp" class="button button-icon button-icon-1">show the whole article</a>
                                                                                <a href="#popup" class="button button-alt button-icon button-icon-2">comments</a>
                                                                                <div class="popup" id="popup">
                                                                                    <div class="popup-inner">
                                                                                       <%--photo--%>
                                                                                           <div class="popup__photo">
                                                                                               <img src="images/pic07.jpg" alt="">
                                                                                           </div>
                                                                                        <div class="popup__text">
                                                                                            <h1>Please Login or Sign up!</h1>
                                                                                          </div>
                                                                                           <a class="buttonPopUp popUp1" href="index_login.jsp">Login</a>
                                                                                           <a class="buttonPopUp popUp2" href="index_signup.jsp">Sign Up</a>
                                                                                        <a class="popup__close" href="#">X</a>
                                                                                    </div>
                                                                                </div>
                                                                            </footer>
                                                                </section>
                                                        </div>
                                                        <%--<div class="6u">--%>
                                                                <%--<section class="box">--%>
                                                                        <%--<a href="http://facebook.com/DreametryDoodle" class="image image-full"><img src="images/pic09.jpg" alt="" /></a>--%>
                                                                            <%--<header>--%>
                                                                                <%--<h3>Aptent veroeros et aliquam</h3>--%>
                                                                                <%--<span class="byline">Posted 45 minutes ago</span>--%>
                                                                            <%--</header>--%>
                                                                                <%--<p>Lorem ipsum dolor sit amet sit veroeros sed et blandit consequat sed veroeros lorem et blandit  adipiscing feugiat phasellus tempus hendrerit, tortor vitae mattis tempor, sapien sem feugiat sapien, id suscipit magna felis nec elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos lorem ipsum dolor sit amet.</p>--%>
                                                                            <%--<footer class="actions">--%>
                                                                                <%--<a href="#" class="button button-icon button-icon-1">Continue Reading</a>--%>
                                                                                <%--<a href="#" class="button button-alt button-icon button-icon-2">33 comments</a>--%>
                                                                            <%--</footer>--%>
                                                                <%--</section>--%>
                                                        <%--</div>--%>

                                                    <div id="articles">
                                                        <%-- to edit into front end --%>
                                                        <script>
                                                            start();
                                                        </script>
                                                    </div>
                                                </div>
                                            </div>
                                </section>
                        </div>
                </div>
        </div>
    </div>




  </body>
</html>
