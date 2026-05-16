package com.controller.auth;

import com.DAO.UserDAO;
import com.model.Customer;
import com.util.CookieUtil;
import com.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // AUTO-LOGIN LOGIC: Check if they have a "Remember Me" cookie
        Cookie userCookie = CookieUtil.getCookie(request, "user_email");

        if (userCookie != null && userCookie.getValue() != null) {
            String savedEmail = userCookie.getValue();

            // Rebuild their session automatically without asking for a password!
            UserDAO dao = new UserDAO();
            Customer returningCustomer = dao.getCustomerByEmail(savedEmail);

            if (returningCustomer != null) {
                SessionUtil.setAttribute(request, "user", returningCustomer);
                SessionUtil.setAttribute(request, "email", savedEmail);
                SessionUtil.setAttribute(request, "role", "customer");
                SessionUtil.setSessionTimeout(request, 30 * 60);

                response.sendRedirect(request.getContextPath() + "/home");
                return; // Stop execution here
            }
        }

        // If no cookie exists, show them the normal login page
        request.getRequestDispatcher("/Pages/Auth/Login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Grab the value of the "Remember Me" checkbox from your Login.jsp form
        String rememberMe = request.getParameter("rememberMe");

        /* Admin Login */
        if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
            SessionUtil.setAttribute(request, "email", email);
            SessionUtil.setAttribute(request, "role", "admin");
            SessionUtil.setSessionTimeout(request, 30 * 60);
            SessionUtil.removeAttribute(request, "errorMsg");

            // Create Admin Cookie if checked (lasts 30 days)
            if ("on".equals(rememberMe)) {
                CookieUtil.addCookie(response, "user_email", email, 30 * 60);
            }

            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        /* Customer Login */
        UserDAO dao = new UserDAO();
        String result = dao.checkLogin(email, password);

        if (result.equals("success")) {
            Customer loggedInCustomer = dao.getCustomerByEmail(email);

            SessionUtil.setAttribute(request, "user", loggedInCustomer);
            SessionUtil.setAttribute(request, "email", email);
            SessionUtil.setAttribute(request, "role", "customer");
            SessionUtil.setSessionTimeout(request, 30 * 60);
            SessionUtil.removeAttribute(request, "errorMsg");

            // Create Customer Cookie if checked (lasts 30 days)
            if ("on".equals(rememberMe)) {
                CookieUtil.addCookie(response, "user_email", email, 60 * 60 * 24 * 30);
            }

            response.sendRedirect(request.getContextPath() + "/home");

        } else if (result.equals("wrong_password")) {
            request.setAttribute("error", "Wrong password!");
            request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
        } else if (result.equals("user_not_found")) {
            request.setAttribute("error", "User does not exist. Please register.");
            request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
        }
    }
}