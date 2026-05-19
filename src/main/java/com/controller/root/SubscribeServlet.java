package com.controller.root;

import com.model.Customer;
import com.service.SubscriberService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Status values forwarded as ?subscribeStatus=:
 * - success   → new subscriber saved
 * - duplicate → email already registered
 * - error     → unexpected failure
 */
@WebServlet("/subscribe")
public class SubscribeServlet extends HttpServlet {

    private SubscriberService subscriberService;

    @Override
    public void init() throws ServletException {
        subscriberService = new SubscriberService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");   // "subscribe" or "unsubscribe"
        String email = request.getParameter("email");
        String referer = request.getHeader("Referer");

        // Determine where to redirect after the action
        boolean fromAdmin = (referer != null && referer.contains("/report"));
        boolean fromIndex = (referer != null && (referer.endsWith("/") || referer.endsWith("/index.jsp")));

        if ("unsubscribe".equals(action)) {
            subscriberService.unsubscribeByEmail(email);
            if (fromAdmin) {
                response.sendRedirect(request.getContextPath() + "/report");
            } else if (fromIndex) {
                response.sendRedirect(request.getContextPath() + "/?subscribeStatus=unsubscribed#subscribe");
            } else {
                response.sendRedirect(request.getContextPath() + "/home?subscribeStatus=unsubscribed#subscribe");
            }
            return;
        }

        // --- NEW LOGIC: Fetch Customer ID if user is logged in ---
        HttpSession session = request.getSession(false);
        Integer customerId = null;
        if (session != null && session.getAttribute("user") != null) {
            Customer user = (Customer) session.getAttribute("user");
            customerId = user.getCustomer_id();
        }

        // Default: subscribe (Passing customerId)
        String status = subscriberService.subscribe(email, customerId);

        if (fromAdmin) {
            response.sendRedirect(request.getContextPath() + "/report");
        } else if (fromIndex) {
            response.sendRedirect(request.getContextPath() + "/?subscribeStatus=" + status + "#subscribe");
        } else {
            response.sendRedirect(request.getContextPath() + "/home?subscribeStatus=" + status + "#subscribe");
        }
    }
}