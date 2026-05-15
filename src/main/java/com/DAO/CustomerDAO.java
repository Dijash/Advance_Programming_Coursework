package com.DAO;

import com.model.Customer;
import com.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for
 * Customer-related database operations.
 *
 * Features:
 * - Retrieve all customers
 * - Retrieve customer by ID
 * - Delete customer with related data cleanup
 * - Search customers
 * - Get total customer count
 */
public class CustomerDAO {

    /*
     * Retrieves all customers from the database.
     *
     * Returns:
     *      List<Customer> - all customer records
     */
    public List<Customer> getAllCustomers() {

        List<Customer> customers =
                new ArrayList<>();

        /*
         * SQL: Fetch all customers ordered by latest first.
         */
        String sql =
                "SELECT * FROM customer ORDER BY customer_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            /*
             * Iterate through result set.
             */
            while (rs.next()) {

                customers.add(
                        extractCustomerFromResultSet(rs)
                );
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return customers;
    }

    /*
     * Retrieves a single customer by ID.
     *
     * Returns:
     *      Customer object or null if not found
     */
    public Customer getCustomerById(int id) {

        /*
         * SQL: Fetch customer by ID.
         */
        String sql =
                "SELECT * FROM customer WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return extractCustomerFromResultSet(rs);
                }
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return null;
    }

    /*
     * Deletes a customer and all related data.
     *
     * Uses transaction to maintain data consistency.
     *
     * Returns:
     *      boolean - true if deletion successful
     */
    public boolean deleteCustomer(int customerId) {

        boolean isDeleted = false;

        try (Connection conn = DBConnection.getConnection()) {

            /*
             * Start transaction.
             */
            conn.setAutoCommit(false);

            try {

                /*
                 * Delete payments related to customer's bookings.
                 */
                String deletePayments =
                        "DELETE FROM payment "
                                + "WHERE booking_id IN "
                                + "(SELECT booking_id FROM booking WHERE customer_id = ?)";

                try (PreparedStatement ps1 =
                             conn.prepareStatement(deletePayments)) {

                    ps1.setInt(1, customerId);
                    ps1.executeUpdate();
                }

                /*
                 * Delete bookings.
                 */
                String deleteBookings =
                        "DELETE FROM booking WHERE customer_id = ?";

                try (PreparedStatement ps2 =
                             conn.prepareStatement(deleteBookings)) {

                    ps2.setInt(1, customerId);
                    ps2.executeUpdate();
                }

                /*
                 * Delete reviews.
                 */
                String deleteReviews =
                        "DELETE FROM review WHERE customer_id = ?";

                try (PreparedStatement ps3 =
                             conn.prepareStatement(deleteReviews)) {

                    ps3.setInt(1, customerId);
                    ps3.executeUpdate();
                }

                /*
                 * Delete customer record.
                 */
                String deleteCustomer =
                        "DELETE FROM customer WHERE customer_id = ?";

                try (PreparedStatement ps4 =
                             conn.prepareStatement(deleteCustomer)) {

                    ps4.setInt(1, customerId);

                    if (ps4.executeUpdate() > 0) {
                        isDeleted = true;
                    }
                }

                /*
                 * Commit transaction.
                 */
                conn.commit();

            } catch (SQLException e) {

                /*
                 * Rollback on failure.
                 */
                conn.rollback();

                System.out.println(
                        "Error deleting customer: "
                                + e.getMessage()
                );

                e.printStackTrace();

            } finally {

                /*
                 * Reset auto-commit mode.
                 */
                conn.setAutoCommit(true);
            }

        } catch (SQLException e) {

            /*
             * Handle connection errors.
             */
            e.printStackTrace();
        }

        return isDeleted;
    }

    /*
     * Helper method to map ResultSet to Customer object.
     */
    private Customer extractCustomerFromResultSet(ResultSet rs)
            throws SQLException {

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
                rs.getTimestamp("created_at")
        );
    }

    /*
     * Retrieves total number of customers.
     *
     * Returns:
     *      int - total customer count
     */
    public int getTotalCustomerCount() {

        int count = 0;

        /*
         * SQL: Count all customers.
         */
        String sql =
                "SELECT COUNT(*) FROM customer";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return count;
    }

    /*
     * Searches customers based on keyword.
     *
     * Search fields:
     * - first name
     * - last name
     * - username
     * - email
     * - phone number
     *
     * Returns:
     *      List<Customer> - matching customers
     */
    public List<Customer> searchCustomers(String query) {

        List<Customer> customers =
                new ArrayList<>();

        /*
         * SQL: Search customer records.
         */
        String sql =
                "SELECT * FROM customer WHERE "
                        + "first_name LIKE ? OR "
                        + "last_name LIKE ? OR "
                        + "customer_username LIKE ? OR "
                        + "customer_email LIKE ? OR "
                        + "customer_phoneNo LIKE ? "
                        + "ORDER BY customer_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            /*
             * Create search pattern.
             */
            String searchPattern =
                    "%" + query + "%";

            /*
             * Set search parameters.
             */
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {

                /*
                 * Process search results.
                 */
                while (rs.next()) {

                    customers.add(
                            extractCustomerFromResultSet(rs)
                    );
                }
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return customers;
    }
}