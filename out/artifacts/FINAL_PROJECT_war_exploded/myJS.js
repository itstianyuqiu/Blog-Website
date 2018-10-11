function start() {
    loadSession();
    loadAllArticleWithoutComments();
}

function loadSession() {
    sessionStorage.setItem("buttonClicked","false");
}

function loadAllArticleWithoutComments() {
    $('#articles').load('../JSP_Pages/allArticlesWithoutComments.jsp');
}

function loadAllArticleWithComments() {
    $('#articles').load('../JSP_Pages/allArticlesWithComments.jsp');
}
function loadUserArticle() {
    $('#articles').load('../JSP_Pages/myArticles.jsp');
}

function addNewArticle() {
    $('#btn_add_new_article').hide();
    $('#articles').load('../JSP_Pages/newArticleSubmitForm.jsp');
}



function showVisibility() {


    var commentDIVs =  document.getElementsByClassName("comments");

    for (var i = 0; i < commentDIVs.length; i++){
        commentDIVs[i].style.visibility = "visible";
    }

}

function hideVisibility() {
    var commentDIVs =  document.getElementsByClassName("comments");
    for (var i = 0; i < commentDIVs.length; i++){
        commentDIVs[i].style.visibility = "hidden";
    }
}

function loadArticleCommentsJSP() {
    $('.comments').load('../JSP_Pages/articleComments.jsp');
}

function loadArticleCommentsJSPTwo(article) {
    var art = document.getElementById(article);
    $(art).load('../JSP_Pages/articleComments.jsp');
}