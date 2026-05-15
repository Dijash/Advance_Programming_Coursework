package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.Customer;
import com.util.DBConnection;
import com.util.PasswordUtil;

/*
 * DAO class responsible for
 * User authentication and profile operations.
 *
 * Features:
 * - User login validation
 * - Fetch customer by email
 * - Update profile
 * - Check email existence
 * - Reset/update password
 */
public class UserDAO {

    /*
     * Validates user login credentials.
     *
     * Returns:
     *      "success"         → valid credentials
     *      "wrong_password"  → email exists but password mismatch
     *      "user_not_found"  → no account found for email
     *      "error"           → unexpected failure
     */
    public String checkLogin(String email, String password) {

        String result = "error";

        try {

            /*
             * Establish database connection.
             */
            Connection con = DBConnection.getConnection();

            /*
             * SQL: Find user by email.
             */
            String sql =
                    "SELECT * FROM customer WHERE customer_email = ?";

            PreparedStatement statement =
                    con.prepareStatement(sql);

            statement.setString(1, email);

            ResultSet rs =
                    statement.executeQuery();

            /*
             * If user exists, validate password.
             */
            if (rs.next()) {

                String storedPassword =
                        rs.getString("password");

                /*
                 * Compare hashed password.
                 */
                if (PasswordUtil.checkPassword(password, storedPassword)) {
                    result = "success";
                } else {
                    result = "wrong_password";
                }

            } else {

                /*
                 * No user found for email.
                 */
                result = "user_not_found";
            }

        } catch (Exception e) {

            /*
             * Handle unexpected errors.
             */
            e.printStackTrace();
        }

        return result;
    }

    /*
     * Retrieves full customer details by email.
     *
     * Returns:
     *      Customer object if found, otherwise null
     */
    public Customer getCustomerByEmail(String email) {

        /*
         * SQL: Fetch customer by email.
         */
        String sql =
                "SELECT * FROM customer WHERE customer_email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    /*
                     * Map database row to Customer object.
                     */
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
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return null;
    }

    /*
     * Updates customer profile information.
     *
     * Returns:
     *      boolean - true if update successful
     */
    public boolean updateCustomerProfile(
            int id,
            String user,
            String phone,
            String license,
            String addr,
            String pass,
            String image
    ) {

        /*
         * SQL: Update customer profile data.
         */
        String sql =
                "UPDATE customer SET "
                        + "customer_username=?, "
                        + "customer_phoneNo=?, "
                        + "customer_license=?, "
                        + "customer_address=?, "
                        + "password=?, "
                        + "customer_image=? "
                        + "WHERE customer_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, user);
            stmt.setString(2, phone);
            stmt.setString(3, license);
            stmt.setString(4, addr);
            stmt.setString(5, pass);
            stmt.setString(6, image);
            stmt.setInt(7, id);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Checks whether an email exists in database.
     *
     * Returns:
     *      boolean - true if email exists
     */
    public boolean checkEmailExists(String email) {

        /*
         * SQL: Check email existence.
         */
        String sql =
                "SELECT customer_email "
                        + "FROM customer "
                        + "WHERE customer_email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {

                return rs.next();
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return false;
    }

    /*
     * Updates password using email.
     *
     * Returns:
     *      boolean - true if update successful
     */
    public boolean updatePasswordByEmail(String email, String newPassword) {

        /*
         * SQL: Update password by email.
         */
        String sql =
                "UPDATE customer SET password = ? "
                        + "WHERE customer_email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword);
            stmt.setString(2, email);

            int rowsUpdated =
                    stmt.executeUpdate();

            return rowsUpdated > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }
}