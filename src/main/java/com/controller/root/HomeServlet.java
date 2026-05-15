package com.controller.root;

import com.DAO.VehicleDAO;
import com.DAO.FavoriteDAO;
import com.model.Customer;
import com.model.Vehicle;
import com.service.SubscriberService;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({ "/home", "/contact", "/rentalDeals", "/viewVehicleDetails" })
public class HomeServlet extends HttpServlet {

    private SubscriberService subscriberService;

    @Override
    public void init() throws ServletException {
        subscriberService = new SubscriberService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        HttpSession session = request.getSession(false);

        if (path.equals("/home")) {
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Check if the logged-in user is already subscribed
            Customer user = (Customer) session.getAttribute("user");
            boolean isSubscribed = subscriberService.isSubscribed(user.getCustomer_email());
            request.setAttribute("isSubscribed", isSubscribed);

            request.getRequestDispatcher("/Pages/Root/Home.jsp").forward(request, response);

        } else if (path.equals("/contact")) {
            request.getRequestDispatcher("/Pages/Root/Contact.jsp").forward(request, response);

        } else if (path.equals("/rentalDeals")) {
            String searchParam = request.getParameter("searchParam");
            String type = request.getParameter("type");
            String color = request.getParameter("color");
            String status = request.getParameter("status");
            String condition = request.getParameter("condition");

            boolean hasFilters = (searchParam != null || type != null || color != null
                    || status != null || condition != null);
            if (!hasFilters) {
                status = "Available";
            }

            VehicleDAO vehicleDAO = new VehicleDAO();
            List<Vehicle> vehicleList = vehicleDAO.getFilteredVehicles(searchParam, type, color, status, condition);
            request.setAttribute("vehicleList", vehicleList);

            request.setAttribute("searchParam", searchParam != null ? searchParam : "");
            request.setAttribute("filterType", type != null ? type : "All");
            request.setAttribute("filterColor", color != null ? color : "All");
            request.setAttribute("filterStatus", status != null ? status : "Available");
            request.setAttribute("filterCondition", condition != null ? condition : "All");

            if (session != null && session.getAttribute("user") != null) {
                Customer loggedInUser = (Customer) session.getAttribute("user");
                FavoriteDAO favDAO = new FavoriteDAO();
                List<Integer> favoriteIds = favDAO.getUserFavoriteVehicleIds(loggedInUser.getCustomer_id());
                request.setAttribute("favoriteIds", favoriteIds);
            }

            request.getRequestDispatcher("/Pages/Root/RentalDeals.jsp").forward(request, response);

        } else if (path.equals("/viewVehicleDetails")) {
            try {
                int vehicleId = Integer.parseInt(request.getParameter("id"));
                VehicleDAO vehicleDAO = new VehicleDAO();
                Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);

                if (vehicle != null) {
                    request.setAttribute("vehicle", vehicle);

                    if (session != null && session.getAttribute("user") != null) {
                        Customer loggedInUser = (Customer) session.getAttribute("user");
                        FavoriteDAO favDAO = new FavoriteDAO();
                        request.setAttribute("favoriteIds",
                                favDAO.getUserFavoriteVehicleIds(loggedInUser.getCustomer_id()));
                    }

                    request.getRequestDispatcher("/Pages/Root/ViewVehicleDetails.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/rentalDeals");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/rentalDeals");
            }
        }
    }
}
