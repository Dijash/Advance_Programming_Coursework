package com.DAO;

import com.model.Notification;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for
 * Notification-related database operations.
 *
 * Features:
 * - Get notification counts
 * - Fetch recent notifications
 * - Fetch all notifications
 * - Send broadcast notifications
 * - Delete notifications
 */
public class NotificationDAO {

    /*
     * Retrieves total number of notifications in system.
     *
     * Returns:
     *      int - total notification count
     */
    public int getTotalNotificationCount() {

        int count = 0;

        /*
         * SQL: Count all notifications.
         */
        String sql =
                "SELECT COUNT(*) FROM notification";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement =
                     conn.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            if (resultSet.next()) {
                count = resultSet.getInt(1);
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
     * Retrieves latest 5 notifications.
     *
     * Returns:
     *      List<Notification> - recent notifications
     */
    public List<Notification> getRecentNotifications() {

        List<Notification> list =
                new ArrayList<>();

        /*
         * SQL: Fetch latest 5 notifications.
         */
        String sql =
                "SELECT notification_id, notification_type, "
                        + "notification_description, notification_date "
                        + "FROM notification "
                        + "ORDER BY notification_date DESC "
                        + "LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement =
                     conn.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            /*
             * Iterate through result set.
             */
            while (resultSet.next()) {

                list.add(
                        new Notification(
                                resultSet.getInt("notification_id"),
                                resultSet.getString("notification_type"),
                                resultSet.getString("notification_description"),
                                resultSet.getTimestamp("notification_date")
                        )
                );
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return list;
    }

    /*
     * Retrieves all notifications from database.
     *
     * Returns:
     *      List<Notification> - all notifications
     */
    public List<Notification> getAllNotifications() {

        List<Notification> list =
                new ArrayList<>();

        /*
         * SQL: Fetch all notifications ordered by latest first.
         */
        String sql =
                "SELECT * FROM notification "
                        + "ORDER BY notification_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement =
                     conn.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                list.add(
                        new Notification(
                                resultSet.getInt("notification_id"),
                                resultSet.getString("notification_type"),
                                resultSet.getString("notification_description"),
                                resultSet.getTimestamp("notification_date")
                        )
                );
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return list;
    }

    /*
     * Inserts a broadcast notification into database.
     *
     * Returns:
     *      boolean - true if inserted successfully
     */
    public boolean sendBroadcast(String type, String description) {

        /*
         * SQL: Insert notification record.
         */
        String sql =
                "INSERT INTO notification "
                        + "(notification_type, notification_description, notification_date) "
                        + "VALUES (?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement =
                     conn.prepareStatement(sql)) {

            /*
             * Set notification fields.
             */
            statement.setString(1, type);
            statement.setString(2, description);

            int rowsInserted =
                    statement.executeUpdate();

            return rowsInserted > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Deletes a notification by ID.
     *
     * Returns:
     *      boolean - true if deletion successful
     */
    public boolean deleteNotification(int id) {

        /*
         * SQL: Delete notification by ID.
         */
        String sql =
                "DELETE FROM notification "
                        + "WHERE notification_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement =
                     conn.prepareStatement(sql)) {

            statement.setInt(1, id);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }
}