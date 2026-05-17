
package com.restaurant.restauranttablemanagementsystem.dao;

import com.restaurant.restauranttablemanagementsystem.model.Admin;
import com.restaurant.restauranttablemanagementsystem.util.DatabaseConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class AdminDAO {

    @Autowired
    private DatabaseConnection dbConnection;

    public boolean createAdmin(Admin admin) throws SQLException {
        String sql = "INSERT INTO admins (username, email, password, full_name, role, is_active) VALUES (?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, admin.getUsername());
            pstmt.setString(2, admin.getEmail());
            pstmt.setString(3, admin.getPassword());
            pstmt.setString(4, admin.getFullName());
            pstmt.setString(5, admin.getRole());
            pstmt.setBoolean(6, admin.isActive());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    admin.setId(rs.getInt(1));
                }
                return true;
            }
            return false;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public Admin getAdminByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM admins WHERE email = ? AND is_active = TRUE";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractAdmin(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }

    public Admin getAdminByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM admins WHERE username = ? AND is_active = TRUE";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractAdmin(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }

    public Admin getAdminById(int id) throws SQLException {
        String sql = "SELECT * FROM admins WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractAdmin(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }


    public List<Admin> getAllAdmins() throws SQLException {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT * FROM admins ORDER BY created_at DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                admins.add(extractAdmin(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return admins;
    }


    public boolean updateLastLogin(int adminId) throws SQLException {
        String sql = "UPDATE admins SET last_login = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(2, adminId);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }


    public boolean updateAdmin(int id, String fullName, String role, boolean isActive) throws SQLException {
        String sql = "UPDATE admins SET full_name = ?, role = ?, is_active = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fullName);
            pstmt.setString(2, role);
            pstmt.setBoolean(3, isActive);
            pstmt.setInt(4, id);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }


    public boolean changePassword(int id, String newPassword) throws SQLException {
        String sql = "UPDATE admins SET password = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, id);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }


    public boolean deleteAdmin(int id) throws SQLException {
        String sql = "UPDATE admins SET is_active = FALSE WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }


    public Admin authenticate(String email, String password) throws SQLException {
        String sql = "SELECT * FROM admins WHERE email = ? AND password = ? AND is_active = TRUE";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                Admin admin = extractAdmin(rs);
                updateLastLogin(admin.getId());
                return admin;
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }

    private Admin extractAdmin(ResultSet rs) throws SQLException {
        Admin admin = new Admin();
        admin.setId(rs.getInt("id"));
        admin.setUsername(rs.getString("username"));
        admin.setEmail(rs.getString("email"));
        admin.setPassword(rs.getString("password"));
        admin.setFullName(rs.getString("full_name"));
        admin.setRole(rs.getString("role"));
        admin.setActive(rs.getBoolean("is_active"));

        Timestamp lastLogin = rs.getTimestamp("last_login");
        if (lastLogin != null) {
            admin.setLastLogin(lastLogin.toLocalDateTime());
        }

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            admin.setCreatedAt(createdAt.toLocalDateTime());
        }

        return admin;
    }
}