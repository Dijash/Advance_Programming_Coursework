package com.controller.root;

import com.service.CustomerService;
import com.service.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * the About page functionality.
 *
 * URL Mapping:
 *      /about
 *
 * Features:
 * - Retrieves total vehicle count
 * - Retrieves total customer count
 * - Sends data to About page
 */
@WebServlet("/about")
public class AboutServlet extends HttpServlet {

    /*
     * Service object for vehicle-related operations.
     */
    private VehicleService vehicleService;

    /*
     * Service object for customer-related operations.
     */
    private CustomerService customerService;

    /*
     * Initializes servlet resources.
     *
     * Workflow:
     * 1. Create VehicleService object.
     * 2. Create CustomerService object.
     */
    @Override
    public void init() throws ServletException {

        /*
         * Initialize VehicleService.
         */
        vehicleService = new VehicleService();

        /*
         * Initialize CustomerService.
         */
        customerService = new CustomerService();
    }

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Retrieve total vehicle count.
     * 2. Retrieve total customer count.
     * 3. Store values in request attributes.
     * 4. Forward request to About page.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve total number of vehicles.
         */
        int totalVehicles =
                vehicleService.getTotalVehicleCount();

        /*
         * Retrieve total number of customers.
         */
        int totalCustomers =
                customerService.getTotalCustomerCount();

        /*
         * Store vehicle count in request attribute.
         */
        request.setAttribute(
                "totalVehicles",
                totalVehicles
        );

        /*
         * Store customer count in request attribute.
         */
        request.setAttribute(
                "totalCustomers",
                totalCustomers
        );

        /*
         * Forward request to About page.
         */
        request.getRequestDispatcher("/Pages/Root/About.jsp")
                .forward(request, response);
    }
}