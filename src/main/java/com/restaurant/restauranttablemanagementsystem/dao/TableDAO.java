package com.restaurant.restauranttablemanagementsystem.dao;


import com.restaurant.restauranttablemanagementsystem.model.Table;
import com.restaurant.restauranttablemanagementsystem.util.DatabaseConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class TableDAO {

    @Autowired
    private DatabaseConnection dbConnection;

    public boolean addTable(int tableNumber, int seatingCapacity, String location,
                            double pricePerHour, boolean weatherProtected) throws SQLException {
        String sql = "INSERT INTO tables (table_number, seating_capacity, location, is_available, price_per_hour, weather_protected) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tableNumber);
            pstmt.setInt(2, seatingCapacity);
            pstmt.setString(3, location);
            pstmt.setBoolean(4, true);
            pstmt.setDouble(5, pricePerHour);
            pstmt.setBoolean(6, weatherProtected);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public List<Table> getAllTables() throws SQLException {
        List<Table> tables = new ArrayList<>();
        String sql = "SELECT * FROM tables ORDER BY table_number";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                tables.add(extractTable(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return tables;
    }

    public List<Table> getAvailableTables() throws SQLException {
        List<Table> tables = new ArrayList<>();
        String sql = "SELECT * FROM tables WHERE is_available = TRUE ORDER BY seating_capacity";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                tables.add(extractTable(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return tables;
    }

    public Table getTableById(int id) throws SQLException {
        String sql = "SELECT * FROM tables WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractTable(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }

    public boolean updateTable(int id, int seatingCapacity, String location,
                               double pricePerHour, boolean isAvailable) throws SQLException {
        String sql = "UPDATE tables SET seating_capacity = ?, location = ?, price_per_hour = ?, is_available = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, seatingCapacity);
            pstmt.setString(2, location);
            pstmt.setDouble(3, pricePerHour);
            pstmt.setBoolean(4, isAvailable);
            pstmt.setInt(5, id);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public boolean deleteTable(int id) throws SQLException {
        String sql = "DELETE FROM tables WHERE id = ?";

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


    public List<Table> searchTables(Integer capacity, String location, LocalDate date, LocalTime time) throws SQLException {
        List<Table> tables = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM tables WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (capacity != null && capacity > 0) {
            sql.append(" AND seating_capacity >= ?");
            params.add(capacity);
        }

        if (location != null && !location.isEmpty()) {
            sql.append(" AND location = ?");
            params.add(location);
        }

        sql.append(" ORDER BY table_number");

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
                Table table = extractTable(rs);

                if (date != null && time != null) {
                    if (isTableAvailable(table.getId(), date, time)) {
                        tables.add(table);
                    }
                } else {
                    tables.add(table);
                }
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return tables;
    }

    public List<Table> searchAvailableTables(int capacity, LocalDate date, LocalTime time) throws SQLException {
        List<Table> availableTables = new ArrayList<>();
        String sql = "SELECT * FROM tables WHERE seating_capacity >= ? AND is_available = TRUE ORDER BY seating_capacity";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, capacity);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Table table = extractTable(rs);
                if (isTableAvailable(table.getId(), date, time)) {
                    availableTables.add(table);
                }
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return availableTables;
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

    private Table extractTable(ResultSet rs) throws SQLException {
        Table table = new Table();
        table.setId(rs.getInt("id"));
        table.setTableNumber(rs.getInt("table_number"));
        table.setSeatingCapacity(rs.getInt("seating_capacity"));
        table.setLocation(rs.getString("location"));
        table.setAvailable(rs.getBoolean("is_available"));
        table.setPricePerHour(rs.getDouble("price_per_hour"));
        return table;
    }
}