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

        email = email.trim().toLowerCase();


        if (subscriberDAO.emailExists(email)) {
            return "duplicate";
        }

        boolean saved = subscriberDAO.addSubscriber(email);
        return saved ? "success" : "error";
    }

    public boolean unsubscribe(int subscriberId) {
        return subscriberDAO.deleteSubscriber(subscriberId);
    }

    public List<Subscriber> getAllSubscribers() {
        return subscriberDAO.getAllSubscribers();
    }
}
