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

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Prevent browser caching for security
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedAsCustomer = (session != null && session.getAttribute("user") != null);

        if (isLoggedAsCustomer) {
            chain.doFilter(request, response);
        } else {
            session = httpRequest.getSession(true);
            String uri = httpRequest.getRequestURI();
            if (uri.endsWith("/toggleFavorite")) {
                httpResponse.setContentType("application/json");
                httpResponse.getWriter().write("{\"status\": \"unauthorized\"}");
                return;
            }

            session.setAttribute("errorMsg", "Please log in to access this page.");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
    }
}