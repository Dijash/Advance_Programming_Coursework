package com.controller.auth;

import com.DAO.UserDAO;
import com.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * password reset functionality.
 *
 * URL Mapping:
 *      /resetPassword
 *
 * Features:
 * - Displays reset password page
 * - Verifies reset session
 * - Encrypts new password
 * - Updates password in database
 * - Redirects user after password reset
 */
@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Check whether reset session exists.
     * 2. If session is invalid:
     *      - Redirect to forgot password page.
     * 3. If session is valid:
     *      - Open reset password page.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         * 'false' prevents creating new session.
         */
        HttpSession session = request.getSession(false);

        /*
         * Check whether session or reset email is missing.
         */
        if (session == null
                || session.getAttribute("reset_email") == null) {

            /*
             * Redirect user to forgot password page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/forgotPassword"
            );

            /*
             * Stop further execution.
             */
            return;
        }

        /*
         * Forward request to reset password page.
         */
        request.getRequestDispatcher("/WEB-INF/Pages/Auth/resetPassword.jsp")
                .forward(request, response);
    }

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Validate reset session.
     * 2. Retrieve new password.
     * 3. Encrypt password.
     * 4. Update password in database.
     * 5. Redirect user based on result.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         */
        HttpSession session = request.getSession(false);

        /*
         * Check whether session is invalid.
         */
        if (session == null
                || session.getAttribute("reset_email") == null) {

            /*
             * Redirect user to login page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            /*
             * Stop further execution.
             */
            return;
        }

        /*
         * Retrieve email stored in session.
         */
        String email =
                (String) session.getAttribute("reset_email");

        /*
         * Retrieve new password entered by user.
         */
        String newPassword =
                request.getParameter("newPassword");

        /*
         * Encrypt new password
         * before storing in database.
         */
        String hashedPassword =
                PasswordUtil.getHashPassword(newPassword);

        /*
         * Create UserDAO object
         * for database operations.
         */
        UserDAO dao = new UserDAO();

        /*
         * Update password using email.
         */
        boolean success =
                dao.updatePasswordByEmail(
                        email,
                        hashedPassword
                );

        /*
         * Password reset successful.
         */
        if (success) {

            /*
             * Remove reset email from session
             * after successful password update.
             */
            session.removeAttribute("reset_email");

            /*
             * Set success message.
             */
            request.setAttribute(
                    "message",
                    "Password reset successful! You can now log in."
            );

            /*
             * Forward user to login page.
             */
            request.getRequestDispatcher("/WEB-INF/Pages/Auth/Login.jsp")
                    .forward(request, response);

        } else {

            /*
             * Set error message.
             */
            request.setAttribute(
                    "error",
                    "Failed to reset password. Please try again."
            );

            /*
             * Return user to reset password page.
             */
            request.getRequestDispatcher("/WEB-INF/Pages/Auth/resetPassword.jsp")
                    .forward(request, response);
        }
    }
}