package com.DAO;

import com.model.Notification;
import com.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    public int getTotalNotificationCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM notification";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Notification> getRecentNotifications() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT notification_id, notification_type, notification_description, notification_date FROM notification ORDER BY notification_date DESC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                list.add(new Notification(
                        resultSet.getInt("notification_id"),
                        resultSet.getString("notification_type"),
                        resultSet.getString("notification_description"),
                        resultSet.getTimestamp("notification_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Notification> getAllNotifications() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notification ORDER BY notification_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                list.add(new Notification(
                        resultSet.getInt("notification_id"),
                        resultSet.getString("notification_type"),
                        resultSet.getString("notification_description"),
                        resultSet.getTimestamp("notification_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean sendBroadcast(String type, String description) {
        String sql = "INSERT INTO notification (notification_type, notification_description, notification_date) VALUES (?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, type);
            statement.setString(2, description);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteNotification(int id) {
        String sql = "DELETE FROM notification WHERE notification_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, id);
            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}