package com.controller.admin;

import com.model.Booking;
import com.service.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {

    private BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the booking ID from the URL (e.g., /invoice?id=23)
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(idParam);

                // 2. Fetch the booking details
                Booking booking = bookingService.getBookingById(bookingId);

                // 3. If booking exists, send it to the invoice JSP
                if (booking != null) {
                    request.setAttribute("booking", booking);

                    // Make sure this path matches exactly where you saved invoice.jsp
                    request.getRequestDispatcher("/Pages/Admin/Report/invoice.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid Booking ID format for invoice.");
                e.printStackTrace();
            }
        }

        // 4. Fallback: If no ID was provided, or the booking wasn't found, redirect back to reports
        response.sendRedirect(request.getContextPath() + "/report");
    }
}