package com.controller.root;

import com.DAO.FavoriteDAO;
import com.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/toggleFavorite")
public class ToggleFavoriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Customer loggedInUser = (Customer) session.getAttribute("user");
            int customerId = loggedInUser.getCustomer_id();

            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));

            FavoriteDAO favDAO = new FavoriteDAO();
            favDAO.toggleFavorite(customerId, vehicleId);

            String referer = request.getHeader("Referer");

            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/rentalDeals");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/rentalDeals");
        }
    }
}