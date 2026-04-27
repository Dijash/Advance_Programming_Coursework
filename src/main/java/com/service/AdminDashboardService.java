package com.service;

import com.DAO.AdminDashboardDAO;
import com.model.TopVehicle;
import com.model.UpcomingReturn;
import java.util.List;

public class AdminDashboardService {
    private AdminDashboardDAO adminDAO;

    public AdminDashboardService() {
        this.adminDAO = new AdminDashboardDAO();
    }

    public int getTotalBookings() {
        return adminDAO.getTotalBookings();
    }

    public int getTotalVehicles() {
        return adminDAO.getTotalVehicles();
    }

    public double getTotalRevenue() {
        return adminDAO.getTotalRevenue();
    }

    public int getActiveRentalsCount() {
        return adminDAO.getActiveRentalsCount();
    }

    public List<UpcomingReturn> getUpcomingReturns() {
        return adminDAO.getUpcomingReturns();
    }

    public TopVehicle getTopVehicle() {
        return adminDAO.getTopVehicle();
    }
}