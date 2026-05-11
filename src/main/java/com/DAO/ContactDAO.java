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

public class ContactDAO {

    public boolean saveContactMessage(Integer customerId, String firstName, String lastName, String email, String subject, String message) {
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
            e.printStackTrace();
            return false;
        }
    }

    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_message ORDER BY submitted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ContactMessage msg = new ContactMessage();
                msg.setMessageId(rs.getInt("message_id"));
                msg.setCustomerId(rs.getInt("customer_id"));
                msg.setFirstName(rs.getString("first_name"));
                msg.setLastName(rs.getString("last_name"));
                msg.setEmail(rs.getString("email"));
                msg.setSubject(rs.getString("subject"));
                msg.setMessage(rs.getString("message"));
                msg.setSubmittedAt(rs.getTimestamp("submitted_at").toString());

                list.add(msg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}