package com.controller.user;

import com.DAO.UserDashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verify user is logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            try {
                // 2. Get the booking ID from the form
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));

                // 3. Call the DAO to update the database
                UserDashboardDAO dao = new UserDashboardDAO();
                dao.cancelBooking(bookingId);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 4. Redirect the user back to the My Bookings page
        response.sendRedirect(request.getContextPath() + "/myBookings");
    }
}