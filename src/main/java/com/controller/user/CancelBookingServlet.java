package com.controller.user;

import com.DAO.UserDashboardDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * booking cancellation by user.
 *
 * URL Mapping:
 *      /cancelBooking
 *
 * Features:
 * - Validates user session
 * - Cancels selected booking
 * - Redirects user to bookings page
 */
@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Validate user session.
     * 2. Retrieve booking ID.
     * 3. Call DAO to cancel booking.
     * 4. Redirect user to bookings page.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         * 'false' prevents creating new session.
         */
        HttpSession session =
                request.getSession(false);

        /*
         * Check whether the user is logged in.
         */
        if (session != null
                && session.getAttribute("user") != null) {

            try {

                /*
                 * Retrieve booking ID from request.
                 */
                int bookingId =
                        Integer.parseInt(
                                request.getParameter("bookingId")
                        );

                /*
                 * Create UserDashboardDAO object.
                 */
                UserDashboardDAO dao =
                        new UserDashboardDAO();

                /*
                 * Cancel booking in the database.
                 */
                dao.cancelBooking(bookingId);

            } catch (Exception e) {

                /*
                 * Print error details for debugging.
                 */
                e.printStackTrace();
            }
        }

        /*
         * Redirect user to bookings page
         * regardless of the operation result.
         */
        response.sendRedirect(
                request.getContextPath() + "/myBookings"
        );
    }
}