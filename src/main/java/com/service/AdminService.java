package com.service;

import com.DAO.AdminDAO;
import com.model.Booking;
import java.util.List;

public class AdminService {
    private AdminDAO adminDAO = new AdminDAO();

    public List<Booking> getUpcomingReturns() { return adminDAO.getUpcomingReturns(); }
    public boolean deleteNotification(int notificationId) { return adminDAO.deleteNotification(notificationId); }
}