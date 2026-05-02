package com.controller.user; // Ensure this matches your package structure!

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

@WebServlet({"/userDashboard", "/myBookings", "/settings", "/viewUserBooking", "/myFavorites"})
public class UserServlet extends HttpServlet {

    private UserDashboardDAO userDAO;
    private FavoriteDAO favoriteDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDashboardDAO();
        favoriteDAO = new FavoriteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Customer loggedInUser = (session != null) ? (Customer) session.getAttribute("user") : null;

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int customerId = loggedInUser.getCustomer_id();
        String path = request.getServletPath();

        NotificationDAO notifDAO = new NotificationDAO();
        request.setAttribute("totalNotifCount", notifDAO.getTotalNotificationCount());
        request.setAttribute("recentNotifs", notifDAO.getRecentNotifications());

        switch (path) {
            case "/userDashboard":
                int activeCount = userDAO.getActiveBookingsCount(customerId);
                int completedCount = userDAO.getCompletedTripsCount(customerId);
                double totalSpent = userDAO.getTotalSpent(customerId);
                List<Booking> recentBookings = userDAO.getRecentBookings(customerId);

                request.setAttribute("activeBookingsCount", activeCount);
                request.setAttribute("completedTripsCount", completedCount);
                request.setAttribute("totalSpent", totalSpent);
                request.setAttribute("userRecentBookings", recentBookings);

                request.getRequestDispatcher("/Pages/User/Dashboard/dashboard.jsp").forward(request, response);
                break;

            case "/myBookings":
                List<Booking> allBookings = userDAO.getAllUserBookings(customerId);
                request.setAttribute("userAllBookings", allBookings);

                request.getRequestDispatcher("/Pages/User/Booking/myBookings.jsp").forward(request, response);
                break;

            case "/viewUserBooking":
                String bookingIdStr = request.getParameter("id");

                if (bookingIdStr != null) {
                    try {
                        int bId = Integer.parseInt(bookingIdStr);

                        List<Booking> userBookings = userDAO.getAllUserBookings(customerId);
                        Booking singleBooking = userBookings.stream()
                                .filter(b -> b.getBookingId() == bId)
                                .findFirst()
                                .orElse(null);

                        if (singleBooking != null) {
                            request.setAttribute("bookingDetails", singleBooking);
                            request.getRequestDispatcher("/Pages/User/Booking/bookingDetails.jsp").forward(request, response);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/myBookings");
                        }
                    } catch (NumberFormatException e) {
                        response.sendRedirect(request.getContextPath() + "/myBookings");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/myBookings");
                }
                break;

            case "/myFavorites":
                List<Vehicle> favoriteVehicles = favoriteDAO.getFavoriteVehiclesByCustomerId(customerId);

                request.setAttribute("favoriteVehicles", favoriteVehicles);

                request.getRequestDispatcher("/Pages/User/Dashboard/myFavorites.jsp").forward(request, response);
                break;

            case "/settings":
                request.getRequestDispatcher("/Pages/User/Dashboard/settings.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/userDashboard");
                break;
        }
    }
}