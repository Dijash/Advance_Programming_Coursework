package com.controller.root;

import com.service.SubscriberService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Status values forwarded as ?subscribeStatus=:
 *  - success   → new subscriber saved
 *  - duplicate → email already registered
 *  - error     → unexpected failure
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

        /*
         * Read the email parameter.
         */
        String email = request.getParameter("email");

        /*
       Returns "success", "duplicate", or "error".
         */
        String status = subscriberService.subscribe(email);

        /*
         * Redirect back to the home page anchor so the user lands
         on the subscription section and sees the flash message.
         */
        response.sendRedirect(
                request.getContextPath() + "/home?subscribeStatus=" + status + "#subscribe"
        );
    }
}
