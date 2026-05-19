package com.DAO;

import com.model.Subscriber;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubscriberDAO {

    public List<Subscriber> getAllSubscribers() {
        List<Subscriber> subscribers = new ArrayList<>();
        String sql = "SELECT subscriber_id, email, subscribed_at, status FROM subscriber ORDER BY subscribed_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                subscribers.add(
                        new Subscriber(
                                rs.getInt("subscriber_id"),
                                rs.getString("email"),
                                rs.getTimestamp("subscribed_at"),
                                rs.getString("status")
                        )
                );
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

    // FIXED: Now accepts customerId
    public boolean addSubscriber(String email, Integer customerId) {
        String sql = "INSERT INTO subscriber (email, subscribed_at, status, customer_id) VALUES (?, NOW(), 'active', ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            if (customerId != null) {
                stmt.setInt(2, customerId);
            } else {
                stmt.setNull(2, java.sql.Types.INTEGER);
            }

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error saving subscriber: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // FIXED: Now accepts customerId
    public boolean reactivateSubscriber(String email, Integer customerId) {
        String sql = "UPDATE subscriber SET status = 'active', subscribed_at = NOW(), customer_id = ? WHERE email = ? AND status = 'inactive'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (customerId != null) {
                ps.setInt(1, customerId);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, email.trim().toLowerCase());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean emailExistsActive(String email) {
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

    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM subscriber WHERE email = ?";
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