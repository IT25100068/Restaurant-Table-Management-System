package com.restaurant.restauranttablemanagementsystem.dao;

import com.restaurant.restauranttablemanagementsystem.model.Review;
import com.restaurant.restauranttablemanagementsystem.util.DatabaseConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReviewDAO {

    @Autowired
    private DatabaseConnection dbConnection;

    public boolean createReview(Review review) throws SQLException {
        String sql = "INSERT INTO reviews (customer_id, reservation_id, rating, comment) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, review.getCustomerId());
            pstmt.setInt(2, review.getReservationId());
            pstmt.setInt(3, review.getRating());
            pstmt.setString(4, review.getComment());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    review.setId(rs.getInt(1));
                }
                return true;
            }
            return false;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public List<Review> getReviewsByCustomerId(int customerId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.name as customer_name, c.email as customer_email FROM reviews r " +
                "JOIN customers c ON r.customer_id = c.id " +
                "WHERE r.customer_id = ? ORDER BY r.created_at DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                reviews.add(extractReview(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reviews;
    }

    public List<Review> getAllApprovedReviews() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.name as customer_name, c.email as customer_email FROM reviews r " +
                "JOIN customers c ON r.customer_id = c.id " +
                "WHERE r.is_approved = TRUE ORDER BY r.created_at DESC LIMIT 20";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                reviews.add(extractReview(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reviews;
    }

    public boolean hasReviewed(int customerId, int reservationId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM reviews WHERE customer_id = ? AND reservation_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            pstmt.setInt(2, reservationId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }

    public List<Review> getAllReviewsForAdmin() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.name as customer_name, c.email as customer_email FROM reviews r " +
                "JOIN customers c ON r.customer_id = c.id " +
                "ORDER BY r.created_at DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                reviews.add(extractReview(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reviews;
    }

    public List<Review> getPendingReviews() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.name as customer_name, c.email as customer_email FROM reviews r " +
                "JOIN customers c ON r.customer_id = c.id " +
                "WHERE r.is_approved = FALSE ORDER BY r.created_at ASC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                reviews.add(extractReview(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reviews;
    }

    public boolean approveReview(int id) throws SQLException {
        String sql = "UPDATE reviews SET is_approved = TRUE WHERE id = ?";

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

    public boolean rejectReview(int id) throws SQLException {
        String sql = "DELETE FROM reviews WHERE id = ?";

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

    public boolean updateReview(int id, int rating, String comment) throws SQLException {
        String sql = "UPDATE reviews SET rating = ?, comment = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, rating);
            pstmt.setString(2, comment);
            pstmt.setInt(3, id);
            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public boolean deleteReview(int id, int customerId) throws SQLException {
        String sql = "DELETE FROM reviews WHERE id = ? AND customer_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.setInt(2, customerId);
            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public Review getReviewById(int id) throws SQLException {
        String sql = "SELECT r.*, c.name as customer_name FROM reviews r " +
                "JOIN customers c ON r.customer_id = c.id WHERE r.id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractReview(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }

    public Map<String, Object> getRatingStatistics() throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT AVG(rating) as avg_rating, COUNT(*) as total_reviews, " +
                "SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as five_star " +
                "FROM reviews WHERE is_approved = TRUE";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                stats.put("averageRating", rs.getDouble("avg_rating"));
                stats.put("totalReviews", rs.getInt("total_reviews"));
                stats.put("fiveStarCount", rs.getInt("five_star"));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return stats;
    }

    private Review extractReview(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setId(rs.getInt("id"));
        review.setCustomerId(rs.getInt("customer_id"));
        review.setReservationId(rs.getInt("reservation_id"));
        review.setRating(rs.getInt("rating"));
        review.setComment(rs.getString("comment"));
        review.setApproved(rs.getBoolean("is_approved"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            review.setCreatedAt(createdAt.toLocalDateTime().toLocalDate());
        }

        try {
            review.setCustomerName(rs.getString("customer_name"));
            review.setCustomerEmail(rs.getString("customer_email"));
        } catch (SQLException e) {
        }

        return review;
    }

    public List<Integer> getReviewedReservationIds(int customerId) throws SQLException {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT reservation_id FROM reviews WHERE customer_id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ids.add(rs.getInt("reservation_id"));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return ids;
    }
}