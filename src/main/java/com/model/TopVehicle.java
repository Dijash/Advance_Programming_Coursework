package com.model;

public class TopVehicle {
    private String brand;
    private String type;
    private String image;

    public TopVehicle(String brand, String type, String image) {
        this.brand = brand;
        this.type = type;
        this.image = image;
    }

    public String getBrand() { return brand; }
    public String getType() { return type; }
    public String getImage() { return image; }
}