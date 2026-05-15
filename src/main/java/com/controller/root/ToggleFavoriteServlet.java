package com.controller.root;

import com.DAO.FavoriteDAO;
import com.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * add/remove favorite vehicle functionality.
 *
 * URL Mapping:
 *      /toggleFavorite
 *
 * Features:
 * - Ensures user is logged in
 * - Toggles vehicle favorite status
 * - Redirects back to the previous page
 */
@WebServlet("/toggleFavorite")
public class ToggleFavoriteServlet extends HttpServlet {

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Validate user session.
     * 2. Retrieve customer and vehicle IDs.
     * 3. Toggle favorite status in database.
     * 4. Redirect user back to previous page or listing page.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         * 'false' prevents creation of new session.
         */
        HttpSession session =
                request.getSession(false);

        /*
         * Check whether user is logged in.
         */
        if (session == null
                || session.getAttribute("user") == null) {

            /*
             * Redirect unauthenticated user to login page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            /*
             * Stop further execution.
             */
            return;
        }

        try {

            /*
             * Retrieve logged-in customer object.
             */
            Customer loggedInUser =
                    (Customer) session.getAttribute("user");

            /*
             * Get customer ID.
             */
            int customerId =
                    loggedInUser.getCustomer_id();

            /*
             * Retrieve vehicle ID from request.
             */
            int vehicleId =
                    Integer.parseInt(
                            request.getParameter("vehicleId")
                    );

            /*
             * Create FavoriteDAO object.
             */
            FavoriteDAO favDAO = new FavoriteDAO();

            /*
             * Toggle favorite status for vehicle.
             * (Add if not exists, remove if already exists)
             */
            favDAO.toggleFavorite(customerId, vehicleId);

            /*
             * Get referring page URL.
             */
            String referer =
                    request.getHeader("Referer");

            /*
             * Redirect user back to previous page
             * if available.
             */
            if (referer != null && !referer.isEmpty()) {

                response.sendRedirect(referer);

            } else {

                /*
                 * Fallback redirect to rental deals page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/rentalDeals"
                );
            }

        } catch (Exception e) {

            /*
             * Print exception for debugging.
             */
            e.printStackTrace();

            /*
             * Redirect to the rental deals page on error.
             */
            response.sendRedirect(
                    request.getContextPath() + "/rentalDeals"
            );
        }
    }
}