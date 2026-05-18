package com.controller.user;

import com.DAO.UserDashboardDAO;
import com.DAO.NotificationDAO;
import com.DAO.FavoriteDAO;

import com.model.Booking;
import com.model.Customer;
import com.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/*
 * Main User Controller Servlet
 *
 * This servlet handles all user-related pages such as:
 * - User dashboard
 * - My bookings
 * - Booking details view
 * - Favorites page
 * - Settings page
 *
 * URL Mappings:
 *      /userDashboard
 *      /myBookings
 *      /settings
 *      /viewUserBooking
 *      /myFavorites
 */
@WebServlet({
        "/userDashboard",
        "/myBookings",
        "/settings",
        "/viewUserBooking",
        "/myFavorites"
})
public class UserServlet extends HttpServlet {

    /*
     * DAO for user dashboard operations.
     */
    private UserDashboardDAO userDAO;

    /*
     * DAO for favorite vehicles operations.
     */
    private FavoriteDAO favoriteDAO;

    /*
     * Initializes servlet resources.
     *
     * Workflow:
     * 1. Create UserDashboardDAO instance.
     * 2. Create FavoriteDAO instance.
     */
    @Override
    public void init() throws ServletException {

        /*
         * Initialize UserDashboardDAO.
         */
        userDAO = new UserDashboardDAO();

        /*
         * Initialize FavoriteDAO.
         */
        favoriteDAO = new FavoriteDAO();
    }

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Validate user session.
     * 2. Identify requested page.
     * 3. Load required data from DAO layer.
     * 4. Forward to corresponding JSP page.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         */
        HttpSession session =
                request.getSession(false);

        /*
         * Retrieve logged-in customer.
         */
        Customer loggedInUser =
                (session != null)
                        ? (Customer) session.getAttribute("user")
                        : null;

        /*
         * Check authentication.
         */
        if (loggedInUser == null) {

            /*
             * Redirect unauthenticated user to login page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            /*
             * Stop execution.
             */
            return;
        }

        /*
         * Get customer ID.
         */
        int customerId =
                loggedInUser.getCustomer_id();

        /*
         * Get requested servlet path.
         */
        String path =
                request.getServletPath();

        /*
         * Create NotificationDAO for user notifications.
         */
        NotificationDAO notifDAO =
                new NotificationDAO();

        /*
         * Store notification data for UI display.
         */
        request.setAttribute(
                "totalNotifCount",
                notifDAO.getTotalNotificationCount()
        );

        request.setAttribute(
                "recentNotifs",
                notifDAO.getRecentNotifications()
        );

        /*
         * Route request based on URL path.
         */
        switch (path) {

            /*
             * User Dashboard Section
             */
            case "/userDashboard":
                System.out.println("UserServlet is running! The path is: " + request.getServletPath());

                /*
                 * Retrieve dashboard statistics.
                 */
                int activeCount =
                        userDAO.getActiveBookingsCount(customerId);

                int completedCount =
                        userDAO.getCompletedTripsCount(customerId);

                double totalSpent =
                        userDAO.getTotalSpent(customerId);

                List<Booking> recentBookings =
                        userDAO.getRecentBookings(customerId);

                /*
                 * Set dashboard attributes.
                 */
                request.setAttribute(
                        "activeBookingsCount",
                        activeCount
                );

                request.setAttribute(
                        "completedTripsCount",
                        completedCount
                );

                request.setAttribute(
                        "totalSpent",
                        totalSpent
                );

                request.setAttribute(
                        "userRecentBookings",
                        recentBookings
                );

                /*
                 * Forward to dashboard page.
                 */
                request.getRequestDispatcher(
                                "/WEB-INF/Pages/User/Dashboard/dashboard.jsp")
                        .forward(request, response);
                break;

            /*
             * My Bookings Section
             */
            case "/myBookings":

                /*
                 * Retrieve all bookings for user.
                 */
                List<Booking> allBookings =
                        userDAO.getAllUserBookings(customerId);

                /*
                 * Store booking list.
                 */
                request.setAttribute(
                        "userAllBookings",
                        allBookings
                );

                /*
                 * Forward to bookings page.
                 */
                request.getRequestDispatcher(
                                "/WEB-INF/Pages/User/Booking/myBookings.jsp")
                        .forward(request, response);
                break;

            /*
             * View Single Booking Details Section
             */
            case "/viewUserBooking":

                /*
                 * Retrieve booking ID from request.
                 */
                String bookingIdStr =
                        request.getParameter("id");

                /*
                 * Validate booking ID.
                 */
                if (bookingIdStr != null) {

                    try {

                        /*
                         * Convert booking ID to integer.
                         */
                        int bId =
                                Integer.parseInt(bookingIdStr);

                        /*
                         * Retrieve all user bookings.
                         */
                        List<Booking> userBookings =
                                userDAO.getAllUserBookings(customerId);

                        /*
                         * Find specific booking by ID.
                         */
                        Booking singleBooking =
                                userBookings.stream()
                                        .filter(b -> b.getBookingId() == bId)
                                        .findFirst()
                                        .orElse(null);

                        /*
                         * If booking exists, show details.
                         */
                        if (singleBooking != null) {

                            request.setAttribute(
                                    "bookingDetails",
                                    singleBooking
                            );

                            request.getRequestDispatcher(
                                            "/WEB-INF/Pages/User/Booking/bookingDetails.jsp")
                                    .forward(request, response);

                        } else {

                            /*
                             * Redirect if booking not found.
                             */
                            response.sendRedirect(
                                    request.getContextPath()
                                            + "/myBookings"
                            );
                        }

                    } catch (NumberFormatException e) {

                        /*
                         * Handle invalid booking ID format.
                         */
                        response.sendRedirect(
                                request.getContextPath()
                                        + "/myBookings"
                        );
                    }

                } else {

                    /*
                     * Redirect if ID is missing.
                     */
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/myBookings"
                    );
                }

                break;

            /*
             * My Favorites Section
             */
            case "/myFavorites":

                /*
                 * Retrieve favorite vehicles.
                 */
                List<Vehicle> favoriteVehicles =
                        favoriteDAO.getFavoriteVehiclesByCustomerId(
                                customerId
                        );

                /*
                 * Store favorite vehicles.
                 */
                request.setAttribute(
                        "favoriteVehicles",
                        favoriteVehicles
                );

                /*
                 * Forward to favorites page.
                 */
                request.getRequestDispatcher(
                                "/WEB-INF/Pages/User/Dashboard/myFavorites.jsp")
                        .forward(request, response);
                break;

            /*
             * Settings Page Section
             */
            case "/settings":

                /*
                 * Forward to settings page.
                 */
                request.getRequestDispatcher(
                                "/WEB-INF/Pages/User/Dashboard/settings.jsp")
                        .forward(request, response);
                break;

            /*
             * Default Redirect
             */
            default:

                /*
                 * Redirect unknown paths to dashboard.
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/userDashboard"
                );
                break;
        }
    }
}