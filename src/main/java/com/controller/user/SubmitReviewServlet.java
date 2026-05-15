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

/*
 * Servlet responsible for handling
 * user review submission functionality.
 *
 * URL Mapping:
 *      /submitReview
 *
 * Features:
 * - Validates user login
 * - Submits review for booking
 * - Stores success/error messages
 * - Redirects back to booking page
 */
@WebServlet("/submitReview")
public class SubmitReviewServlet extends HttpServlet {

    /*
     * Service object for review operations.
     */
    private ReviewService reviewService;

    /*
     * Initializes servlet resources.
     *
     * Workflow:
     * 1. Create ReviewService object.
     */
    @Override
    public void init() throws ServletException {

        /*
         * Initialize ReviewService.
         */
        reviewService = new ReviewService();
    }

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Retrieve user session.
     * 2. Validate login status.
     * 3. Retrieve review details.
     * 4. Submit review via service layer.
     * 5. Store feedback message.
     * 6. Redirect back to booking page.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve current session.
         */
        HttpSession session =
                request.getSession();

        /*
         * Retrieve logged-in customer.
         */
        Customer user =
                (Customer) session.getAttribute("user");

        /*
         * Retrieve booking ID from request.
         */
        String bookingId =
                request.getParameter("bookingId");

        /*
         * Check whether user is logged in.
         */
        if (user == null) {

            /*
             * Store error message in session.
             */
            session.setAttribute(
                    "errorMsg",
                    "Please log in to submit a review."
            );

            /*
             * Redirect user to login page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            /*
             * Stop further execution.
             */
            return;
        }

        /*
         * Retrieve review comment.
         */
        String comment =
                request.getParameter("comment");

        /*
         * Submit review via service layer.
         */
        boolean isAdded =
                reviewService.addReview(
                        user.getCustomer_id(),
                        comment
                );

        /*
         * Review submission successful.
         */
        if (isAdded) {

            /*
             * Store success message.
             */
            session.setAttribute(
                    "successMsg",
                    "Thank you! Your review has been published."
            );

        } else {

            /*
             * Store error message.
             */
            session.setAttribute(
                    "errorMsg",
                    "Failed to submit review. Please try again."
            );
        }

        /*
         * Redirect back to booking details page.
         */
        response.sendRedirect(
                request.getContextPath()
                        + "/viewUserBooking?id="
                        + bookingId
        );
    }
}