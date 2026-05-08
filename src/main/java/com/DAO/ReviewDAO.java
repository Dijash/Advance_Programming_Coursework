package com.DAO;

import com.model.Review;
import com.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.review_id, r.customer_id, CONCAT(c.first_name, ' ', c.last_name) as customer_name, " +
                "r.review_description, r.review_date " +
                "FROM review r " +
                "JOIN customer c ON r.customer_id = c.customer_id " +
                "ORDER BY r.review_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                reviews.add(new Review(
                        rs.getInt("review_id"),
                        rs.getInt("customer_id"),
                        rs.getString("customer_name"),
                        rs.getString("review_description"),
                        rs.getTimestamp("review_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM review WHERE review_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean addReview(int customerId, String description) {
        boolean isAdded = false;

        String sql = "INSERT INTO review (customer_id, review_description, review_date) VALUES (?, ?, CURDATE())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, customerId);
            stmt.setString(2, description);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isAdded = true;
            }

        } catch (SQLException e) {
            System.out.println("Error saving review: " + e.getMessage());
            e.printStackTrace();
        }

        return isAdded;
    }
}