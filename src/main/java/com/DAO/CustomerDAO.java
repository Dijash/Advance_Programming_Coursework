package com.DAO;

import com.model.Customer;
import com.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer ORDER BY customer_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                customers.add(extractCustomerFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next())
                    return extractCustomerFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteCustomer(int customerId) {
        boolean isDeleted = false;
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try {
                String deletePayments = "DELETE FROM payment WHERE booking_id IN (SELECT booking_id FROM booking WHERE customer_id = ?)";
                try (PreparedStatement ps1 = conn.prepareStatement(deletePayments)) {
                    ps1.setInt(1, customerId);
                    ps1.executeUpdate();
                }
                String deleteBookings = "DELETE FROM booking WHERE customer_id = ?";
                try (PreparedStatement ps2 = conn.prepareStatement(deleteBookings)) {
                    ps2.setInt(1, customerId);
                    ps2.executeUpdate();
                }
                String deleteReviews = "DELETE FROM review WHERE customer_id = ?";
                try (PreparedStatement ps3 = conn.prepareStatement(deleteReviews)) {
                    ps3.setInt(1, customerId);
                    ps3.executeUpdate();
                }
                String deleteCustomer = "DELETE FROM customer WHERE customer_id = ?";
                try (PreparedStatement ps4 = conn.prepareStatement(deleteCustomer)) {
                    ps4.setInt(1, customerId);
                    if (ps4.executeUpdate() > 0) {
                        isDeleted = true;
                    }
                }
                conn.commit();

            } catch (SQLException e) {
                conn.rollback();
                System.out.println("Error deleting customer: " + e.getMessage());
                e.printStackTrace();
            } finally {
                conn.setAutoCommit(true);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted;
    }

    private Customer extractCustomerFromResultSet(ResultSet rs) throws SQLException {
        return new Customer(
                rs.getInt("customer_id"),
                rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getString("gender"),
                rs.getString("customer_email"),
                rs.getString("customer_phoneNo"),
                rs.getString("customer_dob"),
                rs.getString("customer_address"),
                rs.getString("customer_country"),
                rs.getString("customer_license"),
                rs.getString("customer_username"),
                rs.getString("referral_code"),
                rs.getString("password"),
                rs.getString("customer_image"),
                rs.getTimestamp("created_at"));
    }

    public int getTotalCustomerCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM customer";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

}