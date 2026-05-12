package com.controller.admin;

import com.service.*;
import com.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * AdminServlet
 * This servlet acts as the central controller for the administration panel.
 * It handles routing for all administrative tasks including dashboard metrics,
 * vehicle management, booking administration, customer data viewing,
 * review moderation, and system notifications.
 */
@WebServlet({
        "/admin",
        "/manageBooking", "/viewBooking", "/editBooking", "/updateBooking", "/deleteBooking",
        "/manageVehicles", "/addVehicle", "/viewVehicle", "/editVehicle",
        "/manageCustomers", "/viewCustomer", "/deleteCustomer",
        "/manageReviews", "/deleteReview",
        "/manageNotification", "/sendNotification"
})
public class AdminServlet extends HttpServlet {

    /**
     * Handles HTTP GET requests.
     * <p>
     * This method is responsible for routing the user to the appropriate
     * JSP pages based on the requested URL path. It initializes necessary
     * services, retrieves required data from the database, and sets them
     * as request attributes before forwarding the request to the view layer.
     *
     * @param request  the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        /*
         * Initialize BookingService to be used across multiple cases
         * for fetching booking-related information.
         */
        BookingService bookingService = new BookingService();

        switch (path) {

            /**
             * Admin Dashboard Route
             * Aggregates general statistics (bookings, revenue, vehicles, notifications)
             * and forwards to the main dashboard view.
             */
            case "/admin":

                AdminDashboardService dashboardService = new AdminDashboardService();
                NotificationService notifService = new NotificationService();

                request.setAttribute("totalBookings", dashboardService.getTotalBookings());
                request.setAttribute("totalVehicles", dashboardService.getTotalVehicles());
                request.setAttribute("totalRevenue", dashboardService.getTotalRevenue());
                request.setAttribute("activeRentalsCount", dashboardService.getActiveRentalsCount());

                request.setAttribute("totalNotifCount", notifService.getTotalNotificationCount());

                /* Fetch and set the most recent notification to display as an alert/badge */
                List<Notification> recentNotifs = notifService.getRecentNotifications();

                if (!recentNotifs.isEmpty()) {
                    request.setAttribute("latestNotif", recentNotifs.get(0));
                }

                /* Dashboard Data */
                request.setAttribute("upcomingReturns", dashboardService.getUpcomingReturns());
                request.setAttribute("topVehicle", dashboardService.getTopVehicle());

                request.getRequestDispatcher("/Pages/Admin/Dashboard/admin.jsp")
                        .forward(request, response);
                break;

            /**
             * Add Vehicle Route
             * Forwards the administrator to the form for adding a new vehicle.
             */
            case "/addVehicle":

                request.getRequestDispatcher("/Pages/Admin/Vehicle/addVehicle.jsp")
                        .forward(request, response);
                break;

            /**
             * Manage Booking Route
             * Retrieves all current bookings and forwards to the booking management table.
             */
            case "/manageBooking":

                request.setAttribute("bookings", bookingService.getAllBookings());

                request.getRequestDispatcher("/Pages/Admin/Booking/manageBooking.jsp")
                        .forward(request, response);
                break;

            /**
             * View or Edit Booking Route
             * Checks for an ID parameter, fetches the specific booking details,
             * and routes to either the read-only view or the editable form.
             */
            case "/viewBooking":
            case "/editBooking":

                String bIdStr = request.getParameter("id");

                if (bIdStr != null) {
                    request.setAttribute(
                            "booking",
                            bookingService.getBookingById(Integer.parseInt(bIdStr))
                    );
                }

                String target = path.equals("/viewBooking")
                        ? "/Pages/Admin/Booking/viewBooking.jsp"
                        : "/Pages/Admin/Booking/editBooking.jsp";

                request.getRequestDispatcher(target)
                        .forward(request, response);

                break;

            /**
             * Manage Vehicles Route
             * Retrieves the entire fleet inventory and forwards to the vehicle management view.
             */
            case "/manageVehicles":

                VehicleService vServiceList = new VehicleService();

                request.setAttribute("vehicles", vServiceList.getAllVehicles());

                request.getRequestDispatcher("/Pages/Admin/Vehicle/manageVehicle.jsp")
                        .forward(request, response);

                break;

            /**
             * View or Edit Vehicle Route
             * Fetches details for a specific vehicle by ID and directs the request
             * to the corresponding view or edit JSP page.
             */
            case "/viewVehicle":
            case "/editVehicle":

                String vehicleIdStr = request.getParameter("id");

                if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {

                    VehicleService vService = new VehicleService();

                    request.setAttribute(
                            "vehicle",
                            vService.getVehicleById(Integer.parseInt(vehicleIdStr))
                    );
                }

                String vTarget = path.equals("/editVehicle")
                        ? "/Pages/Admin/Vehicle/editVehicle.jsp"
                        : "/Pages/Admin/Vehicle/viewVehicle.jsp";

                request.getRequestDispatcher(vTarget)
                        .forward(request, response);

                break;

            /**
             * Manage Customers Route
             * Loads all registered customer profiles into the request attribute
             * before forwarding to the customer list page.
             */
            case "/manageCustomers":

                CustomerService customerService = new CustomerService();

                request.setAttribute("customers", customerService.getAllCustomers());

                request.getRequestDispatcher("/Pages/Admin/Customer/customer.jsp")
                        .forward(request, response);

                break;

            /**
             * View Customer Route
             * Extracts the customer ID, retrieves the associated user profile,
             * and displays the detailed customer view.
             */
            case "/viewCustomer":

                String cIdParam = request.getParameter("id");

                if (cIdParam != null) {

                    CustomerService cService = new CustomerService();

                    request.setAttribute(
                            "customer",
                            cService.getCustomerById(Integer.parseInt(cIdParam))
                    );
                }

                request.getRequestDispatcher("/Pages/Admin/Customer/viewCustomer.jsp")
                        .forward(request, response);

                break;

            /**
             * Manage Notifications Route
             * Fetches the history of all broadcasted notifications to be
             * displayed on the notification management page.
             */
            case "/manageNotification":

                NotificationService notifListService = new NotificationService();

                request.setAttribute(
                        "notifHistory",
                        notifListService.getAllNotifications()
                );

                request.getRequestDispatcher("/Pages/Admin/Notification/notification.jsp")
                        .forward(request, response);

                break;

            /**
             * Manage Reviews Route
             * Retrieves all user submitted reviews and feedback for moderation.
             */
            case "/manageReviews":

                ReviewService reviewService = new ReviewService();

                request.setAttribute("reviews", reviewService.getAllReviews());

                request.getRequestDispatcher("/Pages/Admin/Review/reviews.jsp")
                        .forward(request, response);

                break;

            /**
             * Default Route
             * Fallback mechanism that returns the user to the main index page
             * if an unrecognized GET request hits the servlet.
             */
            default:

                request.getRequestDispatcher("/index.jsp")
                        .forward(request, response);

                break;
        }
    }

    /**
     * Handles HTTP POST requests.
     * <p>
     * This method processes form submissions and state-changing actions from the
     * admin panel. This includes creating/sending notifications, updating statuses,
     * and deleting entities (reviews, bookings, customers). Upon completion,
     * it redirects the user back to the appropriate management page to prevent
     * duplicate form submissions.
     *
     * @param request  the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        /* Service Objects initialized for processing POST data */
        BookingService bookingService = new BookingService();
        CustomerService customerService = new CustomerService();
        NotificationService notificationService = new NotificationService();

        switch (path) {

            /**
             * Send Notification Action
             * Captures notification subject and message from the request body
             * and broadcasts it through the notification service.
             */
            case "/sendNotification":

                String type = request.getParameter("subject");
                String desc = request.getParameter("message");

                if (type != null && desc != null) {
                    notificationService.sendBroadcast(type, desc);
                }

                response.sendRedirect(
                        request.getContextPath() + "/manageNotification"
                );

                break;

            /**
             * Delete Review Action
             * Parses the review ID and removes the associated review record
             * from the database.
             */
            case "/deleteReview":

                String idParam = request.getParameter("reviewId");

                if (idParam != null && !idParam.isEmpty()) {

                    int id = Integer.parseInt(idParam);

                    ReviewService reviewService = new ReviewService();

                    reviewService.deleteReview(id);
                }

                response.sendRedirect(
                        request.getContextPath() + "/manageReviews"
                );

                break;

            /**
             * Update Booking Action
             * Modifies the status of an existing booking (e.g., pending, approved,
             * completed) based on admin input.
             */
            case "/updateBooking":

                int updateId = Integer.parseInt(
                        request.getParameter("booking_id")
                );

                String newStatus = request.getParameter("status");

                bookingService.updateBookingStatus(updateId, newStatus);

                response.sendRedirect(
                        request.getContextPath() + "/manageBooking"
                );

                break;

            /**
             * Delete Booking Action
             * Permanently removes a specific booking record from the system
             * based on the provided booking ID.
             */
            case "/deleteBooking":

                int delBId = Integer.parseInt(
                        request.getParameter("booking_id")
                );

                bookingService.deleteBooking(delBId);

                response.sendRedirect(
                        request.getContextPath() + "/manageBooking"
                );

                break;

            /**
             * Delete Customer Action
             * Removes a customer account and their associated profile details
             * from the application database.
             */
            case "/deleteCustomer":

                String cIdStr = request.getParameter("customer_id");

                if (cIdStr != null && !cIdStr.isEmpty()) {

                    customerService.deleteCustomer(
                            Integer.parseInt(cIdStr)
                    );
                }

                response.sendRedirect(
                        request.getContextPath() + "/manageCustomers"
                );

                break;

            /**
             * Default Redirect
             * Acts as a catch-all for unrecognized POST paths, sending the user
             * back to the main admin dashboard view safely.
             */
            default:

                response.sendRedirect(
                        request.getContextPath() + "/admin"
                );

                break;
        }
    }
}