package com.controller.root;

import com.model.Customer;
import com.service.ContactService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/submitContact")
public class SubmitContactServlet extends HttpServlet {

    private ContactService contactService;

    @Override
    public void init() throws ServletException {
        contactService = new ContactService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        HttpSession session = request.getSession();
        Customer loggedInUser = (Customer) session.getAttribute("user");

        Integer customerId = null;
        if (loggedInUser != null) {
            customerId = loggedInUser.getCustomer_id();
        }

        try {
            boolean isSaved = contactService.saveContactMessage(customerId, firstName, lastName, email, subject, message);

            if (isSaved) {
                response.sendRedirect(request.getContextPath() + "/contact?status=success");
            } else {
                System.err.println("Database INSERT failed: No rows affected.");
                response.sendRedirect(request.getContextPath() + "/contact?status=error");
            }
        } catch (Exception e) {
            System.err.println("Critical Error during Contact Submission:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/contact?status=error");
        }
    }
}