package POJO;

public class CommentsPOJO {
    int commentID;
    int userID;
    int articleID;
    String comments;
    boolean commentsVisibility;
    boolean on_article;
    boolean is_parent;

    public CommentsPOJO() {
    }

    public void setOn_article(boolean on_article) {
        this.on_article = on_article;
    }

    public void setIs_parent(boolean is_parent) {
        this.is_parent = is_parent;
    }

    public boolean isOn_article() {
        return on_article;
    }

    public boolean isIs_parent() {
        return is_parent;
    }

    public int getCommentID() {
        return commentID;
    }

    public int getUserID() {
        return userID;
    }

    public int getArticleID() {
        return articleID;
    }

    public String getComments() {
        return comments;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public boolean isCommentsVisibility() {
        return commentsVisibility;
    }

    public void setCommentsVisibility(boolean commentsVisibility) {
        this.commentsVisibility = commentsVisibility;
    }
}
