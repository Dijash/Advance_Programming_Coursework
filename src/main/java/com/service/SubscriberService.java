package com.service;

import com.DAO.SubscriberDAO;
import com.model.Subscriber;

import java.util.List;

public class SubscriberService {

    private final SubscriberDAO subscriberDAO = new SubscriberDAO();

    public String subscribe(String email) {
        if (email == null || email.trim().isEmpty()) {
            return "error";
        }

        // Already active — tell the user it's a duplicate
        if (subscriberDAO.emailExistsActive(email)) {
            return "duplicate";
        }

        // Was inactive before — reactivate instead of inserting a new row
        if (subscriberDAO.emailExists(email)) {
            boolean reactivated = subscriberDAO.reactivateSubscriber(email);
            return reactivated ? "success" : "error";
        }

        // Brand-new email
        boolean saved = subscriberDAO.addSubscriber(email);
        return saved ? "success" : "error";
    }

    public boolean unsubscribe(int subscriberId) {
        return subscriberDAO.deleteSubscriber(subscriberId);
    }

    public boolean unsubscribeByEmail(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        return subscriberDAO.unsubscribeByEmail(email.trim().toLowerCase());
    }

    public boolean isSubscribed(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        return subscriberDAO.emailExistsActive(email.trim().toLowerCase());
    }

    public List<Subscriber> getAllSubscribers() {
        return subscriberDAO.getAllSubscribers();
    }
}
