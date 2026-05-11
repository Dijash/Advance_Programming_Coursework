package com.DAO;

import com.model.Vehicle;
import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavoriteDAO {

    public boolean toggleFavorite(int customerId, int vehicleId) {
        boolean isNowFavorited = false;

        String checkSql = "SELECT * FROM favorites WHERE customer_id = ? AND vehicle_id = ?";
        String insertSql = "INSERT INTO favorites (customer_id, vehicle_id) VALUES (?, ?)";
        String deleteSql = "DELETE FROM favorites WHERE customer_id = ? AND vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setInt(1, customerId);
            checkStmt.setInt(2, vehicleId);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                        deleteStmt.setInt(1, customerId);
                        deleteStmt.setInt(2, vehicleId);
                        deleteStmt.executeUpdate();
                        isNowFavorited = false;
                    }
                } else {
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, customerId);
                        insertStmt.setInt(2, vehicleId);
                        insertStmt.executeUpdate();
                        isNowFavorited = true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isNowFavorited;
    }

    public List<Integer> getUserFavoriteVehicleIds(int customerId) {
        List<Integer> favoriteIds = new ArrayList<>();
        String sql = "SELECT vehicle_id FROM favorites WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    favoriteIds.add(rs.getInt("vehicle_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return favoriteIds;
    }

    public List<Vehicle> getFavoriteVehiclesByCustomerId(int customerId) {
        List<Vehicle> favVehicles = new ArrayList<>();
        String sql = "SELECT v.* FROM vehicle v INNER JOIN favorites f ON v.vehicle_id = f.vehicle_id WHERE f.customer_id = ? ORDER BY f.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    favVehicles.add(new Vehicle(
                            rs.getInt("vehicle_id"),
                            rs.getString("vehicle_brand"),
                            rs.getString("vehicle_type"),
                            rs.getString("vehicle_color"),
                            rs.getString("vehicle_numberPlate"),
                            rs.getString("vehicle_condition"),
                            rs.getString("vehicle_status"),
                            rs.getString("vehicle_image"),
                            rs.getDouble("vehicle_price")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return favVehicles;
    }
}