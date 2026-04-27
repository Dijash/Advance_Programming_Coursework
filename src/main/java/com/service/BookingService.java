package com.service;

import com.DAO.BookingDAO;
import com.model.Booking;
import java.util.List;

public class BookingService {
    private BookingDAO bookingDAO = new BookingDAO();

    public List<Booking> getAllBookings() { return bookingDAO.getAllBookings(); }
    public Booking getBookingById(int id) { return bookingDAO.getBookingById(id); }
    public boolean updateBookingStatus(int id, String status) { return bookingDAO.updateBookingStatus(id, status); }
    public boolean deleteBooking(int id) { return bookingDAO.deleteBooking(id); }
}