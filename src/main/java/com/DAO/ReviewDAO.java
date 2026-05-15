package com.DAO;

import com.model.Review;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/*
 * DAO class responsible for
 * Review-related database operations.
 *
 * Features:
 * - Retrieve all reviews with customer details
 * - Add new review
 * - Delete review
 */
public class ReviewDAO {

    /*
     * Retrieves all reviews from database.
     *
     * Includes customer name via JOIN with customer table.
     *
     * Returns:
     *      List<Review> - all reviews ordered by latest first
     */
    public List<Review> getAllReviews() {

        List<Review> reviews =
                new ArrayList<>();

        /*
         * SQL: Fetch reviews with customer full name.
         */
        String sql =
                "SELECT r.review_id, r.customer_id, "
                        + "CONCAT(c.first_name, ' ', c.last_name) as customer_name, "
                        + "r.review_description, r.review_date "
                        + "FROM review r "
                        + "JOIN customer c ON r.customer_id = c.customer_id "
                        + "ORDER BY r.review_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            /*
             * Iterate through result set.
             */
            while (rs.next()) {

                reviews.add(
                        new Review(
                                rs.getInt("review_id"),
                                rs.getInt("customer_id"),
                                rs.getString("customer_name"),
                                rs.getString("review_description"),
                                rs.getTimestamp("review_date")
                        )
                );
            }

        } catch (SQLException e) {

            /*
             * Handle SQL errors.
             */
            e.printStackTrace();
        }

        return reviews;
    }

    /*
     * Deletes a review by ID.
     *
     * Returns:
     *      boolean - true if deletion successful
     */
    public boolean deleteReview(int reviewId) {

        /*
         * SQL: Delete review record.
         */
        String sql =
                "DELETE FROM review WHERE review_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setInt(1, reviewId);

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
     * Adds a new review into database.
     *
     * Returns:
     *      boolean - true if insert successful
     */
    public boolean addReview(int customerId, String description) {

        boolean isAdded = false;

        /*
         * SQL: Insert new review.
         */
        String sql =
                "INSERT INTO review "
                        + "(customer_id, review_description, review_date) "
                        + "VALUES (?, ?, CURDATE())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql)) {

            /*
             * Set review values.
             */
            stmt.setInt(1, customerId);
            stmt.setString(2, description);

            int rowsAffected =
                    stmt.executeUpdate();

            if (rowsAffected > 0) {
                isAdded = true;
            }

        } catch (SQLException e) {

            /*
             * Handle SQL error.
             */
            System.out.println(
                    "Error saving review: "
                            + e.getMessage()
            );

            e.printStackTrace();
        }

        return isAdded;
    }
}