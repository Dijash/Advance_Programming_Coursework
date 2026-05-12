package com.controller.admin;

import com.service.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;

/*
 * UpdateVehicleServlet handles updating vehicle details
 * in the admin panel.
 *
 * URL Mapping:
 *    /updateVehicle
 *
 * Features:
 * 1. Receives updated vehicle information from form
 * 2. Handles image file upload
 * 3. Updates vehicle data using VehicleService
 * 4. Stores success/error messages in session
 * 5. Redirects user based on operation result
 */
@WebServlet("/updateVehicle")

/*
 * MultipartConfig enables file upload support.
 *
 * fileSizeThreshold:
 *    Size threshold after which files are written to disk
 *
 * maxFileSize:
 *    Maximum size allowed for uploaded file
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10
)
public class UpdateVehicleServlet extends HttpServlet {

    /*
     * Handles HTTP POST requests for updating vehicles.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Get current session object for storing messages.
         */
        HttpSession session = request.getSession();

        /*
         * Retrieve vehicle ID from request parameter.
         */
        String vehicleIdStr = request.getParameter("vehicle_id");

        /*
         * Validate vehicle ID.
         * If missing, redirect back to manage vehicles page.
         */
        if (vehicleIdStr == null || vehicleIdStr.trim().isEmpty()) {

            session.setAttribute(
                    "errorMsg",
                    "System Error: Vehicle ID is missing."
            );

            response.sendRedirect(request.getContextPath() + "/manageVehicles");
            return;
        }

        try {

            /*
             * Convert vehicle ID from String to integer.
             */
            int vehicleId = Integer.parseInt(vehicleIdStr);

            /*
             * Retrieve updated vehicle details from form.
             */
            String brand = request.getParameter("vehicle_brand");
            String type = request.getParameter("vehicle_type");
            String color = request.getParameter("vehicle_color");
            String numberPlate = request.getParameter("vehicle_numberPlate");
            String condition = request.getParameter("vehicle_condition");
            String status = request.getParameter("vehicle_status");

            /*
             * Convert vehicle price to double.
             */
            double price = Double.parseDouble(
                    request.getParameter("vehicle_price")
            );

            /*
             * Retrieve existing image name from hidden form field.
             * This will be used if no new image is uploaded.
             */
            String fileName = request.getParameter("existing_image");

            /*
             * Retrieve uploaded image file.
             */
            Part filePart = request.getPart("vehicle_image");

            /*
             * Check whether a new image has been uploaded.
             */
            if (filePart != null && filePart.getSize() > 0) {

                /*
                 * Get uploaded file name.
                 */
                fileName = filePart.getSubmittedFileName();

                /*
                 * Define upload directory path.
                 */
                String uploadPath =
                        getServletContext().getRealPath("")
                                + File.separator
                                + "Assets";

                /*
                 * Create Assets directory if it does not exist.
                 */
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                /*
                 * Save uploaded image file to Assets folder.
                 */
                filePart.write(uploadPath + File.separator + fileName);
            }

            /*
             * Create VehicleService object for business logic.
             */
            VehicleService vehicleService = new VehicleService();

            /*
             * Update vehicle details in database.
             */
            boolean isSuccess = vehicleService.updateVehicle(
                    vehicleId,
                    brand,
                    type,
                    color,
                    numberPlate,
                    condition,
                    status,
                    fileName,
                    price
            );

            /*
             * Check whether update operation was successful.
             */
            if (isSuccess) {

                /*
                 * Store success message in session.
                 */
                session.setAttribute(
                        "successMsg",
                        "Vehicle details updated successfully!"
                );

                /*
                 * Redirect to manage vehicles page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/manageVehicles"
                );

            } else {

                /*
                 * Store database error message in session.
                 */
                session.setAttribute(
                        "errorMsg",
                        "Database Error: Could not update the vehicle."
                );

                /*
                 * Redirect back to edit vehicle page.
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/editVehicle?id="
                                + vehicleId
                );
            }

        } catch (NumberFormatException e) {

            /*
             * Handles invalid number formats such as:
             * - vehicle ID
             * - vehicle price
             */
            session.setAttribute(
                    "errorMsg",
                    "Invalid Vehicle ID or Price format."
            );

            /*
             * Redirect back to manage vehicles page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/manageVehicles"
            );
        }
    }
}