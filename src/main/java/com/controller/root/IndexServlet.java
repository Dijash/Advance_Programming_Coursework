
package com.controller.root;

import com.model.Review;
import com.service.ReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/*
 * Servlet responsible for serving the public index page (/).
 *
 * Loads the latest reviews from the database and sets them
 * as a request attribute before forwarding to index.jsp.
 *
 * URL Mapping:
 *      /index  (mapped as the welcome-file target via web.xml)
 */
@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    /*
     * Service object for review operations.
     */
    private ReviewService reviewService;

    /*
     * Initializes servlet resources.
     */
    @Override
    public void init() throws ServletException {

        /*
         * Initialize ReviewService.
         */
        reviewService = new ReviewService();
    }

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Retrieve latest reviews (max 3).
     * 2. Set them as a request attribute.
     * 3. Forward to index.jsp.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve all reviews from the service layer.
         */
        List<Review> allReviews = reviewService.getAllReviews();

        /*
         * Limit to the 3 most recent reviews.
         */
        List<Review> recentReviews = allReviews.size() > 3
                ? allReviews.subList(0, 3)
                : allReviews;

        /*
         * Store reviews in request scope for index.jsp.
         * Attribute name matches ${recentReviews} used in index.jsp.
         */
        request.setAttribute("recentReviews", recentReviews);

        /*
         * Forward request to index.jsp.
         */
        request.getRequestDispatcher("/index.jsp")
                .forward(request, response);
    }
}