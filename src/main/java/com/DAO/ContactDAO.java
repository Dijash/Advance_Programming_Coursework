package com.DAO;

import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

public class ContactDAO {

    public boolean saveContactMessage(Integer customerId, String firstName, String lastName, String email, String subject, String message) {
        // Use EXACT column names from your phpMyAdmin screenshot
        String sql = "INSERT INTO contact_message (customer_id, first_name, last_name, email, subject, message) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (customerId != null && customerId > 0) {
                stmt.setInt(1, customerId);
            } else {
                stmt.setNull(1, Types.INTEGER);
            }

            stmt.setString(2, firstName);
            stmt.setString(3, lastName);
            stmt.setString(4, email);
            stmt.setString(5, subject);
            stmt.setString(6, message);

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            // THIS WILL TELL YOU EXACTLY WHAT IS WRONG IN THE CONSOLE
            System.err.println("--- SQL ERROR IN ContactDAO ---");
            e.printStackTrace();
            return false;
        }
    }
}