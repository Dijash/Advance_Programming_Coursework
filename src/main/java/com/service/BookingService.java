package com.service;

import com.DAO.BookingDAO;
import com.DAO.VehicleDAO;
import com.model.Booking;
import com.model.Vehicle;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class BookingService {
    private BookingDAO bookingDAO = new BookingDAO();
    private VehicleDAO vehicleDAO = new VehicleDAO();

    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }

    public Booking getBookingById(int id) {
        return bookingDAO.getBookingById(id);
    }

    public boolean updateBookingStatus(int id, String status) {
        return bookingDAO.updateBookingStatus(id, status);
    }

    public boolean deleteBooking(int id) {
        return bookingDAO.deleteBooking(id);
    }

    public void processNewBooking(int customerId, int vehicleId, String startDateStr, String endDateStr)
            throws Exception {

        LocalDate startDate = LocalDate.parse(startDateStr);
        LocalDate endDate = LocalDate.parse(endDateStr);

        if (endDate.isBefore(startDate)) {
            throw new IllegalArgumentException("Error: The End Date cannot be before the Start Date.");
        }

        Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
        if (vehicle == null) {
            throw new Exception("Error: Vehicle not found in the database.");
        }

        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
        int totalDays = (int) daysBetween;
        if (totalDays <= 0) {
            totalDays = 1;
        }

        double dailyRate = vehicle.getVehicle_price();
        double totalPrice = totalDays * dailyRate;

        boolean isSuccess = bookingDAO.createBooking(customerId, vehicleId, startDateStr, endDateStr, totalPrice);
        if (!isSuccess) {
            throw new Exception("Database error occurred while processing your booking.");
        }
    }
}