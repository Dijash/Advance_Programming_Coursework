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
 * Servlet Filter that restricts access to customer‑only pages.
 *
 * URL patterns protected by this filter:
 *      /userDashboard
 *      /myBookings
 *      /viewUserBooking
 *      /myFavorites
 *      /settings
 *      /submitBooking
 *      /toggleFavorite
 *
 * This filter checks whether the current user is logged in as a customer.
 * If yes, the request proceeds. If not, the user is redirected to the login
 * page. Additionally, it sets HTTP headers to prevent caching of
 * protected pages for security reasons.
 */
@WebFilter({
        "/userDashboard",
        "/myBookings",
        "/viewUserBooking",
        "/myFavorites",
        "/settings",
        "/submitBooking",
        "/toggleFavorite"
})
public class CustomerFilter implements Filter {

    /*
     * Called by the web container when the filter is initialized.
     * No custom initialization is required for this filter.
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Intentionally empty – no startup configuration needed.
    }

    /*
     * Core filtering logic executed for every request matching the URL patterns.
     *
     * Workflow:
     * 1. Cast the generic request/response to HTTP-specific types.
     * 2. Set HTTP headers to prevent caching of protected pages.
     * 3. Retrieve the current session (without creating a new one).
     * 4. Check if a user is logged in as a customer.
     * 5. If yes, forward the request to the target servlet/JSP.
     * 6. If not:
     *    - For normal page requests, store an error message in the session
     *      and redirect the user to the login page.
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        /*
         * Cast to HTTP objects – necessary for accessing session,
         * request URI, context path, and response redirect methods.
         */
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        /*
         * Prevent browser caching for security.
         * These headers ensure that sensitive pages are not stored
         * in the browser cache after logout or session expiration.
         */
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        /*
         * Retrieve existing session.
         * 'false' prevents creating a new session if one does not exist.
         * This avoids creating empty sessions for unauthenticated users.
         */
        HttpSession session = httpRequest.getSession(false);

        /*
         * Check if the user is logged in as a customer.
         * Condition: session exists AND session attribute "user" is present.
         * (The attribute "user" is typically set during login for customer role.)
         */
        boolean isLoggedAsCustomer = (session != null && session.getAttribute("user") != null);

        if (isLoggedAsCustomer) {

            /*
             * User is authenticated as customer.
             * Allow the request to proceed to the protected resource.
             */
            chain.doFilter(request, response);

        } else {

            /*
             * User is not authenticated.
             * Handle the unauthorized access based on the request type.
             */

            /*
             * Create a new session to store error message for the login page.
             * Using 'true' ensures a session exists for storing temporary data.
             */
            session = httpRequest.getSession(true);

            /*
             * The filter protects multiple URLs; we need special handling for
             * '/toggleFavorite' because it is called asynchronously by JavaScript.
             */
            String uri = httpRequest.getRequestURI();

            /*
             * Check if the request is for the 'toggleFavorite' endpoint.
             * Returning a full HTML redirect would break the JavaScript client.
             */
            if (uri.endsWith("/toggleFavorite")) {

                /*
                 * but status field set to "unauthorized". The client-side code
                 * should check this field and redirect or show a message accordingly.
                 */
                httpResponse.setContentType("application/json");
                httpResponse.getWriter().write("{\"status\": \"unauthorized\"}");

                /*
                 * Stop filter chain execution – do not forward to login page.
                 */
                return;
            }

            /*
             * Store a user-friendly error message in the session.
             * This message will be displayed on the login page.
             */
            session.setAttribute("errorMsg", "Please log in to access this page.");

            /*
             * Redirect the user to the login page.
             * request.getContextPath() ensures the correct application root
             * even if the application is deployed under a different context path.
             */
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    /*
     * Called by the web container when the filter is taken out of service.
     * No cleanup is required for this filter.
     */
    @Override
    public void destroy() {
        // Intentionally empty – no resources to release.
    }
}