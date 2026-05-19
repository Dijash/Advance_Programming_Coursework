package com.service;

import com.DAO.SubscriberDAO;

public class SubscriberService {

    private SubscriberDAO subscriberDAO;

    public SubscriberService() {
        this.subscriberDAO = new SubscriberDAO();
    }

    // FIXED: Now accepts customerId and passes it to the DAO
    public String subscribe(String email, Integer customerId) {
        if (subscriberDAO.emailExistsActive(email)) {
            return "duplicate";
        }
        if (subscriberDAO.emailExists(email)) {
            boolean success = subscriberDAO.reactivateSubscriber(email, customerId);
            return success ? "success" : "error";
        }
        boolean success = subscriberDAO.addSubscriber(email, customerId);
        return success ? "success" : "error";
    }

    public boolean unsubscribeByEmail(String email) {
        return subscriberDAO.unsubscribeByEmail(email);
    }

    public boolean isSubscribed(String email) {
        return subscriberDAO.emailExistsActive(email);
    }
}