package com.controller.root;

import com.DAO.VehicleDAO;
import com.DAO.FavoriteDAO;
import com.model.Customer;
import com.model.Vehicle;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/home", "/contact", "/rentalDeals", "/viewVehicleDetails"})
public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        HttpSession session = request.getSession(false);

        if (path.equals("/home")) {
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            request.getRequestDispatcher("/Pages/Root/Home.jsp").forward(request, response);

        } else if (path.equals("/contact")) {
            request.getRequestDispatcher("/Pages/Root/Contact.jsp").forward(request, response);

        }else if (path.equals("/rentalDeals")) {
            String searchParam = request.getParameter("searchParam");
            String type        = request.getParameter("type");
            String color       = request.getParameter("color");
            String status      = request.getParameter("status");
            String condition   = request.getParameter("condition");

            // Default status to "Available" on first
            boolean hasFilters = (searchParam != null || type != null || color != null
                    || status != null || condition != null);
            if (!hasFilters) {
                status = "Available";
            }

            //  Fetch filtered vehicles
            VehicleDAO vehicleDAO = new VehicleDAO();
            List<Vehicle> vehicleList = vehicleDAO.getFilteredVehicles(searchParam, type, color, status, condition);
            request.setAttribute("vehicleList", vehicleList);

            // Pass filter values back to JSP so the form stays filled after submit
            request.setAttribute("searchParam", searchParam != null ? searchParam : "");
            request.setAttribute("filterType",      type      != null ? type      : "All");
            request.setAttribute("filterColor",     color     != null ? color     : "All");
            request.setAttribute("filterStatus",    status    != null ? status    : "Available");
            request.setAttribute("filterCondition", condition != null ? condition : "All");

            // Fetch Favorites using the "user" object
            if (session != null && session.getAttribute("user") != null) {
                Customer loggedInUser = (Customer) session.getAttribute("user");
                FavoriteDAO favDAO = new FavoriteDAO();
                List<Integer> favoriteIds = favDAO.getUserFavoriteVehicleIds(loggedInUser.getCustomer_id());
                request.setAttribute("favoriteIds", favoriteIds);
                System.out.println("DEBUG: Loaded Favorites for " + loggedInUser.getCustomer_username() + ": " + favoriteIds);
            }

            request.getRequestDispatcher("/Pages/Root/RentalDeals.jsp").forward(request, response);

        } else if (path.equals("/viewVehicleDetails")) {
            try {
                int vehicleId = Integer.parseInt(request.getParameter("id"));
                VehicleDAO vehicleDAO = new VehicleDAO();
                Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);

                if (vehicle != null) {
                    request.setAttribute("vehicle", vehicle);

                    // Also load favorites here so the heart shows correctly on the details page!
                    if (session != null && session.getAttribute("user") != null) {
                        Customer loggedInUser = (Customer) session.getAttribute("user");
                        FavoriteDAO favDAO = new FavoriteDAO();
                        request.setAttribute("favoriteIds", favDAO.getUserFavoriteVehicleIds(loggedInUser.getCustomer_id()));
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