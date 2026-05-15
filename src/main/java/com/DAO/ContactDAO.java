package com.DAO;

import com.model.ContactMessage; // Ensure you have this model class
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for
 * Contact Message database operations.
 *
 * Features:
 * - Save contact form messages
 * - Retrieve all submitted messages
 */
public class ContactDAO {

    /*
     * Saves a contact message into the database.
     *
     * Supports both:
     * - Logged-in users (with customerId)
     * - Guest users (null customerId)
     *
     * Returns:
     *      boolean - true if insert successful
     */
    public boolean saveContactMessage(Integer customerId,
                                      String firstName,
                                      String lastName,
                                      String email,
                                      String subject,
                                      String message) {

        /*
         * SQL: Insert contact message record.
         */
        String sql =
                "INSERT INTO contact_message "
                        + "(customer_id, first_name, last_name, email, subject, message) "
                        + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            /*
             * Set customer ID if user is logged in,
             * otherwise store NULL.
             */
            if (customerId != null && customerId > 0) {
                stmt.setInt(1, customerId);
            } else {
                stmt.setNull(1, Types.INTEGER);
            }

            /*
             * Set contact form fields.
             */
            stmt.setString(2, firstName);
            stmt.setString(3, lastName);
            stmt.setString(4, email);
            stmt.setString(5, subject);
            stmt.setString(6, message);

            /*
             * Execute insert query.
             */
            int rows = stmt.executeUpdate();

            return rows > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Retrieves all contact messages from database.
     *
     * Returns:
     *      List<ContactMessage> - all messages sorted by newest first
     */
    public List<ContactMessage> getAllMessages() {

        List<ContactMessage> list =
                new ArrayList<>();

        /*
         * SQL: Fetch all contact messages.
         */
        String sql =
                "SELECT * FROM contact_message "
                        + "ORDER BY submitted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            /*
             * Iterate through result set.
             */
            while (rs.next()) {

                /*
                 * Create ContactMessage object.
                 */
                ContactMessage msg =
                        new ContactMessage();

                /*
                 * Set message fields.
                 */
                msg.setMessageId(
                        rs.getInt("message_id")
                );

                msg.setCustomerId(
                        rs.getInt("customer_id")
                );

                msg.setFirstName(
                        rs.getString("first_name")
                );

                msg.setLastName(
                        rs.getString("last_name")
                );

                msg.setEmail(
                        rs.getString("email")
                );

                msg.setSubject(
                        rs.getString("subject")
                );

                msg.setMessage(
                        rs.getString("message")
                );

                msg.setSubmittedAt(
                        rs.getTimestamp("submitted_at")
                                .toString()
                );

                /*
                 * Add message to list.
                 */
                list.add(msg);
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return list;
    }
}