package com.restaurant.restauranttablemanagementsystem.dao;


import com.restaurant.restauranttablemanagementsystem.model.Reservation;
import com.restaurant.restauranttablemanagementsystem.util.DatabaseConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ReservationDAO {

    @Autowired
    private DatabaseConnection dbConnection;


    public List<Reservation> getReservationsByCustomerId(int customerId) throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, t.table_number FROM reservations r " +
                "LEFT JOIN tables t ON r.table_id = t.id " +
                "WHERE r.customer_id = ? ORDER BY r.reservation_date DESC, r.reservation_time DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                reservations.add(extractReservation(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reservations;
    }

    public Reservation getReservationById(int id) throws SQLException {
        String sql = "SELECT r.*, t.table_number FROM reservations r " +
                "LEFT JOIN tables t ON r.table_id = t.id WHERE r.id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractReservation(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }

    public boolean updateReservationStatus(int reservationId, String status) throws SQLException {
        String sql = "UPDATE reservations SET status = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, reservationId);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public boolean cancelReservation(int reservationId) throws SQLException {
        String sql = "DELETE FROM reservations WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reservationId);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public boolean isTableAvailable(int tableId, LocalDate date, LocalTime time) throws SQLException {
        String sql = "SELECT COUNT(*) FROM reservations WHERE table_id = ? AND reservation_date = ? AND reservation_time = ? AND status != 'CANCELLED'";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tableId);
            pstmt.setDate(2, Date.valueOf(date));
            pstmt.setTime(3, Time.valueOf(time));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
            return true;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }


    public List<Reservation> getAllReservationsWithDetails() throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, c.name as customer_name, t.table_number " +
                "FROM reservations r " +
                "JOIN customers c ON r.customer_id = c.id " +
                "LEFT JOIN tables t ON r.table_id = t.id " +
                "ORDER BY r.reservation_date DESC, r.reservation_time DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Reservation r = extractReservation(rs);
                r.setCustomerName(rs.getString("customer_name"));
                reservations.add(r);
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reservations;
    }

    public List<Reservation> searchReservations(String date, String customerName, Integer tableId) throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT r.*, c.name as customer_name, t.table_number FROM reservations r " +
                        "JOIN customers c ON r.customer_id = c.id " +
                        "LEFT JOIN tables t ON r.table_id = t.id WHERE 1=1"
        );

        List<Object> params = new ArrayList<>();

        if (date != null && !date.isEmpty()) {
            sql.append(" AND r.reservation_date = ?");
            params.add(Date.valueOf(date));
        }

        if (customerName != null && !customerName.isEmpty()) {
            sql.append(" AND c.name LIKE ?");
            params.add("%" + customerName + "%");
        }

        if (tableId != null && tableId > 0) {
            sql.append(" AND r.table_id = ?");
            params.add(tableId);
        }

        sql.append(" ORDER BY r.reservation_date DESC, r.reservation_time DESC");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Reservation r = extractReservation(rs);
                r.setCustomerName(rs.getString("customer_name"));
                reservations.add(r);
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reservations;
    }

    public boolean updateReservation(int id, LocalDate date, LocalTime time, int partySize, String specialRequests) throws SQLException {
        String sql = "UPDATE reservations SET reservation_date = ?, reservation_time = ?, party_size = ?, special_requests = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, Date.valueOf(date));
            pstmt.setTime(2, Time.valueOf(time));
            pstmt.setInt(3, partySize);
            pstmt.setString(4, specialRequests);
            pstmt.setInt(5, id);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    private Reservation extractReservation(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setId(rs.getInt("id"));
        reservation.setCustomerId(rs.getInt("customer_id"));
        reservation.setTableId(rs.getInt("table_id"));
        reservation.setReservationDate(rs.getDate("reservation_date").toLocalDate());
        reservation.setReservationTime(rs.getTime("reservation_time").toLocalTime());
        reservation.setPartySize(rs.getInt("party_size"));
        reservation.setSpecialRequests(rs.getString("special_requests"));
        reservation.setStatus(rs.getString("status"));

        try {
            reservation.setTableNumber(rs.getInt("table_number"));
        } catch (SQLException e) {
        }

        Date createdAt = rs.getDate("created_at");
        if (createdAt != null) {
            reservation.setCreatedAt(createdAt.toLocalDate());
        }

        return reservation;
    }

    public List<Reservation> getCompletedReservationsByCustomerId(int customerId) throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, t.table_number FROM reservations r " +
                "LEFT JOIN tables t ON r.table_id = t.id " +
                "WHERE r.customer_id = ? AND r.status = 'COMPLETED' " +
                "ORDER BY r.reservation_date DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                reservations.add(extractReservation(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reservations;
    }

    public List<Reservation> getPendingCompletedReservations() throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, t.table_number FROM reservations r " +
                "LEFT JOIN tables t ON r.table_id = t.id " +
                "WHERE r.status = 'CONFIRMED' AND r.reservation_date < CURDATE() " +
                "ORDER BY r.reservation_date";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                reservations.add(extractReservation(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return reservations;
    }
}