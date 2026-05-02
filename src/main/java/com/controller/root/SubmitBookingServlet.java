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

@WebServlet("/submitBooking")
public class SubmitBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            session.setAttribute("errorMsg", "Please log in to book a vehicle.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Customer loggedInUser = (Customer) session.getAttribute("user");

            int customerId = loggedInUser.getCustomer_id();

            int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));
            String startDateStr = request.getParameter("booking_startDate");
            String endDateStr = request.getParameter("booking_endDate");

            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = LocalDate.parse(endDateStr);

            if (endDate.isBefore(startDate)) {
                VehicleDAO vehicleDAO = new VehicleDAO();
                Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);

                request.setAttribute("vehicle", vehicle);
                request.setAttribute("dateError", "Error: The End Date cannot be before the Start Date.");
                request.getRequestDispatcher("/Pages/Root/viewVehicleDetails.jsp").forward(request, response);
                return;
            }

            long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
            int totalDays = (int) daysBetween;
            if (totalDays <= 0) totalDays = 1;

            double dailyRate = 4500.0;
            double totalPrice = totalDays * dailyRate;

            // 3. Save to Database
            BookingDAO bookingDAO = new BookingDAO();
            boolean isSuccess = bookingDAO.createBooking(customerId, vehicleId, startDateStr, endDateStr, totalPrice);

            if (isSuccess) {
                session.setAttribute("successMsg", "Your booking was successful!");
                // Redirecting to myBookings page upon success
                response.sendRedirect(request.getContextPath() + "/myBookings");
            } else {
                session.setAttribute("errorMsg", "Database error occurred. Please try again.");
                response.sendRedirect(request.getContextPath() + "/ViewVehicleDetails?id=" + vehicleId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An unexpected error occurred processing your booking.");
            response.sendRedirect(request.getContextPath() + "/rentalDeals");
        }
    }
}