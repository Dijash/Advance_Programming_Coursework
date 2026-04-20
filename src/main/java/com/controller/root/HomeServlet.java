package com.controller.root;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/home","/contact"})
public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if (path.equals("/home")) {

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("email") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            request.getRequestDispatcher("/Pages/Root/Home.jsp").forward(request, response);

        } else if (path.equals("/contact")) {

            request.getRequestDispatcher("/Pages/Root/Contact.jsp").forward(request, response);
        }
    }
}