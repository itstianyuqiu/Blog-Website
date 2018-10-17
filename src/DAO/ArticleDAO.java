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

import POJO.ArticlePOJO;
import POJO.CommentsPOJO;
import POJO.ImagePOJO;
import POJO.UserPOJO;
import com.zaxxer.hikari.HikariDataSource;

public class ArticleDAO implements AutoCloseable {

    private final Connection conn;

    public ArticleDAO() throws SQLException {
        this.conn = HikariConnectionPool.getConnection();
    }


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

    public ArticlePOJO loadSingleArticle(ResultSet rs) {

        ArticlePOJO article = new ArticlePOJO();

        try {
            article.setArticle_id(rs.getInt(1));
            article.setTitle(rs.getString(2));
            article.setContent(rs.getString(3));
            article.setAuthor_id(rs.getInt(4));
            article.setArticle_visibility(rs.getBoolean(5));
            article.setArticle_date(rs.getString(6));
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return article;
    }

    public void addNewArticle(ArticlePOJO apj, UserPOJO upj) throws SQLException, ParseException {

        int userID = upj.getUser_id();
        String heading = apj.getTitle();
        String content = apj.getContent();
        String dateString = apj.getArticle_date();

        Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);

        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article (article_title, article_content, author_id, article_visibility, article_date) VALUES (?, ?, ?, TRUE, ?)")) {
            smt.setString(1, heading);
            smt.setString(2, content);
            smt.setInt(3, userID);
            smt.setDate(4, new java.sql.Date(date.getTime()));
            smt.executeUpdate();
        }

    }

    public void deleteArticle(String index) throws SQLException {

        List<CommentsPOJO> allComments = getCommentsByArticle(index);

//        try (PreparedStatement smt = this.conn.prepareStatement("DELETE * FROM project_comment_relationship WHERE article_id = ?")) {
//            smt.setString(1,index);
//            smt.executeUpdate();
//        }

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

    public void deleteCommentsByArticleID (String index) throws SQLException {
        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_comment WHERE article_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }
    }

    public void deleteImagesByArticleID (String index) throws SQLException {

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_images WHERE article_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

    }

    public void deleteRelationshipByParentID(String index) throws SQLException {

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_comment_relationship WHERE parent_id = ?")) {
            smt.setString(1, index);
            smt.executeUpdate();
        }

    }

    public void updateArticle(ArticlePOJO article) throws SQLException {

        int articleID = article.getArticle_id();
        String title = article.getTitle();
        String content = article.getContent();

        try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article SET article_title = ?, article_content = ? WHERE article_id = ?")) {
            smt.setString(1, title);
            smt.setString(2, content);
            smt.setInt(3, articleID);
            smt.executeUpdate();
        }

    }

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

    public void deleteComment(String index) throws SQLException {

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_comment_relationship WHERE parent_id = ?")) {
            smt.setString(1, index);
            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    deleteRelationshipByParentID(rs.getString(1));
                    deleteChildByRelationship(rs.getString(2));
                }
            }
        }

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

    public List<CommentsPOJO> getChildComments(int index) throws SQLException {
        List<CommentsPOJO> allComments = new ArrayList<>();
        ArrayList<Integer> child_index = getChildIndex(index);

        for (Integer i : child_index) {
            CommentsPOJO cpj = getChildInfo(i);
            allComments.add(cpj);
        }

        return allComments;
    }

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

    public void saveImageToDatabase(ImagePOJO ipj) throws SQLException {
        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article_images (article_id, image_source) VALUES (?, ?)")) {

            smt.setInt(1, ipj.getArticle_id());
            smt.setString(2, ipj.getSource());

            smt.execute();
        }
    }

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

    public void deleteSingleImage(String imageID) throws SQLException{

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article_images WHERE image_id = ?")) {
            smt.setString(1, imageID);
            smt.execute();
        }
    }

    @Override
    public void close() throws Exception {
        this.conn.close();
    }

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
}
