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

/*
 * Servlet responsible for handling
 * customer registration functionality.
 *
 * URL Mapping:
 *      /register
 *
 * Features:
 * - Displays registration form
 * - Receives customer details
 * - Uploads profile image
 * - Encrypts password
 * - Stores customer information in database
 */
@WebServlet("/register")

/*
 * Multipart configuration for file uploads.
 *
 * fileSizeThreshold:
 *      Size threshold after which files
 *      are written to disk.
 *
 * maxFileSize:
 *      Maximum size allowed for a single file.
 *
 * maxRequestSize:
 *      Maximum size allowed for entire request.
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class RegisterServlet extends HttpServlet {

    /*
     * Handles HTTP GET requests.
     *
     * Workflow:
     * 1. Open registration page.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Forward request to registration page.
         */
        request.getRequestDispatcher("/WEB-INF/Pages/Auth/Register.jsp")
                .forward(request, response);
    }

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Retrieve form data.
     * 2. Encrypt password.
     * 3. Upload customer profile image.
     * 4. Insert customer data into database.
     * 5. Redirect user after registration.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            /*
             * Retrieve customer details
             * from registration form.
             */
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

            /*
             * Encrypt user password
             * before storing in database.
             */
            String hashedPassword =
                    PasswordUtil.getHashPassword(password);

            /*
             * Retrieve uploaded profile image.
             */
            Part filePart = request.getPart("customer_image");

            /*
             * Variable to store uploaded file name.
             */
            String fileName = null;

            /*
             * Check whether image file exists.
             */
            if (filePart != null && filePart.getSize() > 0) {

                /*
                 * Retrieve original uploaded file name.
                 */
                String originalFileName =
                        filePart.getSubmittedFileName();

                /*
                 * Generate unique file name
                 * using current timestamp.
                 */
                fileName = System.currentTimeMillis()
                        + "_" + originalFileName;

                /*
                 * Define upload folder path.
                 */
                String uploadPath =
                        getServletContext().getRealPath("")
                                + File.separator
                                + "Assets"
                                + File.separator
                                + "Profiles";

                /*
                 * Create upload directory object.
                 */
                File uploadDir = new File(uploadPath);

                /*
                 * Create a folder if it does not exist.
                 */
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                /*
                 * Save uploaded image file.
                 */
                filePart.write(
                        uploadPath + File.separator + fileName
                );
            }

            /*
             * Establish database connection.
             */
            Connection con = DBConnection.getConnection();

            /*
             * SQL query for inserting customer data.
             */
            String sql =
                    "INSERT INTO customer "
                            + "(first_name, last_name, gender, password, "
                            + "referral_code, customer_username, "
                            + "customer_phoneNo, customer_email, "
                            + "customer_dob, customer_address, "
                            + "customer_country, customer_image) "
                            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            /*
             * Create PreparedStatement object.
             */
            PreparedStatement statement =
                    con.prepareStatement(sql);

            /*
             * Set query parameter values.
             */
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

            /*
             * Execute insert query.
             */
            statement.executeUpdate();

            /*
             * Redirect user to login page
             * after successful registration.
             */
            response.sendRedirect("login");

        } catch (Exception e) {

            /*
             * Print error details in console.
             */
            e.printStackTrace();

            /*
             * Redirect user back to registration page
             * with an error message.
             */
            response.sendRedirect("register?error=true");
        }
    }
}