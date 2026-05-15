package com.controller.auth;

import com.DAO.UserDAO;
import com.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/*
 * Servlet responsible for handling
 * user login functionality.
 *
 * URL Mapping:
 *      /login
 *
 * Features:
 * - Displays login page
 * - Validates admin login
 * - Validates customer login
 * - Creates user session
 * - Redirects users based on role
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Open login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Forward request to login page.
         */
        request.getRequestDispatcher("/Pages/Auth/Login.jsp")
                .forward(request, response);
    }

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Retrieve login credentials.
     * 2. Create user session.
     * 3. Check admin login.
     * 4. Check customer login using database.
     * 5. Redirect user based on login result.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve email and password
         * entered by the user.
         */
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        /*
         * Create or retrieve session.
         */
        HttpSession session = request.getSession();

        /*
         * Set session timeout to 30 minutes.
         * (30 * 60 seconds)
         */
        session.setMaxInactiveInterval(30 * 60);

        /*
         * Check for admin login credentials.
         */
        if ("admin@gmail.com".equals(email)
                && "admin".equals(password)) {

            /*
             * Store admin session details.
             */
            session.setAttribute("email", email);
            session.setAttribute("role", "admin");

            /*
             * Remove previous error message if exists.
             */
            session.removeAttribute("errorMsg");

            /*
             * Redirect admin to dashboard.
             */
            response.sendRedirect(
                    request.getContextPath() + "/admin"
            );

            /*
             * Stop further execution.
             */
            return;
        }

        /*
         * Create UserDAO object
         * for database authentication.
         */
        UserDAO dao = new UserDAO();

        /*
         * Validate customer login credentials.
         *
         * Possible return values:
         *      success
         *      wrong_password
         *      user_not_found
         */
        String result = dao.checkLogin(email, password);

        /*
         * Login successful.
         */
        if (result.equals("success")) {

            /*
             * Retrieve logged-in customer details.
             */
            Customer loggedInCustomer =
                    dao.getCustomerByEmail(email);

            /*
             * Store customer information in session.
             */
            session.setAttribute("user", loggedInCustomer);
            session.setAttribute("email", email);
            session.setAttribute("role", "customer");

            /*
             * Remove old error message if exists.
             */
            session.removeAttribute("errorMsg");

            /*
             * Redirect customer to home page.
             */
            response.sendRedirect(
                    request.getContextPath() + "/home"
            );

            /*
             * Wrong password case.
             */
        } else if (result.equals("wrong_password")) {

            /*
             * Set error message.
             */
            request.setAttribute(
                    "error",
                    "Wrong password!"
            );

            /*
             * Return user to login page.
             */
            request.getRequestDispatcher("/Pages/Auth/Login.jsp")
                    .forward(request, response);

            /*
             * User account not found case.
             */
        } else if (result.equals("user_not_found")) {

            /*
             * Set registration suggestion message.
             */
            request.setAttribute(
                    "error",
                    "User does not exist. Please register."
            );

            /*
             * Return user to login page.
             */
            request.getRequestDispatcher("/Pages/Auth/Login.jsp")
                    .forward(request, response);
        }
    }
}