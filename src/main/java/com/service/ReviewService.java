package com.service;

import com.DAO.ReviewDAO;
import com.model.Review;
import java.util.List;

public class ReviewService {
    private ReviewDAO reviewDAO = new ReviewDAO();

    public List<Review> getAllReviews() { return reviewDAO.getAllReviews(); }
}