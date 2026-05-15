package com.controller.root;

import com.model.Customer;
import com.service.ContactService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * contact form submissions.
 *
 * URL Mapping:
 *      /submitContact
 *
 * Features:
 * - Receives contact form data
 * - Detects logged-in user (if any)
 * - Stores message in database
 * - Redirects user with status message
 */
@WebServlet("/submitContact")
public class SubmitContactServlet extends HttpServlet {

    /*
     * Service object for contact operations.
     */
    private ContactService contactService;

    /*
     * Initializes servlet resources.
     *
     * Workflow:
     * 1. Create ContactService object.
     */
    @Override
    public void init() throws ServletException {

        /*
         * Initialize ContactService.
         */
        contactService = new ContactService();
    }

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Retrieve contact form data.
     * 2. Check if user is logged in.
     * 3. Attach customer ID if available.
     * 4. Save contact message via service layer.
     * 5. Redirect user based on result.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve contact form inputs.
         */
        String firstName =
                request.getParameter("firstName");

        String lastName =
                request.getParameter("lastName");

        String email =
                request.getParameter("email");

        String subject =
                request.getParameter("subject");

        String message =
                request.getParameter("message");

        /*
         * Retrieve current session.
         */
        HttpSession session =
                request.getSession();

        /*
         * Retrieve logged-in customer (if exists).
         */
        Customer loggedInUser =
                (Customer) session.getAttribute("user");

        /*
         * Variable to store customer ID (optional).
         */
        Integer customerId = null;

        /*
         * Check if user is logged in.
         */
        if (loggedInUser != null) {

            /*
             * Assign logged-in user's ID.
             */
            customerId =
                    loggedInUser.getCustomer_id();
        }

        try {

            /*
             * Save contact message using service layer.
             */
            boolean isSaved =
                    contactService.saveContactMessage(
                            customerId,
                            firstName,
                            lastName,
                            email,
                            subject,
                            message
                    );

            /*
             * Contact message saved successfully.
             */
            if (isSaved) {

                /*
                 * Redirect to contact page with success status.
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/contact?status=success"
                );

            } else {

                /*
                 * Log database failure.
                 */
                System.err.println(
                        "Database INSERT failed: No rows affected."
                );

                /*
                 * Redirect to contact page with error status.
                 */
                response.sendRedirect(
                        request.getContextPath()
                                + "/contact?status=error"
                );
            }

        } catch (Exception e) {

            /*
             * Log critical system error.
             */
            System.err.println(
                    "Critical Error during Contact Submission:"
            );

            /*
             * Print full stack trace.
             */
            e.printStackTrace();

            /*
             * Redirect to contact page with error status.
             */
            response.sendRedirect(
                    request.getContextPath()
                            + "/contact?status=error"
            );
        }
    }
}