package com.service;

import com.DAO.UserDashboardDAO;
import com.model.Booking;
import java.util.List;

public class UserDashboardService {
    private UserDashboardDAO dashboardDAO;

    public UserDashboardService() {
        this.dashboardDAO = new UserDashboardDAO();
    }

    public int getActiveBookingsCount(int customerId) {
        return dashboardDAO.getActiveBookingsCount(customerId);
    }

    public int getCompletedTripsCount(int customerId) {
        return dashboardDAO.getCompletedTripsCount(customerId);
    }

    public double getTotalSpent(int customerId) {
        return dashboardDAO.getTotalSpent(customerId);
    }

    public List<Booking> getRecentBookings(int customerId) {
        return dashboardDAO.getRecentBookings(customerId);
    }

    public List<Booking> getAllUserBookings(int customerId) {
        return dashboardDAO.getAllUserBookings(customerId);
    }
}