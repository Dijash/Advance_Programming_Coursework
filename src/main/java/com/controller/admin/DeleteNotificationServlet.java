package com.controller.admin;

import com.service.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/*
 * Servlet responsible for deleting notifications.
 *
 * URL Mapping:
 *      /deleteNotification
 *
 * This servlet receives the notification ID from the request,
 * validates it, and calls the NotificationService to remove
 * the notification from the database.
 */
@WebServlet("/deleteNotification")
public class DeleteNotificationServlet extends HttpServlet {

    /*
     * Handles HTTP GET requests for deleting a notification.
     *
     * Workflow:
     * 1. Get the current session.
     * 2. Retrieve notification ID from the request parameter.
     * 3. Validate and convert the ID into integer format.
     * 4. Call the service layer to delete the notification.
     * 5. Redirect the user with a success or error message.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         * 'false' prevents creating a new session if one does not exist.
         */
        HttpSession session = request.getSession(false);

        /*
         * Get notification ID from URL parameter.
         * Example:
         *      /deleteNotification?id=5
         */
        String idParam = request.getParameter("id");

        /*
         * Check whether the ID parameter exists and is not empty.
         */
        if (idParam != null && !idParam.isEmpty()) {

            try {

                /*
                 * Convert ID from String to Integer.
                 * This may throw NumberFormatException
                 * if the value is not numeric.
                 */
                int notificationId = Integer.parseInt(idParam);

                /*
                 * Create NotificationService object
                 * and call delete method.
                 */
                NotificationService notifService = new NotificationService();

                /*
                 * Attempt to delete notification.
                 * Returns true if deletion succeeds.
                 */
                boolean success = notifService.deleteNotification(notificationId);

                /*
                 * Redirect based on deletion result.
                 */
                if (success) {

                    /*
                     * Notification deleted successfully.
                     */
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/manageNotification?msg=deleted"
                    );

                } else {

                    /*
                     * Deletion failed.
                     */
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/manageNotification?error=delete_failed"
                    );
                }

            } catch (NumberFormatException e) {

                /*
                 * Handles invalid numeric conversion.
                 * Example:
                 *      id=abc
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/manageNotification?error=invalid_id"
                );
            }

        } else {

            /*
             * If the ID parameter is missing,
             * redirect back to the notification management page.
             */
            response.sendRedirect(
                    request.getContextPath()
                            + "/manageNotification"
            );
        }
    }
}