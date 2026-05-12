package com.controller.admin;

import com.DAO.VehicleDAO;
import com.DAO.CustomerDAO;
import com.DAO.BookingDAO;
import com.DAO.ContactDAO;
import com.model.ContactMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/*
 * ReportServlet handles the admin report dashboard.
 *
 * URL Mapping:
 *    /report
 *
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
        request.getRequestDispatcher("/Pages/Admin/Report/report.jsp")
                .forward(request, response);
    }
}