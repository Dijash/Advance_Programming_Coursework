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

/*
 * Main Root Controller Servlet
 *
 * This servlet handles public website pages such as:
 * - Home page
 * - Contact page
 * - Rental deals page
 * - Vehicle details page
 *
 * URL Mappings:
 *      /home
 *      /contact
 *      /rentalDeals
 *      /viewVehicleDetails
 */
@WebServlet({
        "/home",
        "/contact",
        "/rentalDeals",
        "/viewVehicleDetails"
})
public class HomeServlet extends HttpServlet {

    /*
     * Service object for subscriber operations.
     */
    private SubscriberService subscriberService;

    /*
     * Initializes servlet resources.
     *
     * Workflow:
     * 1. Create SubscriberService object.
     */
    @Override
    public void init() throws ServletException {

        /*
         * Initialize SubscriberService.
         */
        subscriberService = new SubscriberService();
    }

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Identify requested path.
     * 2. Execute functionality based on URL.
     * 3. Retrieve required data.
     * 4. Forward request to corresponding JSP page.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve servlet path.
         */
        String path = request.getServletPath();

        /*
         * Retrieve existing session.
         * 'false' prevents creating new session.
         */
        HttpSession session = request.getSession(false);

        /*
         * Home Page Section
         */
        if (path.equals("/home")) {

            /*
             * Default subscription status.
             */
            Boolean isSubscribed = false;

            /*
             * Check whether user is logged in.
             */
            if (session != null
                    && session.getAttribute("user") != null) {

                /*
                 * Retrieve logged-in customer.
                 */
                Customer user =
                        (Customer) session.getAttribute("user");

                /*
                 * Check whether user is subscribed.
                 */
                isSubscribed = subscriberService.isSubscribed(
                        user.getCustomer_email()
                );
            }

            /*
             * Store subscription status.
             */
            request.setAttribute("isSubscribed", isSubscribed);

            /*
             * Forward request to Home page.
             */
            request.getRequestDispatcher("/Pages/Root/Home.jsp")
                    .forward(request, response);

            /*
             * Contact Page Section
             */
        } else if (path.equals("/contact")) {

            /*
             * Forward request to Contact page.
             */
            request.getRequestDispatcher("/Pages/Root/Contact.jsp")
                    .forward(request, response);

            /*
             * Rental Deals Section
             */
        } else if (path.equals("/rentalDeals")) {

            /*
             * Retrieve filter parameters from request.
             */
            String searchParam =
                    request.getParameter("searchParam");

            String type =
                    request.getParameter("type");

            String color =
                    request.getParameter("color");

            String status =
                    request.getParameter("status");

            String condition =
                    request.getParameter("condition");

            /*
             * Check whether filters are applied.
             */
            boolean hasFilters =
                    (searchParam != null
                            || type != null
                            || color != null
                            || status != null
                            || condition != null);

            /*
             * If no filters are applied,
             * show only available vehicles by default.
             */
            if (!hasFilters) {
                status = "Available";
            }

            /*
             * Create VehicleDAO object.
             */
            VehicleDAO vehicleDAO = new VehicleDAO();

            /*
             * Retrieve filtered vehicle list.
             */
            List<Vehicle> vehicleList =
                    vehicleDAO.getFilteredVehicles(
                            searchParam,
                            type,
                            color,
                            status,
                            condition
                    );

            /*
             * Store vehicle list in request attribute.
             */
            request.setAttribute("vehicleList", vehicleList);

            /*
             * Store filter values
             * to preserve selected filters in UI.
             */
            request.setAttribute(
                    "searchParam",
                    searchParam != null ? searchParam : ""
            );

            request.setAttribute(
                    "filterType",
                    type != null ? type : "All"
            );

            request.setAttribute(
                    "filterColor",
                    color != null ? color : "All"
            );

            request.setAttribute(
                    "filterStatus",
                    status != null ? status : "Available"
            );

            request.setAttribute(
                    "filterCondition",
                    condition != null ? condition : "All"
            );

            /*
             * Check whether customer is logged in.
             */
            if (session != null
                    && session.getAttribute("user") != null) {

                /*
                 * Retrieve logged-in customer.
                 */
                Customer loggedInUser =
                        (Customer) session.getAttribute("user");

                /*
                 * Create FavoriteDAO object.
                 */
                FavoriteDAO favDAO = new FavoriteDAO();

                /*
                 * Retrieve favorite vehicle IDs.
                 */
                List<Integer> favoriteIds =
                        favDAO.getUserFavoriteVehicleIds(
                                loggedInUser.getCustomer_id()
                        );

                /*
                 * Store favorite vehicle IDs.
                 */
                request.setAttribute(
                        "favoriteIds",
                        favoriteIds
                );
            }

            /*
             * Forward request to Rental Deals page.
             */
            request.getRequestDispatcher("/Pages/Root/RentalDeals.jsp")
                    .forward(request, response);

            /*
             * Vehicle Details Section
             */
        } else if (path.equals("/viewVehicleDetails")) {

            try {

                /*
                 * Retrieve vehicle ID from request.
                 */
                int vehicleId = Integer.parseInt(
                        request.getParameter("id")
                );

                /*
                 * Create VehicleDAO object.
                 */
                VehicleDAO vehicleDAO = new VehicleDAO();

                /*
                 * Retrieve vehicle details by ID.
                 */
                Vehicle vehicle =
                        vehicleDAO.getVehicleById(vehicleId);

                /*
                 * Check whether vehicle exists.
                 */
                if (vehicle != null) {

                    /*
                     * Store vehicle details.
                     */
                    request.setAttribute("vehicle", vehicle);

                    /*
                     * Check whether customer is logged in.
                     */
                    if (session != null
                            && session.getAttribute("user") != null) {

                        /*
                         * Retrieve logged-in customer.
                         */
                        Customer loggedInUser =
                                (Customer) session.getAttribute("user");

                        /*
                         * Create FavoriteDAO object.
                         */
                        FavoriteDAO favDAO = new FavoriteDAO();

                        /*
                         * Retrieve customer favorite vehicle IDs.
                         */
                        request.setAttribute(
                                "favoriteIds",
                                favDAO.getUserFavoriteVehicleIds(
                                        loggedInUser.getCustomer_id()
                                )
                        );
                    }

                    /*
                     * Forward request to vehicle details page.
                     */
                    request.getRequestDispatcher(
                                    "/Pages/Root/ViewVehicleDetails.jsp")
                            .forward(request, response);

                } else {

                    /*
                     * If the vehicle does not exist,
                     * redirect back to the rental deals page.
                     */
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/rentalDeals"
                    );
                }

            } catch (NumberFormatException e) {

                /*
                 * Handle invalid vehicle ID format.
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/rentalDeals"
                );
            }
        }
    }
}