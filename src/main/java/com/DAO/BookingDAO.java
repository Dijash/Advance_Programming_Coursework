package com.DAO;

import com.model.Booking;
import com.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public boolean createBooking(int customerId, int vehicleId, String startDate, String endDate, double totalPrice) {
        boolean isSuccess = false;
        String sql = "INSERT INTO booking (customer_id, vehicle_id, admin_id, booking_startDate, booking_endDate, total_price, booking_status) " +
                "VALUES (?, ?, NULL, ?, ?, ?, 'Pending')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, customerId);
            stmt.setInt(2, vehicleId);
            stmt.setString(3, startDate);
            stmt.setString(4, endDate);
            stmt.setDouble(5, totalPrice);

            if (stmt.executeUpdate() > 0) {
                isSuccess = true;
                updateVehicleStatusForBooking(vehicleId, "Rented", conn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // --- Helper to lock the vehicle ---
    private void updateVehicleStatusForBooking(int vehicleId, String status, Connection conn) throws SQLException {
        String sql = "UPDATE vehicle SET vehicle_status = ? WHERE vehicle_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, vehicleId);
            stmt.executeUpdate();
        }
    }

    // --- Existing Methods (Updated to free up vehicles) ---
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.booking_id, CONCAT(c.first_name, ' ', c.last_name) as customer_name, " +
                "CONCAT(v.vehicle_brand, ' ', v.vehicle_type) as vehicle_info, " +
                "v.vehicle_numberPlate, b.booking_startDate, b.booking_endDate, b.booking_status, b.total_price " +
                "FROM booking b JOIN customer c ON b.customer_id = c.customer_id JOIN vehicle v ON b.vehicle_id = v.vehicle_id ORDER BY b.booking_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                bookings.add(new Booking(rs.getInt("booking_id"), rs.getString("customer_name"), rs.getString("vehicle_info"), rs.getString("booking_status"), rs.getDate("booking_startDate"), rs.getDate("booking_endDate"), rs.getString("total_price"), rs.getString("vehicle_numberPlate")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookings;
    }

    public Booking getBookingById(int id) {
        String sql = "SELECT b.*, CONCAT(c.first_name, ' ', c.last_name) as customer_name, CONCAT(v.vehicle_brand, ' ', v.vehicle_type) as vehicle_info, v.vehicle_numberPlate FROM booking b JOIN customer c ON b.customer_id = c.customer_id JOIN vehicle v ON b.vehicle_id = v.vehicle_id WHERE b.booking_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return new Booking(rs.getInt("booking_id"), rs.getString("customer_name"), rs.getString("vehicle_info"), rs.getString("booking_status"), rs.getDate("booking_startDate"), rs.getDate("booking_endDate"), rs.getString("total_price"), rs.getString("vehicle_numberPlate"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateBookingStatus(int id, String status) {
        String sql = "UPDATE booking SET booking_status = ? WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            boolean updated = stmt.executeUpdate() > 0;
            if (updated && (status.equalsIgnoreCase("Completed") || status.equalsIgnoreCase("Cancelled"))) {
                freeUpVehicleByBookingId(id, conn);
            }
            return updated;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteBooking(int id) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement payStmt = conn.prepareStatement("DELETE FROM payment WHERE booking_id = ?");
             PreparedStatement bookStmt = conn.prepareStatement("DELETE FROM booking WHERE booking_id = ?")) {
            freeUpVehicleByBookingId(id, conn);
            payStmt.setInt(1, id); payStmt.executeUpdate();
            bookStmt.setInt(1, id); return bookStmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private void freeUpVehicleByBookingId(int bookingId, Connection conn) {
        String sql = "UPDATE vehicle SET vehicle_status = 'Available' WHERE vehicle_id = (SELECT vehicle_id FROM booking WHERE booking_id = ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId); stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
    public int getTotalBookingCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM booking";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}