package com.model;

import java.sql.Timestamp;

/*
 * Model class representing a newsletter subscriber.
 *
 * This POJO maps to the 'subscribers' table in the database.
 * It stores email addresses of users who have opted in to receive
 * promotional emails, newsletters, and updates from the company.
 *
 * Used for:
 *      - Capturing email signups from the website footer or popup
 *      - Managing email marketing campaigns
 *      - Tracking subscription status (active/unsubscribed)
 *      - Exporting subscriber lists for email marketing tools
 */
public class Subscriber {

    /*
     * Unique identifier for the subscriber.
     * Maps to primary key column (e.g., subscriber_id) in the database.
     * Auto-generated, used for updating status or removing specific subscribers.
     */
    private int subscriberId;

    /*
     * Email address of the subscriber.
     * Must be unique across all subscribers (no duplicate emails).
     * Validated for correct email format before inserting into database.
     * Used as the primary contact for sending newsletters.
     */
    private String email;

    /*
     * Timestamp when the subscription was created.
     * Set automatically by the database (e.g., CURRENT_TIMESTAMP).
     * Used for tracking subscription trends and for sorting subscribers
     * by signup date (newest first).
     */
    private Timestamp subscribedAt;

    /*
     * Current subscription status of the user.
     * Possible values:
     *      "active"      – User is subscribed and receiving emails
     *      "unsubscribed" – User has opted out (should not receive emails)
     *      "pending"      – Awaiting email confirmation (double opt‑in)
     * Used to filter active subscribers when sending campaigns.
     */
    private String status;

    /*
     * Constructs a new Subscriber object with all fields initialized.
     *
     * Parameters:
     *      subscriberId  – Unique ID of the subscriber (from database)
     *      email         – Subscriber's email address
     *      subscribedAt  – Signup timestamp
     *      status        – Current subscription status (e.g., "active")
     *
     * Called by the DAO when reading a row from the 'subscribers' table.
     * Also used by service layer when creating a new subscription.
     */
    public Subscriber(int subscriberId, String email, Timestamp subscribedAt, String status) {
        this.subscriberId = subscriberId;
        this.email = email;
        this.subscribedAt = subscribedAt;
        this.status = status;
    }

    /*
     * Returns the unique identifier of the subscriber.
     *
     * Used for:
     *      - Unsubscribing a user (status = "unsubscribed")
     *      - Deleting a subscriber from the database
     *      - Updating subscription preferences
     *
     * @return subscriberId as int
     */
    public int getSubscriberId() {
        return subscriberId;
    }

    /*
     * Sets the unique identifier of the subscriber.
     * Typically called by the DAO after inserting a new subscriber
     * (to set the auto‑generated ID) or when reading from database.
     *
     * @param subscriberId the subscriber ID to assign
     */
    public void setSubscriberId(int subscriberId) {
        this.subscriberId = subscriberId;
    }

    /*
     * Returns the subscriber's email address.
     *
     * Used for:
     *      - Sending newsletter emails
     *      - Displaying in admin subscriber list
     *      - Checking for existing subscriptions (duplicate prevention)
     *
     * @return email as String
     */
    public String getEmail() {
        return email;
    }

    /*
     * Sets the subscriber's email address.
     * Should be validated (format, uniqueness) by the service layer before saving.
     *
     * @param email email address string
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /*
     * Returns the timestamp when the subscription was created.
     *
     * Used for:
     *      - Sorting subscribers by signup date
     *      - Displaying "Member since" information
     *      - Analyzing subscription growth over time
     *
     * @return subscribedAt as Timestamp
     */
    public Timestamp getSubscribedAt() {
        return subscribedAt;
    }

    /*
     * Sets the subscription timestamp.
     * Typically assigned by the database, but can be set programmatically
     * by the service layer for testing or manual entries.
     *
     * @param subscribedAt timestamp to assign
     */
    public void setSubscribedAt(Timestamp subscribedAt) {
        this.subscribedAt = subscribedAt;
    }

    /*
     * Returns the current subscription status.
     *
     * Used by email service to determine whether to include this
     * subscriber in newsletter campaigns (only "active" status).
     *
     * @return status as String ("active", "unsubscribed", "pending")
     */
    public String getStatus() {
        return status;
    }

    /*
     * Sets the subscription status.
     *
     * Common scenarios:
     *      - "pending" → "active" after email confirmation (double opt‑in)
     *      - "active" → "unsubscribed" when user clicks unsubscribe link
     *
     * @param status status string to assign
     */
    public void setStatus(String status) {
        this.status = status;
    }
}