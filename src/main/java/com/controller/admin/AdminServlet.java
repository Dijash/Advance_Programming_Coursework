package com.controller.admin;

import com.service.*;
import com.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/*
 * Main Admin Controller Servlet
 *
 * This servlet handles all admin-related requests such as:
 * - Dashboard management
 * - Booking management
 * - Vehicle management
 * - Customer management
 * - Review management
 * - Notification management
 *
 * URL Mappings:
 *      /admin
 *      /manageBooking
 *      /viewBooking
 *      /editBooking
 *      /updateBooking
 *      /deleteBooking
 *      /manageVehicles
 *      /addVehicle
 *      /viewVehicle
 *      /editVehicle
 *      /manageCustomers
 *      /viewCustomer
 *      /deleteCustomer
 *      /manageReviews
 *      /deleteReview
 *      /manageNotification
 *      /sendNotification
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

    /*
     * Handles all HTTP GET requests.
     *
     * Workflow:
     * 1. Identify request path.
     * 2. Execute operation based on URL mapping.
     * 3. Retrieve required data using service classes.
     * 4. Store data in request attributes.
     * 5. Forward request to corresponding JSP page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve servlet path from request.
         * Example:
         *      /admin
         *      /manageBooking
         */
        String path = request.getServletPath();

        /*
         * Create BookingService object.
         */
        BookingService bookingService = new BookingService();

        /*
         * Execute different functionality
         * based on request path.
         */
        switch (path) {

            /*
             * Admin Dashboard Section
             */
            case "/admin":

                /*
                 * Create service objects.
                 */
                AdminDashboardService dashboardService = new AdminDashboardService();
                NotificationService notifService = new NotificationService();

                /*
                 * Retrieve dashboard statistics
                 * and store them in request attributes.
                 */
                request.setAttribute("totalBookings", dashboardService.getTotalBookings());
                request.setAttribute("totalVehicles", dashboardService.getTotalVehicles());
                request.setAttribute("totalRevenue", dashboardService.getTotalRevenue());
                request.setAttribute("activeRentalsCount", dashboardService.getActiveRentalsCount());
                request.setAttribute("totalNotifCount", notifService.getTotalNotificationCount());

                /*
                 * Retrieve recent notifications.
                 */
                List<Notification> recentNotifs = notifService.getRecentNotifications();

                /*
                 * Prevent NullPointerException
                 * by checking if list is not null and not empty.
                 */
                if (recentNotifs != null && !recentNotifs.isEmpty()) {

                    /*
                     * Store latest notification.
                     */
                    request.setAttribute("latestNotif", recentNotifs.get(0));
                }

                /*
                 * Retrieve additional dashboard data.
                 */
                request.setAttribute("upcomingReturns", dashboardService.getUpcomingReturns());
                request.setAttribute("topVehicle", dashboardService.getTopVehicle());

                /*
                 * Forward request to admin dashboard page.
                 */
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Dashboard/admin.jsp")
                        .forward(request, response);
                break;

            /*
             * Manage Booking Section
             */
            case "/manageBooking":

                /*
                 * Retrieve all bookings.
                 */
                request.setAttribute("bookings", bookingService.getAllBookings());

                /*
                 * Forward to booking management page.
                 */
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Booking/manageBooking.jsp")
                        .forward(request, response);
                break;

            /*
             * View Booking or Edit Booking Section
             */
            case "/viewBooking":
            case "/editBooking":

                /*
                 * Retrieve booking ID from request.
                 */
                String bIdStr = request.getParameter("id");

                /*
                 * Check whether ID exists.
                 */
                if (bIdStr != null) {

                    /*
                     * Convert ID to integer
                     * and retrieve booking details.
                     */
                    request.setAttribute(
                            "booking",
                            bookingService.getBookingById(Integer.parseInt(bIdStr))
                    );
                }

                /*
                 * Determine target JSP page.
                 */
                String target = path.equals("/viewBooking")
                        ? "/WEB-INF/Pages/Admin/Booking/viewBooking.jsp"
                        : "/WEB-INF/Pages/Admin/Booking/editBooking.jsp";

                /*
                 * Forward request.
                 */
                request.getRequestDispatcher(target)
                        .forward(request, response);
                break;

            /*
             * Manage Vehicle Section
             */
            case "/manageVehicles":

                /*
                 * Create VehicleService object.
                 */
                VehicleService vServiceList = new VehicleService();

                /*
                 * Retrieve all vehicles.
                 */
                request.setAttribute("vehicles", vServiceList.getAllVehicles());

                /*
                 * Forward to vehicle management page.
                 */
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Vehicle/manageVehicle.jsp")
                        .forward(request, response);
                break;
            case "/addVehicle":
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Vehicle/addVehicle.jsp")
                        .forward(request, response);
                break;

            /*
             * View Vehicle or Edit Vehicle Section
             */
            case "/viewVehicle":
            case "/editVehicle":

                /*
                 * Retrieve vehicle ID.
                 */
                String vehicleIdStr = request.getParameter("id");

                /*
                 * Validate vehicle ID.
                 */
                if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {

                    /*
                     * Create VehicleService object.
                     */
                    VehicleService vService = new VehicleService();

                    /*
                     * Retrieve vehicle details.
                     */
                    request.setAttribute(
                            "vehicle",
                            vService.getVehicleById(Integer.parseInt(vehicleIdStr))
                    );
                }

                /*
                 * Determine target page.
                 */
                String vTarget = path.equals("/editVehicle")
                        ? "/WEB-INF/Pages/Admin/Vehicle/editVehicle.jsp"
                        : "/WEB-INF/Pages/Admin/Vehicle/viewVehicle.jsp";

                /*
                 * Forward request.
                 */
                request.getRequestDispatcher(vTarget)
                        .forward(request, response);
                break;

            /*
             * Manage Customers Section
             */
            case "/manageCustomers":

                /*
                 * Create CustomerService object.
                 */
                CustomerService customerService = new CustomerService();

                /*
                 * Retrieve search query.
                 */
                String searchQuery = request.getParameter("search");

                /*
                 * Check whether search query exists.
                 */
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {

                    /*
                     * Search customers using query.
                     */
                    request.setAttribute(
                            "customers",
                            customerService.searchCustomers(searchQuery.trim())
                    );

                    /*
                     * Store search query.
                     */
                    request.setAttribute("searchQuery", searchQuery);

                } else {

                    /*
                     * Retrieve all customers.
                     */
                    request.setAttribute(
                            "customers",
                            customerService.getAllCustomers()
                    );
                }

                /*
                 * Forward to customer page.
                 */
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Customer/customer.jsp")
                        .forward(request, response);
                break;

            /*
             * View Customer Section
             */
            case "/viewCustomer":

                /*
                 * Retrieve customer ID.
                 */
                String cIdParam = request.getParameter("id");

                /*
                 * Validate customer ID.
                 */
                if (cIdParam != null) {

                    /*
                     * Create CustomerService object.
                     */
                    CustomerService cService = new CustomerService();

                    /*
                     * Retrieve customer details.
                     */
                    request.setAttribute(
                            "customer",
                            cService.getCustomerById(Integer.parseInt(cIdParam))
                    );
                }

                /*
                 * Forward to customer view page.
                 */
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Customer/viewCustomer.jsp")
                        .forward(request, response);
                break;

            /*
             * Manage Notification Section
             */
            case "/manageNotification":

                /*
                 * Create NotificationService object.
                 */
                NotificationService notifListService = new NotificationService();

                /*
                 * Retrieve all notifications.
                 */
                request.setAttribute(
                        "notifHistory",
                        notifListService.getAllNotifications()
                );

                /*
                 * Forward to notification page.
                 */
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Notification/notification.jsp")
                        .forward(request, response);
                break;

            /*
             * Manage Review Section
             */
            case "/manageReviews":

                /*
                 * Create ReviewService object.
                 */
                ReviewService reviewService = new ReviewService();

                /*
                 * Retrieve all reviews.
                 */
                request.setAttribute("reviews", reviewService.getAllReviews());

                /*
                 * Forward to reviews page.
                 */
                request.getRequestDispatcher("/WEB-INF/Pages/Admin/Review/reviews.jsp")
                        .forward(request, response);
                break;

            /*
             * Default case
             */
            default:

                /*
                 * Forward unknown requests to homepage.
                 */
                request.getRequestDispatcher("/index.jsp")
                        .forward(request, response);
                break;
        }
    }

    /*
     * Handles all HTTP POST requests.
     *
     * Workflow:
     * 1. Identify request path.
     * 2. Retrieve form data.
     * 3. Execute requested operation.
     * 4. Redirect user after completion.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve servlet path.
         */
        String path = request.getServletPath();

        /*
         * Create service objects.
         */
        BookingService bookingService = new BookingService();
        CustomerService customerService = new CustomerService();
        NotificationService notificationService = new NotificationService();

        /*
         * Execute operations
         * based on request path.
         */
        switch (path) {

            /*
             * Send Notification Section
             */
            case "/sendNotification":

                /*
                 * Retrieve notification subject and message.
                 */
                String type = request.getParameter("subject");
                String desc = request.getParameter("message");

                /*
                 * Validate inputs.
                 */
                if (type != null && desc != null) {

                    /*
                     * Send broadcast notification.
                     */
                    notificationService.sendBroadcast(type, desc);
                }

                /*
                 * Redirect to notification management page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/manageNotification"
                );
                break;

            /*
             * Delete Review Section
             */
            case "/deleteReview":

                /*
                 * Retrieve review ID.
                 */
                String idParam = request.getParameter("reviewId");

                /*
                 * Validate review ID.
                 */
                if (idParam != null && !idParam.isEmpty()) {

                    /*
                     * Delete review.
                     */
                    new ReviewService().deleteReview(
                            Integer.parseInt(idParam)
                    );
                }

                /*
                 * Redirect to reviews page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/manageReviews"
                );
                break;

            /*
             * Update Booking Section
             */
            case "/updateBooking":

                /*
                 * Retrieve booking ID and new status.
                 */
                int updateId = Integer.parseInt(
                        request.getParameter("booking_id")
                );

                String newStatus = request.getParameter("status");

                /*
                 * Update booking status.
                 */
                bookingService.updateBookingStatus(updateId, newStatus);

                /*
                 * Redirect to booking management page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/manageBooking"
                );
                break;

            /*
             * Delete Booking Section
             */
            case "/deleteBooking":

                /*
                 * Retrieve booking ID.
                 */
                int delBId = Integer.parseInt(
                        request.getParameter("booking_id")
                );

                /*
                 * Delete booking.
                 */
                bookingService.deleteBooking(delBId);

                /*
                 * Redirect to booking page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/manageBooking"
                );
                break;

            /*
             * Delete Customer Section
             */
            case "/deleteCustomer":

                /*
                 * Retrieve customer ID.
                 */
                String cIdStr = request.getParameter("customer_id");

                /*
                 * Validate customer ID.
                 */
                if (cIdStr != null && !cIdStr.isEmpty()) {

                    /*
                     * Delete customer.
                     */
                    customerService.deleteCustomer(
                            Integer.parseInt(cIdStr)
                    );
                }

                /*
                 * Redirect to customer management page.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/manageCustomers"
                );
                break;

            /*
             * Default Case
             */
            default:

                /*
                 * Redirect unknown requests
                 * back to admin dashboard.
                 */
                response.sendRedirect(
                        request.getContextPath() + "/admin"
                );
                break;
        }
    }
}