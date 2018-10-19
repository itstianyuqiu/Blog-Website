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

function loadCurrentDate() {
    var date = new Date();

    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();

    if (month < 10) {
        month = "0" + month;
    }

    if (day < 10){
        day = "0" + day;
    }

    var today = year + "-" + month + "-" + day;

    document.getElementById("theDate").value = today;

}

function showDeleteArticleForm(articleID) {

    var x = document.getElementById("delete_article_" + articleID + "");
    var y = document.getElementById("del_article_button_" + articleID + "");

    x.style.display = "block";
    y.style.display = "none";

}

function cancelDeleteArticleForm(articleID) {

    var x = document.getElementById("delete_article_" + articleID + "");
    var y = document.getElementById("del_article_button_" + articleID + "");

    x.style.display = "none";
    y.style.display = "block";

}

function showDeleteUserAccountForm() {

    var x = document.getElementById("delete_user_account");
    var y = document.getElementById("delete_user_account_button");
    x.style.display = "block";
    y.style.display = "none";

}

function cancelDeleteUserAccountForm() {

    var x = document.getElementById("delete_user_account");
    var y = document.getElementById("delete_user_account_button");
    x.style.display = "none";
    y.style.display = "block";

}


