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

@WebServlet("/updateProfile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Customer currentUser = (Customer) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login");
            return;
        }

        String newUsername = request.getParameter("username");
        String newPhone = request.getParameter("phone");
        String newLicense = request.getParameter("license");
        String newAddress = request.getParameter("address");
        String newPassword = request.getParameter("password");

        String passwordToSave = currentUser.getPassword();
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            passwordToSave = PasswordUtil.getHashPassword(newPassword);
        }

        String imageToSave = currentUser.getCustomer_image();
        Part filePart = request.getPart("customer_image");

        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = filePart.getSubmittedFileName();
            String fileName = System.currentTimeMillis() + "_" + originalFileName;

            String uploadPath = getServletContext().getRealPath("") + File.separator + "Assets" + File.separator + "Profiles";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + fileName);
            imageToSave = fileName;
        }

        UserService userService = new UserService();
        boolean success = userService.updateProfile(
                currentUser.getCustomer_id(),
                newUsername,
                newPhone,
                newLicense,
                newAddress,
                passwordToSave,
                imageToSave
        );

        if (success) {
            Customer updatedUser = userService.getCustomerByEmail(currentUser.getCustomer_email());
            session.setAttribute("user", updatedUser);
            response.sendRedirect("settings?success=true");
        } else {
            response.sendRedirect("settings?error=true");
        }
    }
}