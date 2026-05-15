package com.DAO;

import com.model.Subscriber;
import com.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubscriberDAO {

    /** Returns ALL subscribers (active + inactive) for admin reporting. */
    public List<Subscriber> getAllSubscribers() {
        List<Subscriber> subscribers = new ArrayList<>();
        String sql = "SELECT subscriber_id, email, subscribed_at, status " +
                "FROM subscriber " +
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

    /** Sets a subscriber's status to 'inactive' by ID. */
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

    /** Sets a subscriber's status to 'inactive' by email. */
    public boolean unsubscribeByEmail(String email) {
        String sql = "UPDATE subscriber SET status = 'inactive' WHERE email = ? AND status = 'active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Inserts a new active subscriber row. */
    public boolean addSubscriber(String email) {
        String sql = "INSERT INTO subscriber (email, subscribed_at, status) VALUES (?, NOW(), 'active')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error saving subscriber: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /** Re-activates a previously inactive subscriber row. */
    public boolean reactivateSubscriber(String email) {
        String sql = "UPDATE subscriber SET status = 'active', subscribed_at = NOW() WHERE email = ? AND status = 'inactive'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Returns true if the email has an ACTIVE subscription. */
    public boolean emailExistsActive(String email) {
        String sql = "SELECT COUNT(*) FROM subscriber WHERE email = ? AND status = 'active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Returns true if the email exists at all (active or inactive). */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM subscriber WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
