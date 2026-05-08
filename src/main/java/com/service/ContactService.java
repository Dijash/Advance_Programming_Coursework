package com.service;

import com.DAO.ContactDAO;

public class ContactService {
    private ContactDAO contactDAO = new ContactDAO();

    public boolean saveContactMessage(Integer customerId, String firstName, String lastName, String email, String subject, String message) {
        return contactDAO.saveContactMessage(customerId, firstName, lastName, email, subject, message);
    }
}