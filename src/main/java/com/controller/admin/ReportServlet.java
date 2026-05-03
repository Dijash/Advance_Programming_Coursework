package com.controller.admin;

import com.DAO.VehicleDAO;
import com.DAO.CustomerDAO;
import com.DAO.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        VehicleDAO vehicleDAO = new VehicleDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        BookingDAO bookingDAO = new BookingDAO();

        int totalVehicles = vehicleDAO.getTotalVehicleCount();
        int rentedVehicles = vehicleDAO.getVehicleCountByStatus("Rented");
        int maintenanceVehicles = vehicleDAO.getVehicleCountByStatus("Maintenance");
        int totalCustomers = customerDAO.getTotalCustomerCount();
        int totalBookings = bookingDAO.getTotalBookingCount();

        request.setAttribute("allBookingsList", bookingDAO.getAllBookings());

        request.setAttribute("totalVehicles", totalVehicles);
        request.setAttribute("rentedVehicles", rentedVehicles);
        request.setAttribute("maintenanceVehicles", maintenanceVehicles);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalBookings", totalBookings);

        request.getRequestDispatcher("/Pages/Admin/Report/report.jsp").forward(request, response);
    }
}