package com.DAO;

import com.model.Subscriber;
import com.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubscriberDAO {

    public List<Subscriber> getAllSubscribers() {
        List<Subscriber> subscribers = new ArrayList<>();
        String sql = "SELECT subscriber_id, email, subscribed_at, status " +
                "FROM subscriber " +
                "WHERE status = 'active' " +
                "ORDER BY subscribed_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                subscribers.add(new Subscriber(
                        rs.getInt("subscriber_id"),
                        rs.getString("email"),
                        rs.getTimestamp("subscribed_at"),
                        rs.getString("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subscribers;
    }

    public boolean deleteSubscriber(int subscriberId) {
        String sql = "UPDATE subscriber SET status = 'inactive' WHERE subscriber_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subscriberId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addSubscriber(String email) {
        boolean isAdded = false;

        String sql = "INSERT INTO subscriber (email, subscribed_at, status) VALUES (?, NOW(), 'active')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isAdded = true;
            }

        } catch (SQLException e) {
            System.out.println("Error saving subscriber: " + e.getMessage());
            e.printStackTrace();
        }

        return isAdded;
    }

    // Checks only active subscribers — allows a previously removed email to re-subscribe
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM subscriber WHERE email = ? AND status = 'active'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
