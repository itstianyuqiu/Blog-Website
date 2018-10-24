package DAO;

import POJO.AdminPOJO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO implements AutoCloseable {
    private Connection conn;


    public AdminDAO() throws SQLException {
        this.conn = HikariConnectionPool.getConnection();
    }

    public AdminPOJO queryAdminbyName(String username) throws SQLException {
        System.out.println("Admindao=====" + username);
        AdminPOJO adminPOJO = new AdminPOJO();
        try (PreparedStatement ps = this.conn.prepareStatement(
                "SELECT * FROM project_admin WHERE admin_username = ?;")) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    adminPOJO = adminFromResultSet(rs);
                }
            }
        }
        System.out.println(adminPOJO.toString()+"=================admindao");
        return adminPOJO;
    }

    public List<AdminPOJO> queryALLAdmin() throws SQLException {
        List<AdminPOJO> adminPOJOS = new ArrayList<>();
        try (PreparedStatement ps = this.conn.prepareStatement(
                "SELECT * FROM project_admin;")) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    adminPOJOS.add(adminFromResultSet(rs));
                }
            }
        }
        return adminPOJOS;
    }

    public AdminPOJO queryAdminbyID(int id) throws SQLException {
        AdminPOJO adminPOJO = new AdminPOJO();
        try (PreparedStatement ps = this.conn.prepareStatement(
                "SELECT * FROM project_admin WHERE admin_id = ?;")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    adminPOJO = adminFromResultSet(rs);
                }
            }
        }
        return adminPOJO;

    }

    public void addAdmin(AdminPOJO adminPojo) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "INSERT  INTO project_admin (admin_name, admin_username, admin_password, admin_created_date, admin_authority) " +
                        " VALUES (?, ?, ?, ?, DATE ?, ?);")) {
            ps.setString(1, adminPojo.getAdminName());
            ps.setString(2, adminPojo.getAdminUsername());
            ps.setString(3, adminPojo.getPassword());
            ps.setString(4, adminPojo.getCreatedDate());
            ps.setInt(5, adminPojo.getAuthority());
            ps.executeUpdate();
        }

    }

    public void deleteAdmin(int id) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "DELETE FROM project_admin WHERE admin_id = ?;")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public void updateAdmin(AdminPOJO adminPojo) throws SQLException {
        try (PreparedStatement ps = this.conn.prepareStatement(
                "UPDATE project_admin SET admin_name=?,admin_username=?," +
                        "admin_password = ?,admin_created_date =?, admin_authority=? WHERE admin_id =?")) {
            ps.setString(1, adminPojo.getAdminName());
            ps.setString(2, adminPojo.getAdminUsername());
            ps.setString(3, adminPojo.getPassword());
            ps.setString(4, adminPojo.getCreatedDate());
            ps.setInt(5, adminPojo.getAuthority());
            ps.setInt(6, adminPojo.getAdmin_id());
            ps.executeUpdate();
        }
    }


    private AdminPOJO adminFromResultSet(ResultSet rs) throws SQLException {
        return new AdminPOJO(rs.getInt(1), rs.getString(2), rs.getString(3),
                rs.getString(4), rs.getString(5), rs.getInt(6));
    }

    public void close() throws Exception {
        this.conn.close();
    }


}

