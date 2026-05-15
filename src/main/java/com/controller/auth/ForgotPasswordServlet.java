package com.controller.auth;

import com.DAO.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * Forgot Password functionality.
 *
 * URL Mapping:
 *      /forgotPassword
 *
 * Features:
 * - Displays forgot password form
 * - Checks whether entered email exists
 * - Stores email in session for password reset
 * - Redirects user to reset password page
 */
@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Receive request from user.
     * 2. Open forgot password page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Forward request to forgot password JSP page.
         */
        request.getRequestDispatcher("/Pages/Auth/forgotPassword.jsp")
                .forward(request, response);
    }

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Retrieve email entered by user.
     * 2. Check whether email exists in database.
     * 3. If email exists:
     *      - Create session
     *      - Store email in session
     *      - Redirect to reset password page
     * 4. If email does not exist:
     *      - Show error message
     *      - Return to forgot password page
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve email from form input.
         */
        String email = request.getParameter("email");

        /*
         * Create UserDAO object
         * for database operations.
         */
        UserDAO dao = new UserDAO();

        /*
         * Check whether email exists in database.
         */
        if (dao.checkEmailExists(email)) {

            /*
             * Create or retrieve current session.
             */
            HttpSession session = request.getSession();

            /*
             * Store email in session
             * for password reset process.
             */
            session.setAttribute("reset_email", email);

            /*
             * Redirect user to reset password page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/resetPassword"
            );

        } else {

            /*
             * If email is not found,
             * display error message.
             */
            request.setAttribute(
                    "error",
                    "We couldn't find an account with that email."
            );

            /*
             * Return user back to forgot password page.
             */
            request.getRequestDispatcher("/Pages/Auth/forgotPassword.jsp")
                    .forward(request, response);
        }
    }
}