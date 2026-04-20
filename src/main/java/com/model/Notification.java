package com.model;

import java.sql.Timestamp;

public class Notification {
    private String type;
    private String description;
    private Timestamp date;

    public Notification(String type, String description, Timestamp date) {
        this.type = type;
        this.description = description;
        this.date = date;
    }

    public String getType() { return type; }
    public String getDescription() { return description; }
    public Timestamp getDate() { return date; }
}