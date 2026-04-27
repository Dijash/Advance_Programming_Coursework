package com.controller.admin;

import com.service.*;
import com.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin",
        "/manageBooking", "/viewBooking", "/editBooking", "/updateBooking", "/deleteBooking",
        "/manageVehicles", "/addVehicle", "/viewVehicle", "/editVehicle",
        "/manageCustomers", "/viewCustomer", "/deleteCustomer",
        "/manageReviews", "/deleteReview",
        "/manageNotification", "/sendNotification",
        "/report"
})
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        BookingService bookingService = new BookingService();

        switch (path) {
            case "/admin":
                AdminDashboardService dashboardService = new AdminDashboardService();
                NotificationService notifService = new NotificationService();

                request.setAttribute("totalBookings", dashboardService.getTotalBookings());
                request.setAttribute("totalVehicles", dashboardService.getTotalVehicles());
                request.setAttribute("totalRevenue", dashboardService.getTotalRevenue());
                request.setAttribute("activeRentalsCount", dashboardService.getActiveRentalsCount());

                request.setAttribute("totalNotifCount", notifService.getTotalNotificationCount());
                List<Notification> recentNotifs = notifService.getRecentNotifications();
                if (!recentNotifs.isEmpty()) {
                    request.setAttribute("latestNotif", recentNotifs.get(0));
                }

                request.setAttribute("upcomingReturns", dashboardService.getUpcomingReturns());
                request.setAttribute("topVehicle", dashboardService.getTopVehicle());

                request.getRequestDispatcher("/Pages/Admin/Dashboard/admin.jsp").forward(request, response);
                break;

            case "/addVehicle":
                request.getRequestDispatcher("/Pages/Admin/Vehicle/addVehicle.jsp").forward(request, response);
                break;

            case "/manageBooking":
                request.setAttribute("bookings", bookingService.getAllBookings());
                request.getRequestDispatcher("/Pages/Admin/Booking/manageBooking.jsp").forward(request, response);
                break;

            case "/viewBooking":
            case "/editBooking":
                String bIdStr = request.getParameter("id");
                if (bIdStr != null) {
                    request.setAttribute("booking", bookingService.getBookingById(Integer.parseInt(bIdStr)));
                }
                String target = path.equals("/viewBooking") ? "/Pages/Admin/Booking/viewBooking.jsp" : "/Pages/Admin/Booking/editBooking.jsp";
                request.getRequestDispatcher(target).forward(request, response);
                break;

            case "/manageVehicles":
                VehicleService vServiceList = new VehicleService();
                request.setAttribute("vehicles", vServiceList.getAllVehicles());
                request.getRequestDispatcher("/Pages/Admin/Vehicle/manageVehicle.jsp").forward(request, response);
                break;

            case "/viewVehicle":
            case "/editVehicle":
                String vehicleIdStr = request.getParameter("id");
                if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {
                    VehicleService vService = new VehicleService();
                    request.setAttribute("vehicle", vService.getVehicleById(Integer.parseInt(vehicleIdStr)));
                }
                String vTarget = path.equals("/editVehicle") ? "/Pages/Admin/Vehicle/editVehicle.jsp" : "/Pages/Admin/Vehicle/viewVehicle.jsp";
                request.getRequestDispatcher(vTarget).forward(request, response);
                break;

            case "/manageCustomers":
                CustomerService customerService = new CustomerService();
                request.setAttribute("customers", customerService.getAllCustomers());
                request.getRequestDispatcher("/Pages/Admin/Customer/customer.jsp").forward(request, response);
                break;

            case "/viewCustomer":
                String cIdParam = request.getParameter("id");
                if (cIdParam != null) {
                    CustomerService cService = new CustomerService();
                    request.setAttribute("customer", cService.getCustomerById(Integer.parseInt(cIdParam)));
                }
                request.getRequestDispatcher("/Pages/Admin/Customer/viewCustomer.jsp").forward(request, response);
                break;

            case "/manageNotification":
                NotificationService notifListService = new NotificationService();
                request.setAttribute("notifHistory", notifListService.getAllNotifications());
                request.getRequestDispatcher("/Pages/Admin/Notification/notification.jsp").forward(request, response);
                break;

            case "/manageReviews":
                ReviewService reviewService = new ReviewService();
                request.setAttribute("reviews", reviewService.getAllReviews());
                request.getRequestDispatcher("/Pages/Admin/Review/reviews.jsp").forward(request, response);
                break;

            default:
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        BookingService bookingService = new BookingService();
        CustomerService customerService = new CustomerService();
        NotificationService notificationService = new NotificationService();

        switch (path) {
            case "/sendNotification":
                String type = request.getParameter("subject");
                String desc = request.getParameter("message");

                if (type != null && desc != null) {
                    notificationService.sendBroadcast(type, desc);
                }
                response.sendRedirect(request.getContextPath() + "/manageNotification");
                break;

            case "/deleteReview":
                response.sendRedirect(request.getContextPath() + "/manageReviews");
                break;

            case "/updateBooking":
                int updateId = Integer.parseInt(request.getParameter("booking_id"));
                String newStatus = request.getParameter("status");
                bookingService.updateBookingStatus(updateId, newStatus);
                response.sendRedirect(request.getContextPath() + "/manageBooking");
                break;

            case "/deleteBooking":
                int delBId = Integer.parseInt(request.getParameter("booking_id"));
                bookingService.deleteBooking(delBId);
                response.sendRedirect(request.getContextPath() + "/manageBooking");
                break;

            case "/deleteCustomer":
                String cIdStr = request.getParameter("customer_id");
                if (cIdStr != null && !cIdStr.isEmpty()) {
                    customerService.deleteCustomer(Integer.parseInt(cIdStr));
                }
                response.sendRedirect(request.getContextPath() + "/manageCustomers");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/admin");
                break;
        }
    }
}