package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import POJO.ArticlePOJO;
import POJO.CommentsPOJO;
import POJO.UserPOJO;
import com.zaxxer.hikari.HikariDataSource;

public class ArticleDAO implements AutoCloseable {

    private final Connection conn;

    public ArticleDAO() throws SQLException {
        this.conn = HikariConnectionPool.getConnection();
    }


    public List<ArticlePOJO> loadAllArticles() throws SQLException {

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

    public List<ArticlePOJO> loadUserArticles(String userID) throws SQLException {
        List<ArticlePOJO> articles = new ArrayList<>();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article WHERE author_id = ?")){

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

    public ArticlePOJO loadSingleArticle(ResultSet rs){

        ArticlePOJO article = new ArticlePOJO();

        try {
            article.setArticle_id(rs.getInt(1));
            article.setTitle(rs.getString(2));
            article.setContent(rs.getString(3));

        }
        catch (SQLException e){
            System.out.println(e.getMessage());
        }

        return article;
    }

    public void addNewArticle(ArticlePOJO apj, UserPOJO upj) throws SQLException{

        int userID = upj.getUser_id();
        String heading = apj.getTitle();
        String content = apj.getContent();


        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article (article_title, article_content, author_id) VALUES (?, ?, ?)")) {
            smt.setString(1,heading);
            smt.setString(2,content);
            smt.setInt(3, userID);
            smt.executeUpdate();
        }

    }

    public void deleteArticle(String index) throws SQLException{

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_user_article WHERE article_id = ?")) {
            smt.setString(1,index);
            smt.executeUpdate();
        }

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_article WHERE article_id = ?")) {
            smt.setString(1,index);
            smt.executeUpdate();
        }
    }

    public void updateArticle (ArticlePOJO article) throws SQLException{

        int articleID = article.getArticle_id();
        String title = article.getTitle();
        String content = article.getContent();

        try (PreparedStatement smt = this.conn.prepareStatement("UPDATE project_article SET article_title = ?, article_content = ? WHERE article_id = ?")){
            smt.setString(1, title);
            smt.setString(2, content);
            smt.setInt(3, articleID);
            smt.executeUpdate();
        }

    }

    public List<CommentsPOJO> getCommentsByArticle (String articleID) throws SQLException {

        List<CommentsPOJO> allComments = new ArrayList<>();

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT comment_id, user_id, article_comment FROM project_user_article WHERE article_id = ?")){
            smt.setString(1, articleID);

            try (ResultSet rs = smt.executeQuery()){
                while (rs.next()){
                    CommentsPOJO cpj = new CommentsPOJO();
                    cpj.setCommentID(rs.getInt("comment_id"));
                    cpj.setUserID(rs.getInt("user_id"));
                    cpj.setArticleID(Integer.parseInt(articleID));
                    cpj.setComments(rs.getString("article_comment"));
                    allComments.add(cpj);
                }
            }
        }

        return allComments;
    }

    public void addNewComment(CommentsPOJO cpj) throws SQLException{

        int userID = cpj.getUserID();
        int articleID = cpj.getArticleID();
        String content = cpj.getComments();

        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_user_article (user_id, article_id, article_comment) VALUES (?, ?, ?)")) {
            smt.setInt(1,userID);
            smt.setInt(2,articleID);
            smt.setString(3, content);
            smt.executeUpdate();
        }
    }

    public void deleteComment (String index) throws SQLException{

        try (PreparedStatement smt = this.conn.prepareStatement("DELETE FROM project_user_article WHERE comment_id = ?")) {
            smt.setString(1,index);
            smt.executeUpdate();
        }

    }

    public int getIDOfLastArticle() throws SQLException{

        int article_ID = 0;

        try (PreparedStatement smt = this.conn.prepareStatement("SELECT article_id FROM project_article ORDER BY article_id DESC")) {

            try (ResultSet rs = smt.executeQuery()){
                rs.next();
                article_ID = rs.getInt(1);
                }
            }

        return article_ID;
    }

    @Override
    public void close() throws Exception {
        this.conn.close();
    }
}
