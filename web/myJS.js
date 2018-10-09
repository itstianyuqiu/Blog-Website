function start() {
    loadSession();
    loadAllArticle();
}

function loadSession() {
    sessionStorage.setItem("buttonClicked","false");
}

function loadAllArticle() {
    $('#articles').load('../JSP_Pages/allArticles.jsp');
}
function loadUserArticle() {
    $('#articles').load('../JSP_Pages/myArticles.jsp');
}

function addNewArticle() {
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