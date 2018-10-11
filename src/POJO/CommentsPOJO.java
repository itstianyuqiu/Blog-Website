package POJO;

public class CommentsPOJO {
    int commentID;
    int userID;
    int articleID;
    String comments;

    public CommentsPOJO(){}

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
}
