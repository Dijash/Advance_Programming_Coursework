package com.model;

import java.sql.Timestamp;

public class Notification {
    private int id; // Added ID field
    private String type;
    private String description;
    private Timestamp date;

    // Updated Constructor
    public Notification(int id, String type, String description, Timestamp date) {
        this.id = id;
        this.type = type;
        this.description = description;
        this.date = date;
    }

    public int getId() { return id; }
    public String getType() { return type; }
    public String getDescription() { return description; }
    public Timestamp getDate() { return date; }
}