package com.controller.admin;

import com.service.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/*
 * Servlet responsible for deleting vehicles.
 *
 * URL Mapping:
 *      /deleteVehicle
 *
 * This servlet accepts both GET and POST requests
 * and removes a vehicle record from the system
 * using the VehicleService class.
 */
@WebServlet("/deleteVehicle")
public class DeleteVehicleServlet extends HttpServlet {

    /*
     * Handles HTTP GET requests.
     * Calls the common delete processing method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processDelete(request, response);
    }

    /*
     * Handles HTTP POST requests.
     * Calls the same delete processing method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processDelete(request, response);
    }

    /*
     * Common method used by both GET and POST requests.
     *
     * Workflow:
     * 1. Retrieve vehicle ID from request.
     * 2. Validate vehicle ID.
     * 3. Call VehicleService to delete the vehicle.
     * 4. Store success/error messages in session.
     * 5. Redirect back to vehicle management page.
     */
    private void processDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        /*
         * Retrieve vehicle ID from request parameter.
         * Supports both:
         *      id
         *      vehicle_id
         */
        String vehicleIdStr = request.getParameter("id");

        /*
         * If "id" parameter is missing,
         * try alternative parameter name.
         */
        if (vehicleIdStr == null || vehicleIdStr.isEmpty()) {
            vehicleIdStr = request.getParameter("vehicle_id");
        }

        /*
         * Get current session object.
         * Used for storing success/error messages.
         */
        HttpSession session = request.getSession();

        /*
         * Check whether vehicle ID exists.
         */
        if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {

            try {

                /*
                 * Convert vehicle ID from String to Integer.
                 * May throw NumberFormatException
                 * if value is invalid.
                 */
                int vehicleId = Integer.parseInt(vehicleIdStr);

                /*
                 * Create VehicleService object.
                 */
                VehicleService vehicleService = new VehicleService();

                /*
                 * Attempt to delete vehicle from database.
                 */
                boolean isDeleted = vehicleService.deleteVehicle(vehicleId);

                /*
                 * Check deletion result and set
                 * appropriate session message.
                 */
                if (isDeleted) {

                    /*
                     * Vehicle deleted successfully.
                     */
                    session.setAttribute(
                            "successMsg",
                            "Vehicle deleted successfully!"
                    );

                } else {

                    /*
                     * Vehicle could not be deleted,
                     * possibly due to booking dependency.
                     */
                    session.setAttribute(
                            "errorMsg",
                            "Could not delete vehicle. It is currently attached to a customer booking."
                    );
                }

            } catch (NumberFormatException e) {

                /*
                 * Handles invalid ID format.
                 * Example:
                 *      id=abc
                 */
                session.setAttribute(
                        "errorMsg",
                        "Invalid vehicle ID format."
                );
            }

        } else {

            /*
             * No vehicle ID was provided in request.
             */
            session.setAttribute(
                    "errorMsg",
                    "No vehicle ID provided."
            );
        }

        /*
         * Redirect user back to vehicle management page.
         */
        response.sendRedirect(
                request.getContextPath() + "/manageVehicles"
        );
    }
}