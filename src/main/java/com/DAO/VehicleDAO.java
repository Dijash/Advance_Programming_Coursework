package com.DAO;

import com.util.DBConnection;
import com.model.Vehicle;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    public boolean addVehicle(int adminId, String brand, String type, String color, String numberPlate, String condition, String status, String image, double price) {
        boolean isAdded = false;

        String sql = "INSERT INTO vehicle (admin_id, customer_id, vehicle_brand, vehicle_type, vehicle_color, vehicle_numberPlate, vehicle_condition, vehicle_status, vehicle_image, vehicle_price) " +
                "VALUES (?, NULL, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, adminId);
            statement.setString(2, brand);
            statement.setString(3, type);
            statement.setString(4, color);
            statement.setString(5, numberPlate);
            statement.setString(6, condition);
            statement.setString(7, status);
            statement.setString(8, image);
            statement.setDouble(9, price);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                isAdded = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isAdded;
    }

    public boolean deleteVehicle(int vehicleId) {
        boolean isDeleted = false;

        String sqlDeleteFavorites = "DELETE FROM favorites WHERE vehicle_id = ?";
        String sqlDeleteBookings = "DELETE FROM booking WHERE vehicle_id = ?";
        String sqlDeleteVehicle = "DELETE FROM vehicle WHERE vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement psFav = conn.prepareStatement(sqlDeleteFavorites)) {
                psFav.setInt(1, vehicleId);
                psFav.executeUpdate();
            }

            try (PreparedStatement psBook = conn.prepareStatement(sqlDeleteBookings)) {
                psBook.setInt(1, vehicleId);
                psBook.executeUpdate();
            }
            try (PreparedStatement psVeh = conn.prepareStatement(sqlDeleteVehicle)) {
                psVeh.setInt(1, vehicleId);
                int rowsAffected = psVeh.executeUpdate();
                if (rowsAffected > 0) {
                    isDeleted = true;
                }
            }

        } catch (SQLException e) {
            System.out.println("Error deleting vehicle: " + e.getMessage());
            e.printStackTrace();
        }

        return isDeleted;
    }

    public boolean updateVehicle(int vehicleId, String brand, String type, String color, String numberPlate, String condition, String status, String image, double price) {
        boolean isUpdated = false;

        String sql = "UPDATE vehicle SET vehicle_brand = ?, vehicle_type = ?, vehicle_color = ?, " +
                "vehicle_numberPlate = ?, vehicle_condition = ?, vehicle_status = ?, vehicle_image = ?, vehicle_price = ? " +
                "WHERE vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, brand);
            statement.setString(2, type);
            statement.setString(3, color);
            statement.setString(4, numberPlate);
            statement.setString(5, condition);
            statement.setString(6, status);
            statement.setString(7, image);
            statement.setDouble(8, price);
            statement.setInt(9, vehicleId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                isUpdated = true;
            }

        } catch (SQLException e) {
            System.out.println("Error updating vehicle: " + e.getMessage());
            e.printStackTrace();
        }

        return isUpdated;
    }

    public Vehicle getVehicleById(int id) {
        Vehicle vehicle = null;
        String sql = "SELECT * FROM vehicle WHERE vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                vehicle = new Vehicle(
                        resultSet.getInt("vehicle_id"),
                        resultSet.getString("vehicle_brand"),
                        resultSet.getString("vehicle_type"),
                        resultSet.getString("vehicle_color"),
                        resultSet.getString("vehicle_numberPlate"),
                        resultSet.getString("vehicle_condition"),
                        resultSet.getString("vehicle_status"),
                        resultSet.getString("vehicle_image"),
                        resultSet.getDouble("vehicle_price")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicle;
    }

    public List<Vehicle> getAllVehicles() {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicle ORDER BY vehicle_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                list.add(new Vehicle(
                        resultSet.getInt("vehicle_id"),
                        resultSet.getString("vehicle_brand"),
                        resultSet.getString("vehicle_type"),
                        resultSet.getString("vehicle_color"),
                        resultSet.getString("vehicle_numberPlate"),
                        resultSet.getString("vehicle_condition"),
                        resultSet.getString("vehicle_status"),
                        resultSet.getString("vehicle_image"),
                        resultSet.getDouble("vehicle_price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Vehicle> getFilteredVehicles(String searchParam, String type, String color, String status, String condition) {
        List<Vehicle> filtered = new ArrayList<>();

        for (Vehicle v : getAllVehicles()) {
            if (searchParam != null && !searchParam.trim().isEmpty())
                if (!v.getVehicle_brand().toLowerCase().contains(searchParam.toLowerCase())) continue;

            if (type != null && !type.equalsIgnoreCase("All") && !type.trim().isEmpty())
                if (!v.getVehicle_type().equalsIgnoreCase(type)) continue;

            if (color != null && !color.equalsIgnoreCase("All") && !color.trim().isEmpty())
                if (!v.getVehicle_color().equalsIgnoreCase(color)) continue;

            if (status != null && !status.equalsIgnoreCase("All") && !status.trim().isEmpty())
                if (!v.getVehicle_status().equalsIgnoreCase(status)) continue;

            if (condition != null && !condition.equalsIgnoreCase("All") && !condition.trim().isEmpty())
                if (!v.getVehicle_condition().equalsIgnoreCase(condition)) continue;

            filtered.add(v);
        }

        return filtered;
    }

    public List<Vehicle> getTopVehicles(int limit) {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicle ORDER BY vehicle_id ASC LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                list.add(new Vehicle(
                        rs.getInt("vehicle_id"),
                        rs.getString("vehicle_brand"),
                        rs.getString("vehicle_type"),
                        rs.getString("vehicle_color"),
                        rs.getString("vehicle_numberPlate"),
                        rs.getString("vehicle_condition"),
                        rs.getString("vehicle_status"),
                        rs.getString("vehicle_image"),
                        rs.getDouble("vehicle_price")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getTotalVehicleCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM vehicle";

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

    public int getVehicleCountByStatus(String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM vehicle WHERE vehicle_status = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}