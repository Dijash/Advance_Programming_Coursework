package com.DAO;

import com.model.Booking;
import com.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for
 * Booking-related database operations.
 *
 * Features:
 * - Create new bookings
 * - Retrieve booking data
 * - Update booking status
 * - Delete bookings
 * - Manage vehicle status during booking lifecycle
 */
public class BookingDAO {

    /*
     * Creates a new booking record in the database.
     *
     * Workflow:
     * 1. Insert booking into database
     * 2. Set initial status to 'Pending'
     * 3. Mark vehicle as 'Rented' if booking succeeds
     */
    public boolean createBooking(int customerId,
                                 int vehicleId,
                                 String startDate,
                                 String endDate,
                                 double totalPrice) {

        boolean isSuccess = false;

        /*
         * SQL: Insert new booking record.
         */
        String sql =
                "INSERT INTO booking "
                        + "(customer_id, vehicle_id, admin_id, booking_startDate, booking_endDate, total_price, booking_status) "
                        + "VALUES (?, ?, NULL, ?, ?, ?, 'Pending')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            /*
             * Set booking parameters.
             */
            stmt.setInt(1, customerId);
            stmt.setInt(2, vehicleId);
            stmt.setString(3, startDate);
            stmt.setString(4, endDate);
            stmt.setDouble(5, totalPrice);

            /*
             * Execute insert operation.
             */
            if (stmt.executeUpdate() > 0) {

                isSuccess = true;

                /*
                 * Update vehicle status to 'Rented'
                 * after successful booking.
                 */
                updateVehicleStatusForBooking(
                        vehicleId,
                        "Rented",
                        conn
                );
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return isSuccess;
    }

    /*
     * Updates vehicle status during booking creation.
     */
    private void updateVehicleStatusForBooking(int vehicleId,
                                               String status,
                                               Connection conn)
            throws SQLException {

        /*
         * SQL: Update vehicle status.
         */
        String sql =
                "UPDATE vehicle SET vehicle_status = ? "
                        + "WHERE vehicle_id = ?";

        try (PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, vehicleId);

            stmt.executeUpdate();
        }
    }

    /*
     * Retrieves all bookings with joined customer and vehicle data.
     */
    public List<Booking> getAllBookings() {

        List<Booking> bookings =
                new ArrayList<>();

        /*
         * SQL: Fetch all bookings with related info.
         */
        String sql =
                "SELECT b.booking_id, "
                        + "CONCAT(c.first_name, ' ', c.last_name) as customer_name, "
                        + "CONCAT(v.vehicle_brand, ' ', v.vehicle_type) as vehicle_info, "
                        + "v.vehicle_numberPlate, "
                        + "b.booking_startDate, b.booking_endDate, "
                        + "b.booking_status, b.total_price "
                        + "FROM booking b "
                        + "JOIN customer c ON b.customer_id = c.customer_id "
                        + "JOIN vehicle v ON b.vehicle_id = v.vehicle_id "
                        + "ORDER BY b.booking_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            /*
             * Iterate through result set.
             */
            while (rs.next()) {

                bookings.add(new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("customer_name"),
                        rs.getString("vehicle_info"),
                        rs.getString("booking_status"),
                        rs.getDate("booking_startDate"),
                        rs.getDate("booking_endDate"),
                        rs.getString("total_price"),
                        rs.getString("vehicle_numberPlate")
                ));
            }

        } catch (SQLException e) {

            /*
             * Handle database errors.
             */
            e.printStackTrace();
        }

        return bookings;
    }

    /*
     * Retrieves a single booking by ID.
     */
    public Booking getBookingById(int id) {

        /*
         * SQL: Fetch booking by ID.
         */
        String sql =
                "SELECT b.*, "
                        + "CONCAT(c.first_name, ' ', c.last_name) as customer_name, "
                        + "CONCAT(v.vehicle_brand, ' ', v.vehicle_type) as vehicle_info, "
                        + "v.vehicle_numberPlate "
                        + "FROM booking b "
                        + "JOIN customer c ON b.customer_id = c.customer_id "
                        + "JOIN vehicle v ON b.vehicle_id = v.vehicle_id "
                        + "WHERE b.booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return new Booking(
                            rs.getInt("booking_id"),
                            rs.getString("customer_name"),
                            rs.getString("vehicle_info"),
                            rs.getString("booking_status"),
                            rs.getDate("booking_startDate"),
                            rs.getDate("booking_endDate"),
                            rs.getString("total_price"),
                            rs.getString("vehicle_numberPlate")
                    );
                }
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return null;
    }

    /*
     * Updates booking status.
     *
     * If status becomes Completed or Cancelled,
     * vehicle is marked as Available again.
     */
    public boolean updateBookingStatus(int id,
                                       String status) {

        /*
         * SQL: Update booking status.
         */
        String sql =
                "UPDATE booking SET booking_status = ? "
                        + "WHERE booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, id);

            boolean updated =
                    stmt.executeUpdate() > 0;

            /*
             * Free vehicle if booking is finished or cancelled.
             */
            if (updated
                    && (status.equalsIgnoreCase("Completed")
                    || status.equalsIgnoreCase("Cancelled"))) {

                freeUpVehicleByBookingId(id, conn);
            }

            return updated;

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Deletes a booking and related payment data.
     *
     * Uses transaction to ensure data consistency.
     */
    public boolean deleteBooking(int bookingId) {

        boolean isDeleted = false;

        try (Connection conn = DBConnection.getConnection()) {

            /*
             * Start transaction.
             */
            conn.setAutoCommit(false);

            try {

                /*
                 * Free vehicle before deletion.
                 */
                freeUpVehicleByBookingId(bookingId, conn);

                /*
                 * Delete payment records.
                 */
                String deletePayment =
                        "DELETE FROM payment WHERE booking_id = ?";

                try (PreparedStatement ps1 =
                             conn.prepareStatement(deletePayment)) {

                    ps1.setInt(1, bookingId);
                    ps1.executeUpdate();
                }

                /*
                 * Delete booking record.
                 */
                String deleteBooking =
                        "DELETE FROM booking WHERE booking_id = ?";

                try (PreparedStatement ps2 =
                             conn.prepareStatement(deleteBooking)) {

                    ps2.setInt(1, bookingId);

                    if (ps2.executeUpdate() > 0) {
                        isDeleted = true;
                    }
                }

                /*
                 * Commit transaction.
                 */
                conn.commit();

            } catch (SQLException e) {

                /*
                 * Rollback on failure.
                 */
                conn.rollback();

                System.out.println(
                        "SQL ERROR IN DELETE BOOKING: "
                                + e.getMessage()
                );

                e.printStackTrace();

            } finally {

                /*
                 * Reset auto-commit mode.
                 */
                conn.setAutoCommit(true);
            }

        } catch (SQLException e) {

            /*
             * Handle connection error.
             */
            e.printStackTrace();
        }

        return isDeleted;
    }

    /*
     * Marks vehicle as available after booking ends.
     */
    private void freeUpVehicleByBookingId(int bookingId,
                                          Connection conn) {

        /*
         * SQL: Set vehicle status to Available.
         */
        String sql =
                "UPDATE vehicle SET vehicle_status = 'Available' "
                        + "WHERE vehicle_id = "
                        + "(SELECT vehicle_id FROM booking WHERE booking_id = ?)";

        try (PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            stmt.executeUpdate();

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }
    }

    /*
     * Retrieves total booking count.
     */
    public int getTotalBookingCount() {

        int count = 0;

        /*
         * SQL: Count bookings.
         */
        String sql =
                "SELECT COUNT(*) FROM booking";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return count;
    }
}