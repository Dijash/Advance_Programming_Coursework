package com.controller.admin;

import com.service.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;

/*
 * VehicleServlet handles adding new vehicle records
 * into the system.
 *
 * URL Mapping:
 *    /addVehicleData
 *
 * Features:
 * 1. Receives vehicle details from admin form
 * 2. Handles image upload functionality
 * 3. Stores vehicle information in database
 * 4. Displays success or error messages
 * 5. Redirects user after operation
 */
@WebServlet("/addVehicleData")

/*
 * MultipartConfig enables file upload support.
 *
 * fileSizeThreshold:
 *    Maximum size stored in memory before writing to disk
 *
 * maxFileSize:
 *    Maximum allowed uploaded file size
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10
)
public class VehicleServlet extends HttpServlet {

    /*
     * Handles HTTP POST requests for adding vehicles.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Get current session object for storing messages.
         */
        HttpSession session = request.getSession();

        try {

            /*
             * Retrieve vehicle details from request parameters.
             */
            String brand = request.getParameter("vehicle_brand");
            String type = request.getParameter("vehicle_type");
            String color = request.getParameter("vehicle_color");
            String numberPlate = request.getParameter("vehicle_numberPlate");
            String condition = request.getParameter("vehicle_condition");
            String status = request.getParameter("vehicle_status");

            /*
             * Convert vehicle price from String to double.
             */
            double price = Double.parseDouble(
                    request.getParameter("vehicle_price")
            );

            /*
             * Default admin ID.
             *
             * In a real system, this should come from
             * the logged-in admin session.
             */
            int adminId = 1;

            /*
             * Default image name used if no image is uploaded.
             */
            String fileName = "default_car.jpg";

            /*
             * Retrieve uploaded image file from request.
             */
            Part filePart = request.getPart("vehicle_image");

            /*
             * Check whether an image file has been uploaded.
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
                 * Create Assets folder if it does not exist.
                 */
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                /*
                 * Save uploaded image file inside Assets folder.
                 */
                filePart.write(uploadPath + File.separator + fileName);
            }

            /*
             * Create VehicleService object for business logic.
             */
            VehicleService vehicleService = new VehicleService();

            /*
             * Save vehicle details into database.
             */
            boolean isSuccess = vehicleService.addVehicle(
                    adminId,
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
             * Check whether vehicle was added successfully.
             */
            if (isSuccess) {

                /*
                 * Store success message in session.
                 */
                session.setAttribute(
                        "successMsg",
                        "Vehicle added successfully!"
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
                        "Database Error: Could not save vehicle."
                );

                /*
                 * Redirect back to add vehicle page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/addVehicle"
                );
            }

        } catch (NumberFormatException e) {

            /*
             * Handles invalid number format errors.
             * Example:
             * - invalid vehicle price
             */
            session.setAttribute(
                    "errorMsg",
                    "Invalid input: Please enter a valid number for the price."
            );

            /*
             * Redirect back to add vehicle page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/addVehicle"
            );
        }
    }
}