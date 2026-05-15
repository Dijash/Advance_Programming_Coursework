package com.DAO;

import com.model.Vehicle;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/*
 * DAO class is responsible for
 * managing user favorite vehicles.
 *
 * Features:
 * - Toggle favorite (add/remove)
 * - Get favorite vehicle IDs
 * - Get full favorite vehicle details
 */
public class FavoriteDAO {

    /*
     * Toggles favorite status for a vehicle.
     *
     * If record exists → remove (unfavorite)
     * If not exists → insert (favorite)
     *
     * Returns:
     *      boolean - true if now favorited, false if removed
     */
    public boolean toggleFavorite(int customerId, int vehicleId) {

        boolean isNowFavorited = false;

        /*
         * SQL: Check if favorite already exists.
         */
        String checkSql =
                "SELECT * FROM favorites "
                        + "WHERE customer_id = ? AND vehicle_id = ?";

        /*
         * SQL: Insert favorite record.
         */
        String insertSql =
                "INSERT INTO favorites (customer_id, vehicle_id) "
                        + "VALUES (?, ?)";

        /*
         * SQL: Delete favorite record.
         */
        String deleteSql =
                "DELETE FROM favorites "
                        + "WHERE customer_id = ? AND vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt =
                     conn.prepareStatement(checkSql)) {

            /*
             * Set parameters for existence check.
             */
            checkStmt.setInt(1, customerId);
            checkStmt.setInt(2, vehicleId);

            try (ResultSet rs = checkStmt.executeQuery()) {

                /*
                 * If record exists → remove favorite.
                 */
                if (rs.next()) {

                    try (PreparedStatement deleteStmt =
                                 conn.prepareStatement(deleteSql)) {

                        deleteStmt.setInt(1, customerId);
                        deleteStmt.setInt(2, vehicleId);

                        deleteStmt.executeUpdate();

                        isNowFavorited = false;
                    }

                } else {

                    /*
                     * If not exists → add favorite.
                     */
                    try (PreparedStatement insertStmt =
                                 conn.prepareStatement(insertSql)) {

                        insertStmt.setInt(1, customerId);
                        insertStmt.setInt(2, vehicleId);

                        insertStmt.executeUpdate();

                        isNowFavorited = true;
                    }
                }
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return isNowFavorited;
    }

    /*
     * Retrieves list of favorite vehicle IDs
     * for a specific customer.
     *
     * Returns:
     *      List<Integer> - vehicle IDs
     */
    public List<Integer> getUserFavoriteVehicleIds(int customerId) {

        List<Integer> favoriteIds =
                new ArrayList<>();

        /*
         * SQL: Get favorite vehicle IDs.
         */
        String sql =
                "SELECT vehicle_id FROM favorites "
                        + "WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement =
                     conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {

                    favoriteIds.add(
                            rs.getInt("vehicle_id")
                    );
                }
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return favoriteIds;
    }

    /*
     * Retrieves full vehicle details
     * for user's favorites list.
     *
     * Returns:
     *      List<Vehicle> - favorite vehicles
     */
    public List<Vehicle> getFavoriteVehiclesByCustomerId(int customerId) {

        List<Vehicle> favVehicles =
                new ArrayList<>();

        /*
         * SQL: Join favorites with vehicle table.
         */
        String sql =
                "SELECT v.* "
                        + "FROM vehicle v "
                        + "INNER JOIN favorites f "
                        + "ON v.vehicle_id = f.vehicle_id "
                        + "WHERE f.customer_id = ? "
                        + "ORDER BY f.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement =
                     conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {

                    /*
                     * Map result set into Vehicle object.
                     */
                    favVehicles.add(
                            new Vehicle(
                                    rs.getInt("vehicle_id"),
                                    rs.getString("vehicle_brand"),
                                    rs.getString("vehicle_type"),
                                    rs.getString("vehicle_color"),
                                    rs.getString("vehicle_numberPlate"),
                                    rs.getString("vehicle_condition"),
                                    rs.getString("vehicle_status"),
                                    rs.getString("vehicle_image"),
                                    rs.getDouble("vehicle_price")
                            )
                    );
                }
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            e.printStackTrace();
        }

        return favVehicles;
    }
}