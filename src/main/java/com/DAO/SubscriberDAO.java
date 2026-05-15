package com.DAO;

import com.model.Subscriber;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for
 * Subscriber-related database operations.
 *
 * Features:
 * - Fetch all subscribers
 * - Add new subscriber
 * - Soft delete (mark inactive)
 * - Reactivate subscriber
 * - Check email existence
 */
public class SubscriberDAO {

    /*
     * Retrieves all subscribers (active + inactive)
     * for admin reporting purposes.
     *
     * Returns:
     *      List<Subscriber> - all subscriber records
     */
    public List<Subscriber> getAllSubscribers() {

        List<Subscriber> subscribers =
                new ArrayList<>();

        /*
         * SQL: Fetch all subscribers ordered by latest first.
         */
        String sql =
                "SELECT subscriber_id, email, subscribed_at, status "
                        + "FROM subscriber "
                        + "ORDER BY subscribed_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            /*
             * Iterate through result set.
             */
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

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return subscribers;
    }

    /*
     * Soft deletes a subscriber by ID
     * (marks status as inactive instead of deleting).
     *
     * Returns:
     *      boolean - true if update successful
     */
    public boolean deleteSubscriber(int subscriberId) {

        /*
         * SQL: Mark subscriber as inactive.
         */
        String sql =
                "UPDATE subscriber "
                        + "SET status = 'inactive' "
                        + "WHERE subscriber_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setInt(1, subscriberId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Unsubscribes a user by email
     * (only if currently active).
     *
     * Returns:
     *      boolean - true if unsubscribed successfully
     */
    public boolean unsubscribeByEmail(String email) {

        /*
         * SQL: Mark active subscriber as inactive.
         */
        String sql =
                "UPDATE subscriber "
                        + "SET status = 'inactive' "
                        + "WHERE email = ? AND status = 'active'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setString(1, email.trim().toLowerCase());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Adds a new subscriber with ACTIVE status.
     *
     * Returns:
     *      boolean - true if insertion successful
     */
    public boolean addSubscriber(String email) {

        /*
         * SQL: Insert new subscriber record.
         */
        String sql =
                "INSERT INTO subscriber "
                        + "(email, subscribed_at, status) "
                        + "VALUES (?, NOW(), 'active')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            System.out.println(
                    "Error saving subscriber: "
                            + e.getMessage()
            );

            e.printStackTrace();
            return false;
        }
    }

    /*
     * Reactivates a previously inactive subscriber.
     *
     * Returns:
     *      boolean - true if reactivation successful
     */
    public boolean reactivateSubscriber(String email) {

        /*
         * SQL: Reactivate subscriber.
         */
        String sql =
                "UPDATE subscriber "
                        + "SET status = 'active', subscribed_at = NOW() "
                        + "WHERE email = ? AND status = 'inactive'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setString(1, email.trim().toLowerCase());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Checks if an ACTIVE subscription exists for email.
     *
     * Returns:
     *      boolean - true if active subscriber exists
     */
    public boolean emailExistsActive(String email) {

        /*
         * SQL: Check active email existence.
         */
        String sql =
                "SELECT COUNT(*) FROM subscriber "
                        + "WHERE email = ? AND status = 'active'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
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
     * Checks if an email exists in subscriber table
     * regardless of status.
     *
     * Returns:
     *      boolean - true if email exists
     */
    public boolean emailExists(String email) {

        /*
         * SQL: Check email existence.
         */
        String sql =
                "SELECT COUNT(*) FROM subscriber "
                        + "WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return false;
    }
}