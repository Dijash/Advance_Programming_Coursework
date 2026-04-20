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
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public List<Notification> getRecentNotifications() {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT notification_type, notification_description, notification_date FROM notification ORDER BY notification_date DESC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new Notification(
                        rs.getString("notification_type"),
                        rs.getString("notification_description"),
                        rs.getTimestamp("notification_date")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}