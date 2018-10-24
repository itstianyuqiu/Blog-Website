package DAO;

import POJO.ArticlePOJO;
import POJO.ImagePOJO;
import POJO.JoinQueryDataModel;
import POJO.UserPOJO;
import Utilities.QuaryModal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements AutoCloseable {
    private Connection conn;

    public UserDAO() throws SQLException {
        this.conn = HikariConnectionPool.getConnection();
    }

    /**
     * query all users
     *
     * @return all userPOJO
     * @throws SQLException
     */
    public List<UserPOJO> queryEntries() throws SQLException {
        List<UserPOJO> list = new ArrayList<>();
        try (PreparedStatement ps = this.conn.prepareStatement("SELECT * FROM project_user;")) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(userFromResultSet(rs));
                }
            }
        }
        return list;
    }

    /**
     * show one user's information
     *
     * @param username
     * @return the user that log in
     * @throws SQLException
     */
    public UserPOJO queryEntriesByUsername(String username) throws SQLException {
        UserPOJO userPOJO = null;
        try (PreparedStatement ps = this.conn.prepareStatement(
                "SELECT * FROM project_user WHERE user_username = ?;")) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userPOJO = userFromResultSet(rs);
                }
            }
        }
        return userPOJO;
    }

    public QuaryModal<UserPOJO> queryAllUserByPage(QuaryModal quaryModal) throws SQLException {
        List<UserPOJO> list = new ArrayList<>();
        try (PreparedStatement ps = this.conn.prepareStatement("SELECT * FROM project_user LIMIT ?,?;")) {
            ps.setInt(1, (quaryModal.getPageNO() - 1) * quaryModal.getPageSize());
            ps.setInt(2, quaryModal.getPageSize());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(userFromResultSet(rs));
                }
            }

        }
        quaryModal.setList(list);
        return quaryModal;
    }

    public int queryCount() throws SQLException {
        int count = 0;
        try (PreparedStatement ps = this.conn.prepareStatement("SELECT count(1) FROM project_user;")) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        }
        return count;
    }
