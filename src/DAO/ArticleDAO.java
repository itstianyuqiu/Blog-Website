package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import POJO.*;
import com.zaxxer.hikari.HikariDataSource;

public class ArticleDAO implements AutoCloseable {

    private final Connection conn;

    public ArticleDAO() throws SQLException {
        this.conn = HikariConnectionPool.getConnection();
    }

public ArticlePOJO quaryArtAndimgs(int article_id) throws SQLException {
    ArticlePOJO article=null;
    try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article WHERE article_visibility = TRUE AND article_id = ?")) {
        smt.setInt(1, article_id);
        try (ResultSet rs = smt.executeQuery()) {
            while (rs.next()) {
                 article = loadSingleArticle(rs);
            }
        }
    }
    return article;
}
public  List<ImagePOJO> quaryImgByartID(int article_id) throws SQLException {
        List<ImagePOJO> imagePOJOs=new ArrayList<>();
    try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM group1.project_article_images WHERE article_id=?")) {
        smt.setInt(1, article_id);
        try (ResultSet rs = smt.executeQuery()) {
            while (rs.next()) {
               ImagePOJO img = loadSingleImg(rs);
                imagePOJOs.add(img);
            }
        }
    }
    return imagePOJOs;
}

private ImagePOJO loadSingleImg(ResultSet rs) throws SQLException {

    ImagePOJO imagePOJO=new ImagePOJO();


        imagePOJO.setArticle_id(rs.getInt(1));
        imagePOJO.setImage_id(rs.getInt(2));
        imagePOJO.setSource(rs.getString(3));


    return imagePOJO;
}
    /* METHODS TO ADD, LOAD AND DELETE ARTICLES FROM THE DATABASE */

    //Returns a list of all articles from the database, where the artice_visibility is true (i.e. they haven't been hidden by the admin) and they are equal to or before the current date

    public List<ArticlePOJO> loadAllArticles() throws SQLException {

        List<ArticlePOJO> articles = new ArrayList<>();
        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article WHERE article_visibility = TRUE AND article_date <= CURDATE()")) {

            try (ResultSet rs = smt.executeQuery()) {

                while (rs.next()) {
                    ArticlePOJO article = loadSingleArticle(rs);
                    articles.add(article);
                }
            }
        }
        return articles;
    }

    //Returns a list of articles from the database where the userID is equal to the user that is currently logged in, and where the artice_visibility is true (i.e. they haven't been hidden by the admin)
    // and they are equal to or before the current date

    public List<ArticlePOJO> loadUserArticles(String userID) throws SQLException {
        List<ArticlePOJO> articles = new ArrayList<>();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article WHERE author_id = ? AND article_visibility = TRUE AND article_date <= CURDATE()")) {

            smt.setString(1, userID);

            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    ArticlePOJO article = loadSingleArticle(rs);
                    articles.add(article);
                }
            }
        }

        return articles;
    }

    //Method to load a single article from the database (and all of it's details) - this method is then called in loadAllArticles() and LoadUserArticles() and each article is added to the list

    public ArticlePOJO loadSingleArticle(ResultSet rs) throws SQLException {

        ArticlePOJO article = new ArticlePOJO();
            article.setArticle_id(rs.getInt(1));
            article.setTitle(rs.getString(2));
            article.setContent(rs.getString(3));
            article.setAuthor_id(rs.getInt(4));
            article.setArticle_visibility(rs.getBoolean(5));
            article.setArticle_date(rs.getString(6));
            article.setArticle_audio(rs.getString(7));
            article.setArticle_video(rs.getString(8));
            article.setArticle_Youtube(rs.getString(9));

        return article;
    }


    //Adds a new article to the database - passes in details from an ArticlePOJO and places them into the database - sets the article_visibility to TRUE

    public void addNewArticle(ArticlePOJO apj) throws SQLException, ParseException {

        int userID = apj.getAuthor_id();
        String heading = apj.getTitle();
        String content = apj.getContent();
        String dateString = apj.getArticle_date();
        String audio = apj.getArticle_audio();
        String video = apj.getArticle_video();
        String youtube = apj.getArticle_Youtube();

        Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);

        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article (article_title, article_content, author_id, article_visibility, article_date,article_audio,article_video,article_YouTube) " +
                "VALUES (?, ?, ?, TRUE, ?, ?, ?, ?)")) {
            smt.setString(1, heading);
            smt.setString(2, content);
            smt.setInt(3, userID);
            smt.setDate(4, new java.sql.Date(date.getTime()));
            smt.setString(5, audio);
            smt.setString(6, video);
            smt.setString(7, youtube);
            smt.executeUpdate();
        }

    }

    //Deletes an article from the database - deletes the article from four tables in total

    public void deleteArticle(String index) throws SQLException {

        List<CommentsPOJO> allComments = getCommentsByArticle(index);

//        try (PreparedStatement smt = this.conn.prepareStatement("DELETE * FROM project_comment_relationship WHERE article_id = ?")) {
//            smt.setString(1,index);
//            smt.executeUpdate();
//        }

        //Returns the parent comments from the project_article_comment table for the article that is being deleted. This is then passed into the deleteRelationshipsByParentID() method to
        // delete the comment from the project_comments_relationship table

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT comment_id FROM project_article_comment WHERE is_parent = TRUE AND article_id = ?")) {
            smt.setString(1, index);
            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    deleteRelationshipByParentID(rs.getString(1));
                }
            }
        }

        deleteImagesByArticleID(index);

       deleteCommentsByArticleID(index);

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article WHERE article_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }
    }

    //This updates an article's details in the project_article table

    public void updateArticle(ArticlePOJO article) throws SQLException, ParseException {

        int articleID = article.getArticle_id();
        String title = article.getTitle();
        String content = article.getContent();
        String dateString = article.getArticle_date();

        Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);

        try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article SET article_title = ?, article_content = ?, article_date = ? WHERE article_id = ?")) {
            smt.setString(1, title);
            smt.setString(2, content);
            smt.setDate(3, new java.sql.Date(date.getTime()));
            smt.setInt(4, articleID);
            smt.executeUpdate();
        }

    }

    //This returns the article_id of the last article that was added to the database

    public int getIDOfLastArticle() throws SQLException {

        int article_ID = 0;

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT article_id FROM project_article ORDER BY article_id DESC")) {

            try (ResultSet rs = smt.executeQuery()) {
                rs.next();
                article_ID = rs.getInt(1);
            }
        }

        return article_ID;
    }

    /* METHODS TO ADD, LOAD AND DELETE COMMENTS FROM THE DATABASE */

    //Deletes all comments from the project_article_comment table for a particular article (this must be done in order to delete the article so is called in the deleteArticle() method)

    public void deleteCommentsByArticleID (String index) throws SQLException {
        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_comment WHERE article_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }
    }

    //This deletes the parent comment from the project_comment_relationship for the article that is being deleted (called in the deleteArticle() method)

    public void deleteRelationshipByParentID(String index) throws SQLException {

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_comment_relationship WHERE parent_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

    }

    //Returns a list of all the comments associated with an article (and where visibility is set to TRUE)

    public List<CommentsPOJO> getCommentsByArticle(String articleID) throws SQLException {

        List<CommentsPOJO> allComments = new ArrayList<>();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT comment_id, user_id, article_comment, comment_visibility, on_article, is_parent " +
                "FROM project_article_comment " +
                "WHERE article_id = ? AND comment_visibility = TRUE AND on_article = TRUE")) {
            smt.setString(1, articleID);

            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    CommentsPOJO cpj = new CommentsPOJO();
                    cpj.setCommentID(rs.getInt("comment_id"));
                    cpj.setUserID(rs.getInt("user_id"));
                    cpj.setArticleID(Integer.parseInt(articleID));
                    cpj.setComments(rs.getString("article_comment"));
                    cpj.setCommentsVisibility(rs.getBoolean("comment_visibility"));
                    cpj.setOn_article(rs.getBoolean("on_article"));
                    cpj.setIs_parent(rs.getBoolean("is_parent"));
                    allComments.add(cpj);
                }
            }
        }

        return allComments;
    }

    //Adds a new comment to the project_article_comment table (sets on_article to TRUE and is_parent to FALSE)

    public void addNewComment(CommentsPOJO cpj) throws SQLException {

        int userID = cpj.getUserID();
        int articleID = cpj.getArticleID();
        String content = cpj.getComments();

        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article_comment (user_id, article_id, article_comment, comment_visibility, on_article, is_parent) " +
                "VALUES (?, ?, ?, TRUE, TRUE, FALSE)")) {
            smt.setInt(1, userID);
            smt.setInt(2, articleID);
            smt.setString(3, content);
            smt.executeUpdate();
        }
    }

    //Deletes a single comment from the database

    public void deleteComment(String index) throws SQLException {

        //Returns the parent_id and child_id of the comment and then calls methods to delete these comments

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_comment_relationship WHERE parent_id = ?")) {
            smt.setString(1, index);
            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    deleteRelationshipByParentID(rs.getString(1));
                    deleteChildByRelationship(rs.getString(2));
                }
            }
        }

        //Deletes the comment from the project_article_comment table ------ Potential duplicate method with below?

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_comment WHERE comment_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

    }

    public void deleteChildByRelationship(String index) throws SQLException {

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_comment WHERE comment_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

    }

    //Deletes a single comment when that comment is a child of another comment (deletes from two tables)

    public void deleteSingleChildComment(String index) throws SQLException {

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_comment_relationship WHERE child_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_comment WHERE comment_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

    }

    //Gets a list of all child comments for a particular parent comment

    public List<CommentsPOJO> getChildComments(int index) throws SQLException {
        List<CommentsPOJO> allComments = new ArrayList<>();
        ArrayList<Integer> child_index = getChildIndex(index);

        for (Integer i : child_index) {
            CommentsPOJO cpj = getChildInfo(i);
            allComments.add(cpj);
        }

        return allComments;
    }

    //Gets the child_id of all child comments that belong to a particular parent comment; used in the method above to get all child comments for that article

    public ArrayList<Integer> getChildIndex(int index) throws SQLException {

        ArrayList<Integer> child_index = new ArrayList<>();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT child_id FROM project_comment_relationship WHERE parent_id = ?;")) {
            smt.setInt(1, index);

            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    child_index.add(rs.getInt("child_id"));
                }
            }
        }

        return child_index;
    }

    //Gets the details of a particular comment

    public CommentsPOJO getChildInfo(Integer index) throws SQLException {

        CommentsPOJO cpj = new CommentsPOJO();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article_comment WHERE comment_id = ?;")) {
            smt.setInt(1, index);

            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    cpj.setCommentID(rs.getInt("comment_id"));
                    cpj.setUserID(rs.getInt("user_id"));
                    cpj.setArticleID(rs.getInt("article_id"));
                    cpj.setComments(rs.getString("article_comment"));
                    cpj.setCommentsVisibility(rs.getBoolean("comment_visibility"));
                    cpj.setOn_article(rs.getBoolean("on_article"));
                    cpj.setIs_parent(rs.getBoolean("is_parent"));
                }
            }
        }

        return cpj;
    }

    //Adds child comments to the database; updates it's parent comment 'is_parent' to TRUE and then inserts the childs into project_article_comment and project_comment_relationship tables

    public void addChildComment(String parentID, CommentsPOJO cpj) throws SQLException {

        int userID = cpj.getUserID();
        int articleID = cpj.getArticleID();
        String content = cpj.getComments();

        try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article_comment SET is_parent = TRUE WHERE comment_id = ?")) {
            smt.setString(1, parentID);
            smt.executeUpdate();
        }

        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article_comment (user_id, article_id, article_comment, comment_visibility, on_article, is_parent) " +
                "VALUES (?, ?, ?, TRUE, FALSE , FALSE)")) {
            smt.setInt(1, userID);
            smt.setInt(2, articleID);
            smt.setString(3, content);
            smt.executeUpdate();
        }

        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_comment_relationship (parent_id, child_id) VALUES (?,?)")) {
            smt.setString(1, parentID);
            smt.setInt(2, getIndexOfLastComment());
            smt.executeUpdate();
        }

    }

    //Gets the comment_id of the last comment that was added to the database

    public int getIndexOfLastComment() throws SQLException {

        int comment_ID = 0;

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT comment_id FROM project_article_comment ORDER BY comment_id DESC")) {

            try (ResultSet rs = smt.executeQuery()) {
                rs.next();
                comment_ID = rs.getInt(1);
            }
        }

        return comment_ID;
    }

    /* METHODS TO ADD, LOAD AND DELETE IMAGES FROM THE DATABASE */

    //Deletes the article from the project_article_images table (this must be done in order to delete the article so is called in the deleteArticle() method)

    public void deleteImagesByArticleID (String index) throws SQLException {

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_images WHERE article_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

    }

    //Saves the path/link for all images that have been added to the database

    public void saveImageToDatabase(ImagePOJO ipj) throws SQLException {
        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article_images (article_id, image_source) VALUES (?, ?)")) {

            smt.setInt(1, ipj.getArticle_id());
            smt.setString(2, ipj.getSource());

            smt.execute();
        }
    }

    //Returns a list of all images that are in the database that belong to a particular article

    public List<ImagePOJO> loadImageFromArticle(int index) throws SQLException {

        List<ImagePOJO> allImages = new ArrayList<>();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article_images WHERE article_id = ?")) {
            smt.setInt(1, index);

            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    ImagePOJO ipj = new ImagePOJO();
                    ipj.setImage_id(rs.getInt("image_id"));
                    ipj.setArticle_id(rs.getInt("article_id"));
                    ipj.setSource(rs.getString("image_source"));
                    allImages.add(ipj);
                }
            }
        }

        return allImages;
    }

    //Deletes a single image from the database

    public void deleteSingleImage(String imageID) throws SQLException{

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_images WHERE image_id = ?")) {
            smt.setString(1, imageID);
            smt.execute();
        }
    }

    /* METHODS USED BY THE ADMINISTRATIVE INTERFACE*/


    //Changes the article visibility from TRUE to FALSE or vice versa; used by the admin to show and hide articles

    public void changeArticleVisibility(String index) throws SQLException {

        int visibility;

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT article_visibility FROM project_article WHERE article_id = ?")) {
            smt.setString(1, index);
            try (ResultSet rs = smt.executeQuery()) {
                rs.next();
                visibility = rs.getInt(1);
            }
        }

        if (visibility == 0) {
            try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article SET article_visibility = TRUE WHERE article_id = ?")) {
                smt.setString(1, index);
                smt.executeUpdate();
            }
        } else if (visibility == 1) {
            try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article SET article_visibility = FALSE WHERE article_id = ?")) {
                smt.setString(1, index);
                smt.executeUpdate();
            }

        }
    }

    //Changes the comments visibility from TRUE to FALSE or vice versa; used by the admin to show and hide single comments

    public void changeCommentVisibility(String index) throws SQLException {

        int visibility;

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT comment_visibility FROM project_article_comment WHERE comment_id = ?")) {
            smt.setString(1, index);
            try (ResultSet rs = smt.executeQuery()) {
                rs.next();
                visibility = rs.getInt(1);
            }
        }

        if (visibility == 0) {
            try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article_comment SET comment_visibility = TRUE WHERE comment_id = ?")) {
                smt.setString(1, index);
                smt.executeUpdate();
            }
        } else if (visibility == 1) {
            try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article_comment SET comment_visibility = FALSE WHERE comment_id = ?")) {
                smt.setString(1, index);
                smt.executeUpdate();
            }

        }
    }

    //Returns a list of all articles, regardless of whether article_visibility is set to TRUE of FALSE; used in the admin interface

    public List<ArticlePOJO> loadAllArticlesAdmin() throws SQLException {

        List<ArticlePOJO> articles = new ArrayList<>();
        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article")) {
            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    ArticlePOJO article = loadSingleArticle(rs);
                    articles.add(article);
                }
            }
        }
        return articles;
    }


    //Returns a list of all comments, regardless of whether comment_visibility is set to TRUE of FALSE; used in the admin interface

    public List<CommentsPOJO> getCommentsByArticleAdmin(String articleID) throws SQLException {

        List<CommentsPOJO> allComments = new ArrayList<>();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT comment_id, user_id, article_comment, comment_visibility FROM project_article_comment WHERE article_id = ?")) {
            smt.setString(1, articleID);

            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    CommentsPOJO cpj = new CommentsPOJO();
                    cpj.setCommentID(rs.getInt("comment_id"));
                    cpj.setUserID(rs.getInt("user_id"));
                    cpj.setArticleID(Integer.parseInt(articleID));
                    cpj.setComments(rs.getString("article_comment"));
                    cpj.setCommentsVisibility(rs.getBoolean("comment_visibility"));
                    allComments.add(cpj);
                }
            }
        }

        return allComments;
    }


    //Returns the user's name for each article

    public UserPOJO getUserName(String userID) throws SQLException {
        UserPOJO upj = new UserPOJO();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT user_username, user_firstname, user_lastname FROM project_user JOIN project_article a ON project_user.user_id = a.author_id WHERE a.author_id = ?")) {
            smt.setString(1, userID);
            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    upj.setUsername(rs.getString("user_username"));
                    upj.setFirstName(rs.getString("user_firstname"));
                    upj.setLastName(rs.getString("user_lastname"));
                }
            }
        }
        return upj;
    }

    @Override
    public void close() throws Exception {
        this.conn.close();
    }


}
