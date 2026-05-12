package com.controller.admin;

import com.model.Booking;
import com.service.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/*
 * InvoiceServlet handles requests related to generating
 * and displaying booking invoices.
 *
 * URL Mapping:
 *    /invoice
 *
 * This servlet:
 * 1. Receives the booking ID from the request
 * 2. Fetches booking details using BookingService
 * 3. Sends booking data to invoice.jsp
 * 4. Redirects to the report page if the booking is invalid
 */
@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {

    /*
     * Service object used to interact with
     * booking-related business logic and database operations.
     */
    private BookingService bookingService = new BookingService();

    /*
     * Handles HTTP GET requests for invoice generation.
     *
     * Steps performed:
     * 1. Read booking ID from request parameter
     * 2. Validate and parse the ID
     * 3. Retrieve booking details from database
     * 4. Forward data to invoice JSP page
     * 5. Redirect to report page if booking not found
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve booking ID from URL parameter.
         * Example:
         *    /invoice?id=5
         */
        String idParam = request.getParameter("id");

        /*
         * Check whether the ID parameter exists
         * and is not empty before processing.
         */
        if (idParam != null && !idParam.isEmpty()) {
            try {

                /*
                 * Convert booking ID from String to integer.
                 */
                int bookingId = Integer.parseInt(idParam);

                /*
                 * Fetch booking details using the service layer.
                 */
                Booking booking = bookingService.getBookingById(bookingId);

                /*
                 * If booking exists:
                 * - store booking object in request scope
                 * - forward request to invoice.jsp
                 */
                if (booking != null) {
                    request.setAttribute("booking", booking);

                    request.getRequestDispatcher("/Pages/Admin/Report/invoice.jsp")
                            .forward(request, response);
                    return;
                }

            } catch (NumberFormatException e) {

                /*
                 * Handles invalid booking ID formats.
                 * Example:
                 *    /invoice?id=abc
                 */
                System.out.println("Invalid Booking ID format for invoice.");
                e.printStackTrace();
            }
        }

        /*
         * Redirect user back to report page if:
         * - booking ID is missing
         * - booking ID is invalid
         * - booking does not exist
         */
        response.sendRedirect(request.getContextPath() + "/report");
    }
}