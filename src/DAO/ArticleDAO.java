package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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

}
