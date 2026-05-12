package com.model;

import java.sql.Timestamp;

public class Subscriber {

    private int subscriberId;
    private String email;
    private Timestamp subscribedAt;
    private String status;


    public Subscriber(int subscriberId, String email, Timestamp subscribedAt, String status) {
        this.subscriberId = subscriberId;
        this.email = email;
        this.subscribedAt = subscribedAt;
        this.status = status;
    }

    public int getSubscriberId() {
        return subscriberId;
    }

    public void setSubscriberId(int subscriberId) {
        this.subscriberId = subscriberId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getSubscribedAt() {
        return subscribedAt;
    }

    public void setSubscribedAt(Timestamp subscribedAt) {
        this.subscribedAt = subscribedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