//    /**
//     * search user details by keyword
//     *
//     * @param keyword
//     * @return
//     * @throws SQLException
//     */
//    public List<UserPOJO> postEntriesByKeyword(String keyword) throws SQLException {
//        List<UserPOJO> userList = new ArrayList<>();
//        try (PreparedStatement ps = this.conn.prepareStatement(
//                "SELECT * FROM project_user WHERE user_firstname LIKE ? OR user_lastname LIKE ?" +
//                        "                                 OR user_country LIKE ? OR user_dob LIKE ?" +
//                        "                                 OR user_username LIKE ? OR user_password LIKE ?;")) {
//            ps.setString(1, "%" + keyword + "%");
//            ps.setString(2, "%" + keyword + "%");
//            ps.setString(3, "%" + keyword + "%");
//            ps.setString(4, "%" + keyword + "%");
//            ps.setString(5, "%" + keyword + "%");
//            ps.setString(6, "%" + keyword + "%");
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    userList.add(userFromResultSet(rs));
//                }
//            }
//        }
//        return userList;
//    }


    /**
     * add the new user
     *
     * @param userPOJO
     * @throws SQLException
     */
    public void addNewUserAccount(UserPOJO userPOJO) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "INSERT INTO project_user (user_firstname, user_lastname, user_gender, user_country, user_dob," +
                        "user_email, user_desciption, user_username, user_password,user_avatar) VALUES (?, ?, ?, ?, DATE ?, ?, ?, ?, ?,?);")) {
            ps.setString(1, userPOJO.getFirstName());
            ps.setString(2, userPOJO.getLastName());
            ps.setString(3, userPOJO.getGender());
            ps.setString(4, userPOJO.getCountry());
            ps.setString(5, userPOJO.getBirth());
            ps.setString(6, userPOJO.getEmail());
            ps.setString(7, userPOJO.getDescription());
            ps.setString(8, userPOJO.getUsername());
            ps.setString(9, userPOJO.getPassword());
            ps.setString(10, userPOJO.getAvatar());
            ps.executeUpdate();
        }

    }

    public void addUserSecurityKey(String key) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "INSERT INTO group1.project_user (security_key) VALUE (?);")) {
            ps.setString(1, key);
            ps.executeUpdate();
        }
    }

    /**
     * delete user account by username
     *
     * @param id
     * @throws SQLException
     */
    public void deleteUserAccount(int id) throws SQLException {
        try(ArticleDAO newArticleDAO = new ArticleDAO()){
            List<ArticlePOJO> userArticles = newArticleDAO.loadUserArticles(""+id);

            for (ArticlePOJO eachArticle: userArticles){
                newArticleDAO.deleteArticle(""+eachArticle.getArticle_id());
            }
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        try (PreparedStatement ps = this.conn.prepareStatement(
                "DELETE FROM project_user WHERE user_id = ?;")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    /**
     * update the user details when change
     *
     * @param userPOJO
     * @throws SQLException
     */
    public void updateUserAccount(UserPOJO userPOJO) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "UPDATE project_user SET user_country=?,user_email=?,user_desciption=?, " +
                        "user_username=?,user_password=?,user_avatar=? WHERE user_id=?;")) {
            ps.setString(1, userPOJO.getCountry());
            ps.setString(2, userPOJO.getEmail());
            ps.setString(3, userPOJO.getDescription());
            ps.setString(4, userPOJO.getUsername());
            ps.setString(5, userPOJO.getPassword());
            ps.setString(6, userPOJO.getAvatar());
            ps.setInt(7, userPOJO.getUser_id());
            ps.executeUpdate();
        }
    }

    public void updateUserSecurityKey(UserPOJO userPOJO) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "UPDATE project_user SET security_key=? WHERE user_username=?;")) {
            ps.setString(1, userPOJO.getSecurityKey());
            ps.setString(2, userPOJO.getUsername());
            ps.executeUpdate();
        }
    }

    private UserPOJO userFromResultSet(ResultSet rs) throws SQLException {
        return new UserPOJO(rs.getInt(1), rs.getString(2), rs.getString(3),
                rs.getString(4), rs.getString(5), rs.getString(6),
                rs.getString(7), rs.getString(8), rs.getString(9),
                rs.getString(10), rs.getString(11), rs.getString(12));
    }

    @Override
    public void close() throws Exception {
        this.conn.close();
    }

    //added from articleDAO

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

    public UserPOJO queryEntrieBySecurityKey(String securityKey) throws SQLException {
        UserPOJO userPOJO = null;
        try (PreparedStatement ps = this.conn.prepareStatement(
                "SELECT * FROM project_user WHERE security_key = ?;")) {
            ps.setString(1, securityKey);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userPOJO = userFromResultSet(rs);
                }
            }
        }
        return userPOJO;
    }

    /**
     * quary
     *
     * @param text
     * @return
     */
    public List<JoinQueryDataModel> quaryArtAnduser(String[] text, Date date[]) throws SQLException {
        List<JoinQueryDataModel> list = new ArrayList<>();
        String sql = "select ff.user_id," +
                "   ff.user_username," +
                "   ff.article_id," +
                "   ff.article_title," +
                "  ff.article_content," +
                "   ff.article_date," +
                "   ff.article_audio," +
                "   ff.article_video," +
                "   ff.article_YouTube" +
                "   from (select pu.user_id," +
                "   pu.user_username," +
                "   pa.article_id," +
                "   pa.article_title," +
                "  pa.article_content," +
                "   pa.article_date," +
                "   pa.article_audio," +
                "   pa.article_video," +
                "   pa.article_YouTube" +
                "   from project_user as pu" +
                "   inner join project_article as pa on pu.user_id = pa.author_id" +
                "   where pa.article_visibility=1 and pa.article_date between '" + date[0] + "' and '" + date[1] + "' ) as ff" ;
        if (text.length == 0) {

        } else if (text.length == 1) {
            sql += " where ff.article_title like '%" + text[0] +
                    "%' or ff.user_username like '%" + text[0] + "%' ";
        } else {
            sql += " where ff.article_title like '%" + text[0] + "%' or ff.article_title like '%" + text[1] + "%'" +
                    "or ff.user_username like '%" + text[0] + "%' or ff.user_username like '%" + text[1] + "%'";
        }
        sql += "order by ff.article_date desc ;";
        System.out.println(sql);
        System.out.println(text.toString() + "====" + date.toString());
        try (PreparedStatement ps = this.conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(userOrArtFromResultSet(rs));
                }
            }
        }
        return list;
    }


    private JoinQueryDataModel userOrArtFromResultSet(ResultSet rs) throws SQLException {

        UserPOJO up = new UserPOJO();
        up.setUser_id(rs.getInt(1));
        up.setUsername(rs.getString(2));
        ArticlePOJO ap = new ArticlePOJO();
        ap.setArticle_id(rs.getInt(3));
        ap.setTitle(rs.getString(4));
        ap.setContent(rs.getString(5));
        ap.setArticle_date(rs.getString(6));
        ap.setArticle_audio(rs.getString(7));
        ap.setArticle_video(rs.getString(8));
        ap.setArticle_Youtube(rs.getString(9));
        System.out.println("userOrArtFromResultSet===" + ap.toString() + up.toString());
        JoinQueryDataModel jqm = new JoinQueryDataModel();
        jqm.setUp(up);
        jqm.setAp(ap);
        return jqm;
    }

}
