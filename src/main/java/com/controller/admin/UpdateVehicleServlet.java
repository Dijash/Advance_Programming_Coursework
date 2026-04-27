package com.controller.admin;

import com.service.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/updateVehicle")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10)
public class UpdateVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String vehicleIdStr = request.getParameter("vehicle_id");

        if (vehicleIdStr == null || vehicleIdStr.trim().isEmpty()) {
            session.setAttribute("errorMsg", "System Error: Vehicle ID is missing.");
            response.sendRedirect(request.getContextPath() + "/manageVehicles");
            return;
        }

        try {
            int vehicleId = Integer.parseInt(vehicleIdStr);
            String brand = request.getParameter("vehicle_brand");
            String type = request.getParameter("vehicle_type");
            String color = request.getParameter("vehicle_color");
            String numberPlate = request.getParameter("vehicle_numberPlate");
            String condition = request.getParameter("vehicle_condition");
            String status = request.getParameter("vehicle_status");

            String fileName = request.getParameter("existing_image");
            Part filePart = request.getPart("vehicle_image");

            if (filePart != null && filePart.getSize() > 0) {
                fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "Assets";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                filePart.write(uploadPath + File.separator + fileName);
            }

            VehicleService vehicleService = new VehicleService();
            boolean isSuccess = vehicleService.updateVehicle(vehicleId, brand, type, color, numberPlate, condition, status, fileName);

            if (isSuccess) {
                session.setAttribute("successMsg", "Vehicle details updated successfully!");
                response.sendRedirect(request.getContextPath() + "/manageVehicles");
            } else {
                session.setAttribute("errorMsg", "Database Error: Could not update the vehicle.");
                response.sendRedirect(request.getContextPath() + "/editVehicle?id=" + vehicleId);
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid Vehicle ID.");
            response.sendRedirect(request.getContextPath() + "/manageVehicles");
        }
    }
}