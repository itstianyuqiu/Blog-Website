package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import POJO.ArticlePOJO;
import com.zaxxer.hikari.HikariDataSource;

public class ArticleDAO {

    private final Connection conn;

    public ArticleDAO() throws SQLException {
        this.conn = HikariConnectionPool.getConnection();
    }

    public void postEntries() throws SQLException {
        try (PreparedStatement smt = this.conn.prepareStatement("INSERT INTO project_article (article_content) VALUES ('TestDAOCOntent');")) {
            smt.execute();
        }
    }

    public List<ArticlePOJO> loadAllArticles() throws SQLException {

        List<ArticlePOJO> articles = new ArrayList<>();
        try (PreparedStatement smt = this.conn.prepareStatement("SELECT * FROM project_article")) {
            try (ResultSet rs = smt.executeQuery()) {
                while (rs.next()) {
                    ArticlePOJO article = new ArticlePOJO();
                    article.setUser_id(rs.getInt(1));
                    article.setContent(rs.getString(2));
                    articles.add(article);
                }
            }
        }
        return articles;
    }
}

