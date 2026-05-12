package com.controller.admin;

import com.service.*;
import com.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/* Admin Servlet Routes */
@WebServlet({
        "/admin",
        "/manageBooking", "/viewBooking", "/editBooking", "/updateBooking", "/deleteBooking",
        "/manageVehicles", "/addVehicle", "/viewVehicle", "/editVehicle",
        "/manageCustomers", "/viewCustomer", "/deleteCustomer",
        "/manageReviews", "/deleteReview",
        "/manageNotification", "/sendNotification"
})
public class AdminServlet extends HttpServlet {

    /* Handle GET Requests */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        /* Booking Service */
        BookingService bookingService = new BookingService();

        switch (path) {

            /* Admin Dashboard */
            case "/admin":

                AdminDashboardService dashboardService = new AdminDashboardService();
                NotificationService notifService = new NotificationService();

                request.setAttribute("totalBookings", dashboardService.getTotalBookings());
                request.setAttribute("totalVehicles", dashboardService.getTotalVehicles());
                request.setAttribute("totalRevenue", dashboardService.getTotalRevenue());
                request.setAttribute("activeRentalsCount", dashboardService.getActiveRentalsCount());

                request.setAttribute("totalNotifCount", notifService.getTotalNotificationCount());

                /* Recent Notifications */
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

            /* Add Vehicle Page */
            case "/addVehicle":

                request.getRequestDispatcher("/Pages/Admin/Vehicle/addVehicle.jsp")
                        .forward(request, response);
                break;

            /* Manage Booking Page */
            case "/manageBooking":

                request.setAttribute("bookings", bookingService.getAllBookings());

                request.getRequestDispatcher("/Pages/Admin/Booking/manageBooking.jsp")
                        .forward(request, response);
                break;

            /* View Or Edit Booking */
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

            /* Manage Vehicles Page */
            case "/manageVehicles":

                VehicleService vServiceList = new VehicleService();

                request.setAttribute("vehicles", vServiceList.getAllVehicles());

                request.getRequestDispatcher("/Pages/Admin/Vehicle/manageVehicle.jsp")
                        .forward(request, response);

                break;

            /* View Or Edit Vehicle */
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

            /* Manage Customers Page */
            case "/manageCustomers":

                CustomerService customerService = new CustomerService();

                request.setAttribute("customers", customerService.getAllCustomers());

                request.getRequestDispatcher("/Pages/Admin/Customer/customer.jsp")
                        .forward(request, response);

                break;

            /* View Customer Page */
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

            /* Manage Notification Page */
            case "/manageNotification":

                NotificationService notifListService = new NotificationService();

                request.setAttribute(
                        "notifHistory",
                        notifListService.getAllNotifications()
                );

                request.getRequestDispatcher("/Pages/Admin/Notification/notification.jsp")
                        .forward(request, response);

                break;

            /* Manage Reviews Page */
            case "/manageReviews":

                ReviewService reviewService = new ReviewService();

                request.setAttribute("reviews", reviewService.getAllReviews());

                request.getRequestDispatcher("/Pages/Admin/Review/reviews.jsp")
                        .forward(request, response);

                break;

            /* Default Route */
            default:

                request.getRequestDispatcher("/index.jsp")
                        .forward(request, response);

                break;
        }
    }

    /* Handle POST Requests */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        /* Service Objects */
        BookingService bookingService = new BookingService();
        CustomerService customerService = new CustomerService();
        NotificationService notificationService = new NotificationService();

        switch (path) {

            /* Send Notification */
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

            /* Delete Review */
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

            /* Update Booking */
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

            /* Delete Booking */
            case "/deleteBooking":

                int delBId = Integer.parseInt(
                        request.getParameter("booking_id")
                );

                bookingService.deleteBooking(delBId);

                response.sendRedirect(
                        request.getContextPath() + "/manageBooking"
                );

                break;

            /* Delete Customer */
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

            /* Default Redirect */
            default:

                response.sendRedirect(
                        request.getContextPath() + "/admin"
                );

                break;
        }
    }
}