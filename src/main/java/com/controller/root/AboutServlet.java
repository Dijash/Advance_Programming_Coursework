package com.controller.root;

import com.service.CustomerService;
import com.service.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {

    private VehicleService vehicleService;
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        vehicleService = new VehicleService();
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalVehicles = vehicleService.getTotalVehicleCount();
        int totalCustomers = customerService.getTotalCustomerCount();

        request.setAttribute("totalVehicles", totalVehicles);
        request.setAttribute("totalCustomers", totalCustomers);

        request.getRequestDispatcher("/Pages/Root/About.jsp").forward(request, response);
    }
}