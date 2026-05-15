package com.DAO;

import com.model.TopVehicle;
import com.model.UpcomingReturn;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for
 * Admin Dashboard related database operations.
 *
 * Features:
 * - Retrieves total bookings count
 * - Retrieves total vehicles count
 * - Calculates total revenue
 * - Retrieves active rentals count
 * - Fetches upcoming return vehicles
 * - Fetches top most used vehicle
 */
public class AdminDashboardDAO {

    /*
     * Retrieves total number of bookings.
     *
     * Returns:
     *      int - total bookings count
     */
    public int getTotalBookings() {

        int count = 0;

        /*
         * SQL: Count all records in booking table.
         */
        String sql = "SELECT COUNT(*) FROM booking";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            /*
             * Read count result.
             */
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {

            /*
             * Print SQL error details.
             */
            e.printStackTrace();
        }

        return count;
    }

    /*
     * Retrieves total number of vehicles.
     *
     * Returns:
     *      int - total vehicles count
     */
    public int getTotalVehicles() {

        int count = 0;

        /*
         * SQL: Count all vehicles.
         */
        String sql = "SELECT COUNT(*) FROM vehicle";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {

            /*
             * Handle database errors.
             */
            e.printStackTrace();
        }

        return count;
    }

    /*
     * Calculates total revenue from payments.
     *
     * Returns:
     *      double - total revenue amount
     */
    public double getTotalRevenue() {

        double total = 0;

        /*
         * SQL: Sum of all payment amounts.
         * IFNULL ensures 0 if no records exist.
         */
        String sql =
                "SELECT IFNULL(SUM(payment_amount), 0) FROM payment";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {
                total = rs.getDouble(1);
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return total;
    }

    /*
     * Retrieves count of active rentals.
     *
     * Active statuses:
     * - On Track
     *
     * Returns:
     *      int - active rental count
     */
    public int getActiveRentalsCount() {

        int count = 0;

        /*
         * SQL: Count active bookings.
         */
        String sql =
                "SELECT COUNT(*) FROM booking "
                        + "WHERE booking_status = 'On Track'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {

            /*
             * Handle SQL exception.
             */
            e.printStackTrace();
        }

        return count;
    }

    /*
     * Retrieves list of upcoming vehicle returns.
     *
     * Returns:
     *      List<UpcomingReturn> - upcoming return data
     */
    public List<UpcomingReturn> getUpcomingReturns() {

        List<UpcomingReturn> list =
                new ArrayList<>();

        /*
         * SQL: Fetch next 5 upcoming returns.
         */
        String sql =
                "SELECT c.first_name, c.last_name, "
                        + "v.vehicle_brand, v.vehicle_type, "
                        + "b.booking_endDate, b.booking_status "
                        + "FROM booking b "
                        + "JOIN customer c ON b.customer_id = c.customer_id "
                        + "JOIN vehicle v ON b.vehicle_id = v.vehicle_id "
                        + "WHERE b.booking_status IN ('On Track', 'Extended') "
                        + "ORDER BY b.booking_endDate ASC LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            /*
             * Iterate through result set.
             */
            while (rs.next()) {

                /*
                 * Build customer full name.
                 */
                String customerName =
                        rs.getString("first_name")
                                + " "
                                + rs.getString("last_name");

                /*
                 * Build vehicle description.
                 */
                String vehicleDetails =
                        rs.getString("vehicle_brand")
                                + " "
                                + rs.getString("vehicle_type");

                /*
                 * Add record to list.
                 */
                list.add(new UpcomingReturn(
                        customerName,
                        vehicleDetails,
                        rs.getString("booking_endDate"),
                        rs.getString("booking_status")
                ));
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return list;
    }

    /*
     * Retrieves most frequently booked vehicle.
     *
     * Returns:
     *      TopVehicle - most used vehicle info
     */
    public TopVehicle getTopVehicle() {

        /*
         * SQL: Find most booked vehicle.
         */
        String sql =
                "SELECT v.vehicle_brand, v.vehicle_type, "
                        + "v.vehicle_image, COUNT(b.booking_id) as total_uses "
                        + "FROM vehicle v "
                        + "JOIN booking b ON v.vehicle_id = b.vehicle_id "
                        + "GROUP BY v.vehicle_id "
                        + "ORDER BY total_uses DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {

                return new TopVehicle(
                        rs.getString("vehicle_brand"),
                        rs.getString("vehicle_type"),
                        rs.getString("vehicle_image")
                );
            }

        } catch (SQLException e) {

            /*
             * Handle SQL exception.
             */
            e.printStackTrace();
        }

        return null;
    }
}