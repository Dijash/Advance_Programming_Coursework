package com.controller.admin;

import com.service.NotificationService;
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

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int notificationId = Integer.parseInt(idParam);

                NotificationService notifService = new NotificationService();
                boolean success = notifService.deleteNotification(notificationId);

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