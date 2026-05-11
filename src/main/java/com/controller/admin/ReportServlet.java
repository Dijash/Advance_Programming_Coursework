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

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        VehicleDAO vehicleDAO = new VehicleDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        BookingDAO bookingDAO = new BookingDAO();
        ContactDAO contactDAO = new ContactDAO();

        int totalVehicles = vehicleDAO.getTotalVehicleCount();
        int rentedVehicles = vehicleDAO.getVehicleCountByStatus("Rented");
        int maintenanceVehicles = vehicleDAO.getVehicleCountByStatus("Maintenance");
        int totalCustomers = customerDAO.getTotalCustomerCount();
        int totalBookings = bookingDAO.getTotalBookingCount();

        request.setAttribute("allBookingsList", bookingDAO.getAllBookings());
        List<ContactMessage> contactMessagesList = contactDAO.getAllMessages();
        request.setAttribute("contactMessagesList", contactMessagesList);

        request.setAttribute("totalVehicles", totalVehicles);
        request.setAttribute("rentedVehicles", rentedVehicles);
        request.setAttribute("maintenanceVehicles", maintenanceVehicles);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalBookings", totalBookings);

        request.getRequestDispatcher("/Pages/Admin/Report/report.jsp").forward(request, response);
    }
}