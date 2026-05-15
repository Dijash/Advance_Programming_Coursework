package com.model;

import java.sql.Timestamp;

/*
 * Model class representing a system notification.
 *
 * This POJO maps to the 'notifications' table in the database.
 * It stores various types of alerts or messages intended for
 * administrators or users (e.g., booking updates, promotional offers,
 * system maintenance alerts).
 *
 * Used for:
 *      - Displaying notification lists in admin dashboard
 *      - Sending real‑time alerts to logged‑in users
 *      - Tracking when a notification was created (date)
 */
public class Notification {

    /*
     * Unique identifier for the notification.
     * Maps to primary key column (e.g., id) in the database.
     * Auto-generated, used for deleting or updating specific notifications.
     */
    private int id;

    /*
     * Categorization of the notification.
     * Examples:
     *      "info"      – General informational message
     *      "warning"   – Important alert (e.g., upcoming maintenance)
     *      "promotion" – Discount or special offer
     *      "reminder"  – Booking or payment reminder
     * Used for UI styling (different colors/icons per type).
     */
    private String type;

    /*
     * The main content/message of the notification.
     * Example: "Your booking #123 has been confirmed."
     * May be displayed as plain text or with basic formatting.
     */
    private String description;

    /*
     * Timestamp when the notification was created/published.
     * Set automatically by the database (e.g., CURRENT_TIMESTAMP).
     * Used for sorting (newest first) and for showing relative time
     * (e.g., "2 hours ago").
     */
    private Timestamp date;

    /*
     * Constructs a new Notification object with all fields initialized.
     *
     * Parameters:
     *      id          - Unique ID of the notification (from database)
     *      type        - Category of the notification (e.g., "info", "warning")
     *      description - The notification message text
     *      date        - Creation/publish timestamp
     *
     * Called by the DAO when reading a row from the 'notifications' table.
     * Also used by service layer when creating a new notification programmatically.
     */
    public Notification(int id, String type, String description, Timestamp date) {
        this.id = id;
        this.type = type;
        this.description = description;
        this.date = date;
    }

    /*
     * Returns the unique identifier of the notification.
     *
     * Used for:
     *      - Deleting a specific notification via /deleteNotification?id=...
     *      - Updating or marking as read in the database
     *
     * @return id as int
     */
    public int getId() {
        return id;
    }

    /*
     * Returns the type/category of the notification.
     *
     * Used by the UI to apply appropriate styling (e.g., red for warning,
     * green for success, blue for info).
     *
     * @return type as String (e.g., "info", "warning", "promotion")
     */
    public String getType() {
        return type;
    }

    /*
     * Returns the description/message content of the notification.
     *
     * Shown to users as the main text of the alert.
     *
     * @return description as String
     */
    public String getDescription() {
        return description;
    }

    /*
     * Returns the timestamp when the notification was created.
     *
     * Used for:
     *      - Sorting notifications (most recent first)
     *      - Displaying date/time in user‑friendly format (e.g., "May 15, 2026")
     *
     * @return date as Timestamp
     */
    public Timestamp getDate() {
        return date;
    }
}