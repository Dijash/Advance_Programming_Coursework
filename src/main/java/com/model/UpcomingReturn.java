package com.model;

public class UpcomingReturn {
    private String customerName;
    private String vehicleDetails;
    private String endDate;
    private String status;

    public UpcomingReturn(String customerName, String vehicleDetails, String endDate, String status) {
        this.customerName = customerName;
        this.vehicleDetails = vehicleDetails;
        this.endDate = endDate;
        this.status = status;
    }

    public String getCustomerName() { return customerName; }
    public String getVehicleDetails() { return vehicleDetails; }
    public String getEndDate() { return endDate; }
    public String getStatus() { return status; }
}