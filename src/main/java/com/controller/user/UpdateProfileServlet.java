package com.controller.user;

import com.service.UserService;
import com.model.Customer;
import com.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

/*
 * Servlet responsible for handling
 * user profile update functionality.
 *
 * URL Mapping:
 *      /updateProfile
 *
 * Features:
 * - Updates user profile information
 * - Handles password change (optional)
 * - Handles profile image upload
 * - Updates session user data after changes
 */
@WebServlet("/updateProfile")

/*
 * Multipart configuration for profile image upload.
 *
 * fileSizeThreshold:
 *      Memory threshold before writing to disk.
 *
 * maxFileSize:
 *      Maximum allowed file size.
 *
 * maxRequestSize:
 *      Maximum total request size.
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class UpdateProfileServlet extends HttpServlet {

    /*
     * Handles HTTP POST requests.
     *
     * Workflow:
     * 1. Validate user session.
     * 2. Retrieve updated profile data.
     * 3. Handle optional password update.
     * 4. Handle profile image upload.
     * 5. Update user data in database.
     * 6. Refresh session with updated user info.
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Retrieve existing session.
         */
        HttpSession session =
                request.getSession(false);

        /*
         * Retrieve current logged-in user.
         */
        Customer currentUser =
                (Customer) session.getAttribute("user");

        /*
         * Check if user is logged in.
         */
        if (currentUser == null) {

            /*
             * Redirect unauthenticated user to login page.
             */
            response.sendRedirect("login");

            /*
             * Stop further execution.
             */
            return;
        }

        /*
         * Retrieve updated profile fields.
         */
        String newUsername =
                request.getParameter("username");

        String newPhone =
                request.getParameter("phone");

        String newLicense =
                request.getParameter("license");

        String newAddress =
                request.getParameter("address");

        String newPassword =
                request.getParameter("password");

        /*
         * Default password remains unchanged.
         */
        String passwordToSave =
                currentUser.getPassword();

        /*
         * Check if user entered a new password.
         */
        if (newPassword != null
                && !newPassword.trim().isEmpty()) {

            /*
             * Encrypt new password.
             */
            passwordToSave =
                    PasswordUtil.getHashPassword(newPassword);
        }

        /*
         * Default profile image remains unchanged.
         */
        String imageToSave =
                currentUser.getCustomer_image();

        /*
         * Retrieve uploaded image file.
         */
        Part filePart =
                request.getPart("customer_image");

        /*
         * Check if new image is uploaded.
         */
        if (filePart != null
                && filePart.getSize() > 0) {

            /*
             * Get original file name.
             */
            String originalFileName =
                    filePart.getSubmittedFileName();

            /*
             * Generate unique file name.
             */
            String fileName =
                    System.currentTimeMillis()
                            + "_" + originalFileName;

            /*
             * Define upload directory path.
             */
            String uploadPath =
                    getServletContext().getRealPath("")
                            + File.separator
                            + "Assets"
                            + File.separator
                            + "Profiles";

            /*
             * Create upload directory if not exists.
             */
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            /*
             * Save uploaded file to server.
             */
            filePart.write(
                    uploadPath + File.separator + fileName
            );

            /*
             * Update image path to new file.
             */
            imageToSave = fileName;
        }

        /*
         * Create UserService object.
         */
        UserService userService =
                new UserService();

        /*
         * Update user profile in database.
         */
        boolean success =
                userService.updateProfile(
                        currentUser.getCustomer_id(),
                        newUsername,
                        newPhone,
                        newLicense,
                        newAddress,
                        passwordToSave,
                        imageToSave
                );

        /*
         * Profile update successful.
         */
        if (success) {

            /*
             * Fetch updated user data.
             */
            Customer updatedUser =
                    userService.getCustomerByEmail(
                            currentUser.getCustomer_email()
                    );

            /*
             * Update session with new user data.
             */
            session.setAttribute("user", updatedUser);

            /*
             * Redirect to the settings page with a success message.
             */
            response.sendRedirect("settings?success=true");

        } else {

            /*
             * Redirect to the settings page with an error message.
             */
            response.sendRedirect("settings?error=true");
        }
    }
}