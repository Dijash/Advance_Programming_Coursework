package com.controller.auth;

import com.util.CookieUtil;
import com.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * user logout functionality.
 *
 * URL Mapping:
 *      /logout
 *
 * Features:
 * - Removes authentication cookies
 * - Invalidates user session
 * - Redirects user to homepage
 */
@WebServlet(
        asyncSupported = true,
        urlPatterns = { "/logout" }
)
public class LogoutServlet extends HttpServlet {

    /*
     * Serial version UID
     * used for serialization.
     */
    private static final long serialVersionUID = 1L;

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Process logout operation.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Call logout processing method.
         */
        processLogout(request, response);
    }

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Process logout operation.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Call logout processing method.
         */
        processLogout(request, response);
    }

    /*
     * Handles actual logout logic.
     *
     * Workflow:
     * 1. Delete user role cookie.
     * 2. Invalidate current session.
     * 3. Redirect user to homepage.
     */
    private void processLogout(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        /*
         * Delete the role cookie from the browser.
         */
        CookieUtil.deleteCookie(response, "role");

        /*
         * Destroy current user session.
         */
        SessionUtil.invalidateSession(request);

        /*
         * Redirect user to application homepage.
         */
        response.sendRedirect(
                request.getContextPath() + "/"
        );
    }
}