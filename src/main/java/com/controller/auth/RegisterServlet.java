package com.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.util.DBConnection;
import com.util.PasswordUtil;

@WebServlet("/register")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Pages/Auth/Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get standard form text fields
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String country = request.getParameter("country");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String referral = request.getParameter("referral");

            String hashedPassword = PasswordUtil.getHashPassword(password);

            Part filePart = request.getPart("customer_image");
            String fileName = null;

            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = filePart.getSubmittedFileName();
                fileName = System.currentTimeMillis() + "_" + originalFileName;

                String uploadPath = getServletContext().getRealPath("") + File.separator + "Assets" + File.separator + "Profiles";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadPath + File.separator + fileName);
            }

            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO customer (first_name, last_name, gender, password, referral_code, customer_username, customer_phoneNo, customer_email, customer_dob, customer_address, customer_country, customer_image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement statement = con.prepareStatement(sql);

            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, gender);
            statement.setString(4, hashedPassword);
            statement.setString(5, referral);
            statement.setString(6, username);
            statement.setString(7, phone);
            statement.setString(8, email);
            statement.setString(9, dob);
            statement.setString(10, address);
            statement.setString(11, country);
            statement.setString(12, fileName);

            statement.executeUpdate();

            response.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register?error=true");
        }
    }
}