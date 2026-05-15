package com.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/*
 * Authentication filter for ADMIN protected routes.
 *
 * This filter ensures that only logged-in users with ADMIN role
 * can access administrative pages such as:
 * - Booking management
 * - Vehicle management
 * - Customer management
 * - Notifications
 * - Reports
 *
 * If the user is not an admin, they are redirected to login page.
 */
@WebFilter({
        "/admin",
        "/manageBooking", "/viewBooking", "/editBooking", "/updateBooking", "/deleteBooking",
        "/manageVehicles", "/addVehicle", "/viewVehicle", "/editVehicle",
        "/manageCustomers", "/viewCustomer", "/deleteCustomer",
        "/manageReviews", "/deleteReview",
        "/manageNotification", "/sendNotification",
        "/report"
})
public class AuthFilter implements Filter {

    /*
     * Filter initialization method.
     * Currently unused but required by Filter interface.
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization required
    }

    /*
     * Main filter logic executed for every matched request.
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        /*
         * Cast generic request/response into HTTP objects
         * to access session and redirect functionality.
         */
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        /*
         * Retrieve existing session without creating a new one.
         */
        HttpSession session = httpRequest.getSession(false);

        /*
         * Check if user is logged in and has ADMIN role.
         */
        boolean isLoggedAsAdmin =
                (session != null && "admin".equals(session.getAttribute("role")));

        /*
         * If admin is authenticated → allow the request to proceed.
         * Otherwise → redirect to login page.
         */
        if (isLoggedAsAdmin) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    /*
     * Filter cleanup method.
     * Used when the filter is being destroyed (not used here).
     */
    @Override
    public void destroy() {
        // No cleanup required
    }
}