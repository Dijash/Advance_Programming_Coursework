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

public class AdminDashboardDAO {

    public int getTotalBookings() {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) FROM booking");
             ResultSet rs = statement.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public int getTotalVehicles() {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) FROM vehicle");
             ResultSet rs = statement.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public double getTotalRevenue() {
        double total = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT IFNULL(SUM(payment_amount), 0) FROM payment");
             ResultSet rs = statement.executeQuery()) {
            if (rs.next()) total = rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public int getActiveRentalsCount() {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT COUNT(*) FROM booking WHERE booking_status = 'On Track'");
             ResultSet rs = statement.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public List<UpcomingReturn> getUpcomingReturns() {
        List<UpcomingReturn> list = new ArrayList<>();
        String sql = "SELECT c.first_name, c.last_name, v.vehicle_brand, v.vehicle_type, b.booking_endDate, b.booking_status " +
                "FROM booking b JOIN customer c ON b.customer_id = c.customer_id " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.booking_status IN ('On Track', 'Extended') " +
                "ORDER BY b.booking_endDate ASC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                String customerName = rs.getString("first_name") + " " + rs.getString("last_name");
                String vehicleDetails = rs.getString("vehicle_brand") + " " + rs.getString("vehicle_type");
                list.add(new UpcomingReturn(customerName, vehicleDetails, rs.getString("booking_endDate"), rs.getString("booking_status")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public TopVehicle getTopVehicle() {
        String sql = "SELECT v.vehicle_brand, v.vehicle_type, v.vehicle_image, COUNT(b.booking_id) as total_uses " +
                "FROM vehicle v JOIN booking b ON v.vehicle_id = b.vehicle_id " +
                "GROUP BY v.vehicle_id ORDER BY total_uses DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            if (rs.next()) {
                return new TopVehicle(rs.getString("vehicle_brand"), rs.getString("vehicle_type"), rs.getString("vehicle_image"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}