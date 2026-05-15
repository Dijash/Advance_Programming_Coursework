package com.model;

/*
 * Model class representing a vehicle that is scheduled for upcoming return.
 *
 * This POJO is used for admin dashboard widgets to display vehicles
 * that are due to be returned soon. It helps rental staff prepare
 * for vehicle inspections, cleaning, and maintenance.
 *
 * Typically populated from a database query that filters bookings
 * where the endDate is within a certain range (e.g., next 3 days)
 * and status is "active" or "confirmed".
 *
 * Used for:
 *      - Admin dashboard "Upcoming Returns" list
 *      - Generating daily handover/return reports
 *      - Sending reminders to staff about pending returns
 */
public class UpcomingReturn {

    /*
     * Full name of the customer who has the vehicle.
     * Retrieved from the associated booking and customers table.
     * Displayed in the admin return list for identification.
     * Example: "John Doe", "Jane Smith"
     */
    private String customerName;

    /*
     * Description of the vehicle being returned.
     * Includes brand, model, year, or other identifying information.
     * Example: "Toyota Camry 2022 - Silver", "Honda CR-V 2021 - Blue"
     * Helps staff locate the correct vehicle for return processing.
     */
    private String vehicleDetails;

    /*
     * The date when the vehicle is scheduled to be returned.
     * Stored as String for formatted display (e.g., "2025-05-20").
     * Used to sort upcoming returns by urgency (closest date first).
     */
    private String endDate;

    /*
     * Current booking status of the return.
     * Possible values:
     *      "active"    – Vehicle is currently rented out
     *      "confirmed" – Booking is confirmed but rental not yet started
     *      "overdue"   – Return date has passed without return
     * Used to highlight overdue returns in red in the admin panel.
     */
    private String status;

    /*
     * Constructs a new UpcomingReturn object with all fields initialized.
     *
     * Parameters:
     *      customerName    – Full name of the customer
     *      vehicleDetails  – Description of the vehicle
     *      endDate         – Scheduled return date (formatted)
     *      status          – Current booking status
     *
     * Called by the DAO when querying the database for bookings
     * that are ending soon (e.g., WHERE endDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 DAYS)).
     */
    public UpcomingReturn(String customerName, String vehicleDetails, String endDate, String status) {
        this.customerName = customerName;
        this.vehicleDetails = vehicleDetails;
        this.endDate = endDate;
        this.status = status;
    }

    /*
     * Returns the full name of the customer.
     *
     * Used for:
     *      - Displaying in "Upcoming Returns" table
     *      - Contacting customer about return procedures
     *      - Generating return receipts
     *
     * @return customerName as String
     */
    public String getCustomerName() { return customerName; }

    /*
     * Returns the vehicle description/details.
     *
     * Used for:
     *      - Identifying the correct vehicle for return
     *      - Displaying vehicle information in the return list
     *      - Preparing inspection checklists
     *
     * @return vehicleDetails as String
     */
    public String getVehicleDetails() { return vehicleDetails; }

    /*
     * Returns the scheduled return date.
     *
     * Used for:
     *      - Sorting upcoming returns (earliest dates first)
     *      - Calculating days remaining until return
     *      - Highlighting vehicles that are overdue
     *
     * @return endDate as String (formatted date)
     */
    public String getEndDate() { return endDate; }

    /*
     * Returns the current status of the booking.
     *
     * Used for:
     *      - Displaying status badges in admin panel
     *      - Flagging overdue returns (status = "overdue")
     *      - Determining which actions are allowed (e.g., extend, close)
     *
     * @return status as String (e.g., "active", "confirmed", "overdue")
     */
    public String getStatus() { return status; }
}