package com.model;

import java.sql.Date;

/*
 * Model class representing a vehicle booking record.
 *
 * This POJO (Plain Old Java Object) mirrors the structure of the 'bookings'
 * table in the database. It is used to transfer booking data between layers
 * (servlet → service → DAO → view) and to display booking information on
 * user dashboards, admin management pages, etc.
 *
 * Each instance corresponds to a single row in the bookings table.
 */
public class Booking {

    /*
     * Unique identifier for the booking.
     * Maps to the primary key column (e.g., booking_id) in the database.
     * Auto-generated, never modified after creation.
     */
    private int bookingId;

    /*
     * Full name of the customer who made the booking.
     * Retrieved from the associated user/customer record at booking time.
     * Displayed in booking lists and confirmation pages.
     */
    private String customerName;

    /*
     * Description of the booked vehicle.
     * Typically includes model, make, year, or other identifying info.
     * Example: "Toyota Camry 2022 - Silver"
     */
    private String vehicleDetails;

    /*
     * Current state of the booking.
     * Possible values (depending on business logic):
     *      "pending", "confirmed", "active", "completed", "cancelled"
     * Used to filter bookings and to determine allowed actions.
     */
    private String status;

    /*
     * First day of the rental period.
     * Stored as SQL Date (year-month-day) without time component.
     * Must be <= endDate.
     */
    private Date startDate;

    /*
     * Last day of the rental period.
     * Stored as SQL Date. The vehicle is expected to be returned by this date.
     */
    private Date endDate;

    /*
     * Total cost of the booking.
     * Stored as String to preserve formatting (currency symbols, decimal separators)
     * or as a numeric string from the database. Calculation is done in the service layer.
     * Example: "$450.00" or "450.00"
     */
    private String totalPrice;

    /*
     * License plate number of the booked vehicle.
     * Used for vehicle identification and rental handover process.
     * Example: "ABC-1234"
     */
    private String numberPlate;

    /*
     * Constructs a new Booking object with all fields initialized.
     *
     * Parameters:
     *      bookingId       - Unique ID of the booking.
     *      customerName    - Name of the customer who booked.
     *      vehicleDetails  - Description of the vehicle.
     *      status          - Current booking status (e.g., "confirmed").
     *      startDate       - Rental start date.
     *      endDate         - Rental end date.
     *      totalPrice      - Total cost of the rental period.
     *      numberPlate     - Vehicle license plate number.
     *
     * This constructor is typically called from:
     *      - BookingDAO (when reading a row from the database)
     *      - Service layer (when creating a new booking from form data)
     */
    public Booking(int bookingId, String customerName, String vehicleDetails, String status,
                   Date startDate, Date endDate, String totalPrice, String numberPlate) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.vehicleDetails = vehicleDetails;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalPrice = totalPrice;
        this.numberPlate = numberPlate;
    }

    /*
     * Returns the unique booking identifier.
     *
     * Used for:
     *      - Identifying which booking to update/cancel
     *      - Displaying in confirmation messages
     *      - Passing as a URL parameter (e.g., /viewBooking?id=123)
     *
     * @return bookingId as int
     */
    public int getBookingId() { return bookingId; }

    /*
     * Returns the full name of the customer.
     *
     * Displayed in admin booking lists, customer's own booking history,
     * and on printed/virtual receipts.
     *
     * @return customer name as String
     */
    public String getCustomerName() { return customerName; }

    /*
     * Returns a description of the booked vehicle.
     *
     * Used in booking summaries, email notifications, and admin views.
     *
     * @return vehicle details as String (e.g., "Toyota Camry 2022")
     */
    public String getVehicleDetails() { return vehicleDetails; }

    /*
     * Returns the current status of the booking.
     *
     * Status determines which operations are allowed (e.g., cancellations
     * only for "pending" or "confirmed" bookings). Also used for UI styling
     * (e.g., green for active, red for cancelled).
     *
     * @return status as String (e.g., "confirmed", "cancelled")
     */
    public String getStatus() { return status; }

    /*
     * Returns the rental start date.
     *
     * Used for date range display, availability checks, and schedule validation.
     *
     * @return startDate as java.sql.Date
     */
    public Date getStartDate() { return startDate; }

    /*
     * Returns the rental end date.
     *
     * Together with startDate defines the rental period length.
     *
     * @return endDate as java.sql.Date
     */
    public Date getEndDate() { return endDate; }

    /*
     * Returns the total price of the booking as a String.
     *
     * String type preserves formatting (e.g., "$299.99") and avoids
     * floating-point precision issues during display. For calculations,
     * The service layer should parse this value.
     *
     * @return formatted total price
     */
    public String getTotalPrice() { return totalPrice; }

    /*
     * Returns the vehicle's license plate number.
     *
     * Used for vehicle identification during pickup/drop-off and for
     * administrative reference.
     *
     * @return number plate as String (e.g., "ABC-1234")
     */
    public String getNumberPlate() { return numberPlate; }
}