package com.model;

import java.sql.Timestamp;

public class Notification {
    private int id;
    private String type;
    private String description;
    private Timestamp date;

    public Notification(int id, String type, String description, Timestamp date) {
        this.id = id;
        this.type = type;
        this.description = description;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public String getType() {
        return type;
    }

    public String getDescription() {
        return description;
    }

    public Timestamp getDate() {
        return date;
    }
}