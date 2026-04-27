package com.service;

import com.DAO.UserDAO;
import com.model.Customer;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public boolean updateProfile(int id, String username, String phone, String license, String address, String password, String image) {
        // Business logic and validation can be added here in the future
        return userDAO.updateCustomerProfile(id, username, phone, license, address, password, image);
    }

    public Customer getCustomerByEmail(String email) {
        return userDAO.getCustomerByEmail(email);
    }
}