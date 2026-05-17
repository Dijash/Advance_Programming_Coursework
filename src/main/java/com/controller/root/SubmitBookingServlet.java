package com.controller.root;

import com.DAO.BookingDAO;
import com.DAO.VehicleDAO;

import com.model.Customer;
import com.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/*
 * Servlet responsible for handling
 * vehicle booking submissions.
 *
 * URL Mapping:
 *      /submitBooking
 *
 * Features:
 * - Validates user login
 * - Retrieves booking details
 * - Validates booking dates
 * - Calculates rental price
 * - Creates booking record
 * - Redirects user based on result
 */
@WebServlet("/submitBooking")
public class SubmitBookingServlet extends HttpServlet {

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Verify user session.
     * 2. Retrieve booking form data.
     * 3. Validate booking dates.
     * 4. Calculate rental duration and price.
     * 5. Store booking in database.
     * 6. Redirect user based on booking result.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         * 'false' prevents creating new session.
         */
        HttpSession session = request.getSession(false);

        /*
         * Check whether user is logged in.
         */
        if (session == null
                || session.getAttribute("user") == null) {

            /*
             * Set login required error message.
             */
            session.setAttribute(
                    "errorMsg",
                    "Please log in to book a vehicle."
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

        try {

            /*
             * Retrieve logged-in customer object.
             */
            Customer loggedInUser =
                    (Customer) session.getAttribute("user");

            /*
             * Retrieve customer ID.
             */
            int customerId =
                    loggedInUser.getCustomer_id();

            /*
             * Retrieve booking details from form.
             */
            int vehicleId = Integer.parseInt(
                    request.getParameter("vehicle_id")
            );

            String startDateStr =
                    request.getParameter("booking_startDate");

            String endDateStr =
                    request.getParameter("booking_endDate");

            /*
             * Convert date strings to LocalDate objects.
             */
            LocalDate startDate =
                    LocalDate.parse(startDateStr);

            LocalDate endDate =
                    LocalDate.parse(endDateStr);

            /*
             * Validate booking dates.
             * End date cannot be before start date.
             */
            if (endDate.isBefore(startDate)) {

                /*
                 * Retrieve selected vehicle details.
                 */
                VehicleDAO vehicleDAO = new VehicleDAO();

                Vehicle vehicle =
                        vehicleDAO.getVehicleById(vehicleId);

                /*
                 * Store vehicle details.
                 */
                request.setAttribute("vehicle", vehicle);

                /*
                 * Set date validation error message.
                 */
                request.setAttribute(
                        "dateError",
                        "Error: The End Date cannot be before the Start Date."
                );

                /*
                 * Return user to vehicle details page.
                 */
                request.getRequestDispatcher(
                                "/WEB-INF/Pages/Root/viewVehicleDetails.jsp")
                        .forward(request, response);

                /*
                 * Stop further execution.
                 */
                return;
            }

            /*
             * Calculate total booking days.
             */
            long daysBetween =
                    ChronoUnit.DAYS.between(
                            startDate,
                            endDate
                    );

            /*
             * Convert long value to integer.
             */
            int totalDays = (int) daysBetween;

            /*
             * Ensure minimum booking duration is 1 day.
             */
            if (totalDays <= 0) {
                totalDays = 1;
            }

            /*
             * Define daily rental rate.
             */
            double dailyRate = 4500.0;

            /*
             * Calculate total rental price.
             */
            double totalPrice =
                    totalDays * dailyRate;

            /*
             * Create BookingDAO object.
             */
            BookingDAO bookingDAO = new BookingDAO();

            /*
             * Insert booking into database.
             */
            boolean isSuccess =
                    bookingDAO.createBooking(
                            customerId,
                            vehicleId,
                            startDateStr,
                            endDateStr,
                            totalPrice
                    );

            /*
             * Booking successful.
             */
            if (isSuccess) {

                /*
                 * Store success message.
                 */
                session.setAttribute(
                        "successMsg",
                        "Your booking was successful!"
                );

                /*
                 * Redirect user to booking history page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/myBookings"
                );

            } else {

                /*
                 * Store database error message.
                 */
                session.setAttribute(
                        "errorMsg",
                        "Database error occurred. Please try again."
                );

                /*
                 * Redirect back to vehicle details page.
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/ViewVehicleDetails?id="
                                + vehicleId
                );
            }

        } catch (Exception e) {

            /*
             * Print exception details in console.
             */
            e.printStackTrace();

            /*
             * Store unexpected error message.
             */
            session.setAttribute(
                    "errorMsg",
                    "An unexpected error occurred processing your booking."
            );

            /*
             * Redirect user to rental deals page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/rentalDeals"
            );
        }
    }
}