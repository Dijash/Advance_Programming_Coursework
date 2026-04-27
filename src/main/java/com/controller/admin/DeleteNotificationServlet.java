package com.controller.admin;

import com.service.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteNotification")
public class DeleteNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        // Ensure to check admin auth if needed

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int notificationId = Integer.parseInt(idParam);

                AdminService adminService = new AdminService();
                boolean success = adminService.deleteNotification(notificationId);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/manageNotification?msg=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/manageNotification?error=delete_failed");
                }

            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/manageNotification?error=invalid_id");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/manageNotification");
        }
    }
}