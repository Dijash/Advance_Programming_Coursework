package com.controller.root; // Make sure this matches your folder structure!

import com.DAO.FavoriteDAO;
import com.model.Customer; // Required to get the user ID
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/toggleFavorite")
public class ToggleFavoriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // FIX 1: Escaped inner quotes so the string literal compiles correctly
            out.print("{\"status\":\"unauthorized\"}");
            return;
        }

        try {
            Customer loggedInUser = (Customer) session.getAttribute("user");
            int customerId = loggedInUser.getCustomer_id();

            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));

            FavoriteDAO favDAO = new FavoriteDAO();
            boolean isFavorited = favDAO.toggleFavorite(customerId, vehicleId);

            // FIX 2: Moved the closing quote so isFavorited boolean is concatenated outside the string
            out.print("{\"status\":\"success\", \"isFavorited\":" + isFavorited + "}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"server_error\"}");
        }
    }
}