package com.controller.admin;

import com.DAO.*;
import com.model.ContactMessage;
import com.model.Subscriber;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/*
 * Responsibilities:
 * 1. Fetch vehicle statistics
 * 2. Fetch customer and booking counts
 * 3. Retrieve all booking records
 * 4. Retrieve contact messages
 * 5. Send all collected data to report.jsp
 */
@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    /*
     * Handles HTTP GET requests for the admin report page.
     *
     * This method:
     * - Creates DAO objects
     * - Retrieves dashboard statistics
     * - Stores data in request attributes
     * - Forwards request to report.jsp
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Create DAO objects to access database operations.
         */
        VehicleDAO vehicleDAO = new VehicleDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        BookingDAO bookingDAO = new BookingDAO();
        ContactDAO contactDAO = new ContactDAO();
        SubscriberDAO subscriberDAO = new SubscriberDAO();

        /*
         * Retrieve vehicle-related statistics.
         */
        int totalVehicles = vehicleDAO.getTotalVehicleCount();

        /*
         * Count vehicles currently rented.
         */
        int rentedVehicles = vehicleDAO.getVehicleCountByStatus("Rented");

        /*
         * Count vehicles under maintenance.
         */
        int maintenanceVehicles = vehicleDAO.getVehicleCountByStatus("Maintenance");

        /*
         * Retrieve total number of registered customers.
         */
        int totalCustomers = customerDAO.getTotalCustomerCount();

        /*
         * Retrieve total number of bookings.
         */
        int totalBookings = bookingDAO.getTotalBookingCount();

        /*
         * Fetch all booking records and store them
         * in request scope for displaying in JSP.
         */
        request.setAttribute("allBookingsList", bookingDAO.getAllBookings());

        /*
         * Retrieve all contact messages submitted by users.
         */
        List<ContactMessage> contactMessagesList = contactDAO.getAllMessages();

        /*
         * Store contact messages in request scope.
         */
        request.setAttribute("contactMessagesList", contactMessagesList);

        /*
         * Retrieve all newsletter subscribers and store in request scope.
         */
        List<Subscriber> subscribersList = subscriberDAO.getAllSubscribers();
        long activeSubscribersCount = subscribersList.stream()
                .filter(s -> "active".equals(s.getStatus()))
                .count();
        request.setAttribute("subscribersList", subscribersList);
        request.setAttribute("totalSubscribers", activeSubscribersCount);

        /*
         * Store dashboard statistics in request attributes.
         */
        request.setAttribute("totalVehicles", totalVehicles);
        request.setAttribute("rentedVehicles", rentedVehicles);
        request.setAttribute("maintenanceVehicles", maintenanceVehicles);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalBookings", totalBookings);

        /*
         * Forward request and response to the admin report page.
         */
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/Report/report.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String email = request.getParameter("email");

        if (email != null && !email.trim().isEmpty()) {
            SubscriberDAO subscriberDAO = new SubscriberDAO();

            if ("unsubscribe".equals(action)) {
                subscriberDAO.unsubscribeByEmail(email);
            } else if ("reactivate".equals(action)) {
                subscriberDAO.reactivateSubscriber(email, null);
            }
        }

        response.sendRedirect(request.getContextPath() + "/report");
    }
}