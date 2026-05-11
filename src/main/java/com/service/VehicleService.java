package com.service;

import com.DAO.VehicleDAO;
import com.model.Vehicle;

import java.util.List;

public class VehicleService {
    private VehicleDAO vehicleDAO = new VehicleDAO();

    public boolean addVehicle(int adminId, String brand, String type, String color, String numberPlate, String condition, String status, String image, double price) {
        return vehicleDAO.addVehicle(adminId, brand, type, color, numberPlate, condition, status, image, price);
    }

    public boolean deleteVehicle(int vehicleId) {
        return vehicleDAO.deleteVehicle(vehicleId);
    }

    public boolean updateVehicle(int vehicleId, String brand, String type, String color, String numberPlate, String condition, String status, String image, double price) {
        return vehicleDAO.updateVehicle(vehicleId, brand, type, color, numberPlate, condition, status, image, price);
    }

    public Vehicle getVehicleById(int id) {
        return vehicleDAO.getVehicleById(id);
    }

    public List<Vehicle> getAllVehicles() {
        return vehicleDAO.getAllVehicles();
    }

    public int getTotalVehicleCount() {
        return vehicleDAO.getTotalVehicleCount();
    }
}