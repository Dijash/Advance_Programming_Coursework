package com.controller.user;

import com.model.Customer;
import com.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/submitReview")
public class SubmitReviewServlet extends HttpServlet {

    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        reviewService = new ReviewService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        String bookingId = request.getParameter("bookingId");

        if (user == null) {
            session.setAttribute("errorMsg", "Please log in to submit a review.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String comment = request.getParameter("comment");

        boolean isAdded = reviewService.addReview(user.getCustomer_id(), comment);

        if (isAdded) {
            session.setAttribute("successMsg", "Thank you! Your review has been published.");
        } else {
            session.setAttribute("errorMsg", "Failed to submit review. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/viewUserBooking?id=" + bookingId);
    }
}