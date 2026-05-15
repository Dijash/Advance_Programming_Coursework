package com.DAO;

import com.model.Booking;
import com.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for handling all USER DASHBOARD related database operations.
 *
 * This includes:
 * - Fetching booking statistics
 * - Retrieving booking history
 * - Calculating user spending
 * - Cancelling bookings
 */
public class UserDashboardDAO {

    /*
     * Get the number of ACTIVE bookings for a specific customer.
     *
     * Active bookings include:
     * - On Track
     * - Extended
     * - Pending
     */
    public int getActiveBookingsCount(int customerId) {

        int count = 0;

        String sql = "SELECT COUNT(*) FROM booking WHERE customer_id = ? " +
                "AND booking_status IN ('On Track', 'Extended', 'Pending')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            /*
             * Bind customer ID to the SQL query.
             */
            statement.setInt(1, customerId);

            try (ResultSet rs = statement.executeQuery()) {

                /*
                 * Extract count from result set.
                 */
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    /*
     * Get the number of COMPLETED trips for a customer.
     */
    public int getCompletedTripsCount(int customerId) {

        int count = 0;

        String sql = "SELECT COUNT(*) FROM booking WHERE customer_id = ? " +
                "AND booking_status = 'Completed'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    /*
     * Calculate total amount spent by a customer.
     *
     * Excludes cancelled bookings.
     */
    public double getTotalSpent(int customerId) {

        double total = 0;

        String sql = "SELECT SUM(total_price) as total FROM booking " +
                "WHERE customer_id = ? AND booking_status != 'Cancelled'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    total = rs.getDouble("total");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    /*
     * Retrieve the most recent 5 bookings for a customer.
     */
    public List<Booking> getRecentBookings(int customerId) {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT b.booking_id, v.vehicle_brand, v.vehicle_type, " +
                "v.vehicle_numberPlate, b.booking_startDate, b.booking_endDate, " +
                "b.total_price, b.booking_status " +
                "FROM booking b " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.customer_id = ? " +
                "ORDER BY b.booking_id DESC LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {

                    /*
                     * Combine vehicle brand and type for display.
                     */
                    String vehicleDetails =
                            rs.getString("vehicle_brand") + " " + rs.getString("vehicle_type");

                    bookings.add(new Booking(
                            rs.getInt("booking_id"),
                            null,
                            vehicleDetails,
                            rs.getString("booking_status"),
                            rs.getDate("booking_startDate"),
                            rs.getDate("booking_endDate"),
                            rs.getString("total_price"),
                            rs.getString("vehicle_numberPlate")
                    ));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    /*
     * Retrieve ALL bookings for a specific user.
     */
    public List<Booking> getAllUserBookings(int customerId) {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT b.booking_id, v.vehicle_brand, v.vehicle_type, " +
                "v.vehicle_numberPlate, b.booking_startDate, b.booking_endDate, " +
                "b.total_price, b.booking_status " +
                "FROM booking b " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.customer_id = ? " +
                "ORDER BY b.booking_startDate DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {

                    String vehicleDetails =
                            rs.getString("vehicle_brand") + " " + rs.getString("vehicle_type");

                    bookings.add(new Booking(
                            rs.getInt("booking_id"),
                            null,
                            vehicleDetails,
                            rs.getString("booking_status"),
                            rs.getDate("booking_startDate"),
                            rs.getDate("booking_endDate"),
                            rs.getString("total_price"),
                            rs.getString("vehicle_numberPlate")
                    ));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    /*
     * Cancel a booking by updating its status to 'Cancelled'.
     */
    public boolean cancelBooking(int bookingId) {

        String sql = "UPDATE booking SET booking_status = 'Cancelled' WHERE booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}