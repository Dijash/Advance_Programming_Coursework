package com.service;

import com.DAO.NotificationDAO;
import com.model.Notification;
import java.util.List;

public class NotificationService {
    private NotificationDAO notificationDAO = new NotificationDAO();

    public int getTotalNotificationCount() { return notificationDAO.getTotalNotificationCount(); }
    public List<Notification> getRecentNotifications() { return notificationDAO.getRecentNotifications(); }
    public List<Notification> getAllNotifications() { return notificationDAO.getAllNotifications(); }
    public boolean sendBroadcast(String type, String description) { return notificationDAO.sendBroadcast(type, description); }
    public boolean deleteNotification(int id) { return notificationDAO.deleteNotification(id); }
}