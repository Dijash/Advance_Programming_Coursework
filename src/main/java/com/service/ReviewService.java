package com.service;

import com.DAO.ReviewDAO;
import com.model.Review;

import java.util.List;

public class ReviewService {
    private ReviewDAO reviewDAO = new ReviewDAO();

    public List<Review> getAllReviews() {
        return reviewDAO.getAllReviews();
    }

    public boolean deleteReview(int reviewId) {
        return reviewDAO.deleteReview(reviewId);
    }

    public boolean addReview(int customerId, String description) {
        return reviewDAO.addReview(customerId, description);
    }
}