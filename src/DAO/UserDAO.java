package DAO;

import POJO.UserPOJO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection conn;

    public UserDAO() throws SQLException {
        this.conn = HikariConnectionPool.getConnection();
    }


//    public void postEntries() throws SQLException {
//        try (PreparedStatement ps = this.conn.prepareStatement("SELECT * FROM project_user;")) {
//            ps.execute();
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//
//                }
//            }
//        }
//    }

    /**
     * show one user's information
     *
     * @param username
     * @return the user that log in
     * @throws SQLException
     */
    public UserPOJO postEntriesByUsername(String username) throws SQLException {
        UserPOJO userPOJO = null;
        try (PreparedStatement ps = this.conn.prepareStatement(
                "SELECT * FROM project_user where user_username = ?;")) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userPOJO = userFromResultSet(rs);
                }
            }
        }
        return userPOJO;
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

    private UserPOJO userFromResultSet(ResultSet rs) throws SQLException {
        return new UserPOJO(rs.getString(2), rs.getString(3), rs.getString(4),
                rs.getString(5), rs.getString(6), rs.getString(7),
                rs.getString(8), rs.getString(9), rs.getString(10));
    }

    /**
     * add the new user
     *
     * @param userPOJO
     * @throws SQLException
     */
    public void addNewUserAccount(UserPOJO userPOJO) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "INSERT INTO project_user (user_firstname, user_lastname, user_gender, user_country, user_dob," +
                        "user_email, user_desciption, user_username, user_password) VALUES (?, ?, ?, ?, DATE ?, ?, ?, ?, ?);")) {
            ps.setString(1, userPOJO.getFirstName());
            ps.setString(2, userPOJO.getLastName());
            ps.setString(3, userPOJO.getGender());
            ps.setString(4, userPOJO.getCountry());
            ps.setString(5, userPOJO.getBirth());
            ps.setString(6, userPOJO.getEmail());
            ps.setString(7, userPOJO.getDescription());
            ps.setString(8, userPOJO.getUsername());
            ps.setString(9, userPOJO.getPassword());
            ps.executeUpdate();
        }

    }

    /**
     * delete user account by username
     *
     * @param username
     * @throws SQLException
     */
    public void deleteUserAccount(String username) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "DELETE FROM project_user WHERE user_username = ?;")) {
            ps.setString(1, username);
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
                        "user_username=?,user_password=? WHERE user_id=?;")) {
            ps.setString(1, userPOJO.getCountry());
            ps.setString(2, userPOJO.getEmail());
            ps.setString(3, userPOJO.getDescription());
            ps.setString(4, userPOJO.getUsername());
            ps.setString(5, userPOJO.getPassword());
            ps.setInt(6, userPOJO.getUser_id());
            ps.executeUpdate();
        }
    }
}