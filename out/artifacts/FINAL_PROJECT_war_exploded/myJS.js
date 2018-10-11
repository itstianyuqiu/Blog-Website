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

function showVisibility(articleID) {

    var x = document.getElementById("" + articleID + "");

    console.log(x.style.display);

    if (x.style.display === "block") {
        console.log("if");
        x.style.display = "none";
    } else {
        console.log("else");
        x.style.display = "block";
    }

}


function hideVisibility(articleID) {
    var x = document.getElementById("" + articleID + "");
    x.style.display = "none";

}

function loadArticleCommentsJSP(articleID) {
    $("#" + articleID + "").load('../JSP_Pages/articleComments.jsp');
}


