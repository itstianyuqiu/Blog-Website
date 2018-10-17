function start() {
    loadAllArticleWithoutComments();
}

function loadAllArticleWithoutComments() {
    $('#all_articles').load('../JSP_Pages/allArticlesWithoutComments.jsp');
}

function loadAllArticleWithComments() {
    $('#all_articles').load('../JSP_Pages/allArticlesWithComments.jsp');
}
// function loadUserArticle() {
//     $('#articles').load('../JSP_Pages/myArticles.jsp');
// }
//
// function addNewArticle() {
//     $('#btn_add_new_article').hide();
//     $('#add_new_articles').load('../JSP_Pages/newArticleSubmitForm.jsp');
// }


function load_article() {
    $('#my_articles').load('../JSP_Pages/myArticles.jsp');
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


