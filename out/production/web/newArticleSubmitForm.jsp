<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New Article</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="TianCSS/article_add.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="../JQuery_lib/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="myJS.js"></script>

    <link rel="apple-touch-icon" href="//mindmup.s3.amazonaws.com/lib/img/apple-touch-icon.png"/>
    <link rel="shortcut icon" href="http://mindmup.s3.amazonaws.com/lib/img/favicon.ico">
    <link href="external/google-code-prettify/prettify.css" rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.no-icons.min.css"
          rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-responsive.min.css"
          rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="external/jquery.hotkeys.js"></script>
    <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
    <script src="external/google-code-prettify/prettify.js"></script>
    <link href="index.css" rel="stylesheet">
    <script src="bootstrap-wysiwyg.js"></script>
</head>
<body>
<form action="/ArticleUpload" method="post" enctype="multipart/form-data">
    <div id="container">
        <div id="nav">
            <img id="index_logo" src="images/icon_logo.png">
            <input type="search" id="search_bar" placeholder=" Search..."/>
            <a href="homepage.jsp">
                <img id="icon_homepage" src="${userPOJO.getAvatar()}" src="images/image_default_avatar.png"> ${userPOJO.getFirstName()}
            </a>
            <a href="index.jsp">
                <img id="icon_home" src="images/icon_home.png">
            </a>
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
                                    <div class="container" id="zone_editor">
                                        <div class="hero-unit">
                                            <div id="alerts"></div>
                                            <div class="btn-toolbar" data-role="editor-toolbar" data-target="#editor">
                                                <div class="btn-group">
                                                    <a class="btn dropdown-toggle" data-toggle="dropdown"
                                                       title="Font"><i class="icon-font"></i><b class="caret"></b></a>
                                                    <ul class="dropdown-menu">
                                                    </ul>
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn dropdown-toggle" data-toggle="dropdown"
                                                       title="Font Size"><i class="icon-text-height"></i>&nbsp;<b
                                                            class="caret"></b></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a data-edit="fontSize 5"><font size="5">Huge</font></a>
                                                        </li>
                                                        <li><a data-edit="fontSize 3"><font size="3">Normal</font></a>
                                                        </li>
                                                        <li><a data-edit="fontSize 1"><font size="1">Small</font></a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i
                                                            class="icon-bold"></i></a>
                                                    <a class="btn" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i
                                                            class="icon-italic"></i></a>
                                                    <a class="btn" data-edit="strikethrough" title="Strikethrough"><i
                                                            class="icon-strikethrough"></i></a>
                                                    <a class="btn" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i
                                                            class="icon-underline"></i></a>
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn" data-edit="insertunorderedlist"
                                                       title="Bullet list"><i class="icon-list-ul"></i></a>
                                                    <a class="btn" data-edit="insertorderedlist" title="Number list"><i
                                                            class="icon-list-ol"></i></a>
                                                    <a class="btn" data-edit="outdent"
                                                       title="Reduce indent (Shift+Tab)"><i
                                                            class="icon-indent-left"></i></a>
                                                    <a class="btn" data-edit="indent" title="Indent (Tab)"><i
                                                            class="icon-indent-right"></i></a>
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn" data-edit="justifyleft"
                                                       title="Align Left (Ctrl/Cmd+L)"><i
                                                            class="icon-align-left"></i></a>
                                                    <a class="btn" data-edit="justifycenter"
                                                       title="Center (Ctrl/Cmd+E)"><i
                                                            class="icon-align-center"></i></a>
                                                    <a class="btn" data-edit="justifyright"
                                                       title="Align Right (Ctrl/Cmd+R)"><i
                                                            class="icon-align-right"></i></a>
                                                    <a class="btn" data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i
                                                            class="icon-align-justify"></i></a>
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn dropdown-toggle" data-toggle="dropdown"
                                                       title="Hyperlink"><i class="icon-link"></i></a>
                                                    <div class="dropdown-menu input-append">
                                                        <input class="span2" placeholder="URL" type="text"
                                                               data-edit="createLink"/>
                                                        <button class="btn" type="button">Add</button>
                                                    </div>
                                                    <a class="btn" data-edit="unlink" title="Remove Hyperlink"><i
                                                            class="icon-cut"></i></a>

                                                </div>

                                                <div class="btn-group">
                                                    <a class="btn" title="Insert picture (or just drag & drop)"
                                                       id="pictureBtn"><i class="icon-picture"></i></a>
                                                    <input type="file" data-role="magic-overlay"
                                                           data-target="#pictureBtn" data-edit="insertImage"/>
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
                                                            class="icon-undo"></i></a>
                                                    <a class="btn" data-edit="redo" title="Redo (Ctrl/Cmd+Y)"><i
                                                            class="icon-repeat"></i></a>
                                                </div>
                                                <input type="text" data-edit="inserttext" id="voiceBtn"
                                                       x-webkit-speech="">
                                            </div>
                                            <div id="editor"></div>
                                            <input type="hidden" id="ediVal" name="article_content">
                                            <script>
                                                $('#editor').get(0).oninput = function () {
                                                    console.log(11111111111)
                                                    $("#ediVal").val($("#editor").html())
                                                }
                                            </script>
                                        </div>
                                    </div>
                                    <script>
                                        $(function () {
                                            function initToolbarBootstrapBindings() {
                                                var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
                                                        'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
                                                        'Times New Roman', 'Verdana'],
                                                    fontTarget = $('[title=Font]').siblings('.dropdown-menu');
                                                $.each(fonts, function (idx, fontName) {
                                                    fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
                                                });
                                                $('a[title]').tooltip({container: 'body'});
                                                $('.dropdown-menu input').click(function () {
                                                    return false;
                                                })
                                                    .change(function () {
                                                        $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');
                                                    })
                                                    .keydown('esc', function () {
                                                        this.value = '';
                                                        $(this).change();
                                                    });

                                                $('[data-role=magic-overlay]').each(function () {
                                                    var overlay = $(this), target = $(overlay.data('target'));
                                                    overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
                                                });
                                                if ("onwebkitspeechchange" in document.createElement("input")) {
                                                    var editorOffset = $('#editor').offset();
                                                    $('#voiceBtn').css('position', 'absolute').offset({
                                                        top: editorOffset.top,
                                                        left: editorOffset.left + $('#editor').innerWidth() - 35
                                                    });
                                                } else {
                                                    $('#voiceBtn').hide();
                                                }
                                            };

                                            function showErrorAlert(reason, detail) {
                                                var msg = '';
                                                if (reason === 'unsupported-file-type') {
                                                    msg = "Unsupported format " + detail;
                                                }
                                                else {
                                                    console.log("error uploading file", reason, detail);
                                                }
                                                $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
                                                    '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
                                            };
                                            initToolbarBootstrapBindings();
                                            $('#editor').wysiwyg({fileUploadError: showErrorAlert});
                                            window.prettyPrint && prettyPrint();
                                        });
                                    </script>
                                    <br>
                                    <br>
                                    <b> Upload Image: </b>
                                    <input  type="file" id="picture" name="picture" accept="image/png, image/jpeg,image/jpg" multiple>
                                    <br>
                                    <br>
                                    <b> Upload Audio: </b>
                                    <input  type="file" id="audioUpload" name="audioUpload" accept="audio/*">
                                    <br>
                                    <br>
                                    <b> Upload Video: </b>
                                    <input  type="file" id="videoUpload" name="videoUpload" accept="video/*">
                                    <br>
                                    <br>
                                    <b> Youtube Link: </b>
                                    <input  type="text" id="youtubeLink" name="youtubeLink">
                                    <br>
                                    <br>
                                    <b>Publishing Date:</b>
                                    <input  id="theDate" type="date" name="article_date">
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
