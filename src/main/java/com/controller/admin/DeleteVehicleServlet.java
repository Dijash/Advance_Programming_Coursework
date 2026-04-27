package com.controller.admin;

import com.service.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteVehicle")
public class DeleteVehicleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processDelete(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processDelete(request, response);
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String vehicleIdStr = request.getParameter("id");
        if (vehicleIdStr == null || vehicleIdStr.isEmpty()) {
            vehicleIdStr = request.getParameter("vehicle_id");
        }

        HttpSession session = request.getSession();

        if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {
            try {
                int vehicleId = Integer.parseInt(vehicleIdStr);

                VehicleService vehicleService = new VehicleService();
                boolean isDeleted = vehicleService.deleteVehicle(vehicleId);

                if (isDeleted) {
                    session.setAttribute("successMsg", "Vehicle deleted successfully!");
                } else {
                    session.setAttribute("errorMsg", "Could not delete vehicle. It is currently attached to a customer booking.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Invalid vehicle ID format.");
            }
        } else {
            session.setAttribute("errorMsg", "No vehicle ID provided.");
        }

        response.sendRedirect(request.getContextPath() + "/manageVehicles");
    }
}