package com.service;

import com.DAO.CustomerDAO;
import com.model.Customer;
import java.util.List;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAO();

    public List<Customer> getAllCustomers() { return customerDAO.getAllCustomers(); }
    public Customer getCustomerById(int id) { return customerDAO.getCustomerById(id); }
    public boolean deleteCustomer(int id) { return customerDAO.deleteCustomer(id); }
}