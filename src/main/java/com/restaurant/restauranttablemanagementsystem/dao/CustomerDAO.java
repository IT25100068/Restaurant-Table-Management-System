package com.restaurant.restauranttablemanagementsystem.dao;



import com.restaurant.restauranttablemanagementsystem.model.Customer;
import com.restaurant.restauranttablemanagementsystem.model.PremiumCustomer;
import com.restaurant.restauranttablemanagementsystem.model.RegularCustomer;
import com.restaurant.restauranttablemanagementsystem.util.DatabaseConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CustomerDAO {

    @Autowired
    private DatabaseConnection dbConnection;


    public boolean createCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (name, email, password, phone, address, customer_type, loyalty_points, discount_rate) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, customer.getName());
            pstmt.setString(2, customer.getEmail());
            pstmt.setString(3, customer.getPassword());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getAddress());
            pstmt.setString(6, customer.getCustomerType());
            pstmt.setInt(7, customer.getLoyaltyPoints());

            if (customer instanceof PremiumCustomer) {
                pstmt.setDouble(8, ((PremiumCustomer) customer).getDiscountRate());
            } else {
                pstmt.setDouble(8, 0.0);
            }

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    customer.setId(rs.getInt(1));
                }
                return true;
            }
            return false;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }


    public Customer getCustomerById(int id) throws SQLException {
        String sql = "SELECT * FROM customers WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }


    public Customer getCustomerByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM customers WHERE email = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }


    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                customers.add(extractCustomerFromResultSet(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return customers;
    }


    public boolean updateLoyaltyPoints(int customerId, int points) throws SQLException {
        String sql = "UPDATE customers SET loyalty_points = loyalty_points + ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, points);
            pstmt.setInt(2, customerId);

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public boolean deleteCustomer(int id) throws SQLException {
        String sql = "DELETE FROM customers WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    private Customer extractCustomerFromResultSet(ResultSet rs) throws SQLException {
        String customerType = rs.getString("customer_type");
        Customer customer;

        if ("PREMIUM".equals(customerType)) {
            customer = new PremiumCustomer();
            ((PremiumCustomer) customer).setDiscountRate(rs.getDouble("discount_rate"));
        } else {
            customer = new RegularCustomer();
        }

        customer.setId(rs.getInt("id"));
        customer.setName(rs.getString("name"));
        customer.setEmail(rs.getString("email"));
        customer.setPassword(rs.getString("password"));
        customer.setPhone(rs.getString("phone"));
        customer.setAddress(rs.getString("address"));
        customer.setCustomerType(customerType);
        customer.setLoyaltyPoints(rs.getInt("loyalty_points"));

        Timestamp registrationTimestamp = rs.getTimestamp("registration_date");
        if (registrationTimestamp != null) {
            customer.setRegistrationDate(registrationTimestamp.toString());
        } else {
            customer.setRegistrationDate("N/A");
        }

        return customer;
    }


    public Customer searchCustomerByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM customers WHERE email LIKE ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + email + "%");
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractCustomerFromResultSet(rs);
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }


    public List<Customer> searchCustomersByName(String name) throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE name LIKE ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + name + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                customers.add(extractCustomerFromResultSet(rs));
            }
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
        return customers;
    }

    public Customer getCustomerByIdWithDetails(int id) throws SQLException {
        String sql = "SELECT c.*, " +
                "(SELECT COUNT(*) FROM reservations WHERE customer_id = c.id) as total_reservations, " +
                "(SELECT COUNT(*) FROM reviews WHERE customer_id = c.id) as total_reviews " +
                "FROM customers c WHERE c.id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                Customer customer = extractCustomerFromResultSet(rs);
                return customer;
            }
            return null;
        } finally {
            dbConnection.closeConnection(conn, pstmt, rs);
        }
    }



    public boolean updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE customers SET name = ?, phone = ?, address = ?, customer_type = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customer.getName());
            pstmt.setString(2, customer.getPhone());
            pstmt.setString(3, customer.getAddress());
            pstmt.setString(4, customer.getCustomerType());
            pstmt.setInt(5, customer.getId());

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public boolean upgradeToPremium(PremiumCustomer customer) throws SQLException {
        String sql = "UPDATE customers SET customer_type = 'PREMIUM', discount_rate = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, customer.getDiscountRate());
            pstmt.setInt(2, customer.getId());

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }

    public boolean downgradeToRegular(RegularCustomer customer) throws SQLException {
        String sql = "UPDATE customers SET customer_type = 'REGULAR', discount_rate = 0 WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dbConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customer.getId());

            return pstmt.executeUpdate() > 0;
        } finally {
            dbConnection.closeConnection(conn, pstmt, null);
        }
    }
}