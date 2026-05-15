package com.model;

/*
 * Model class representing a contact form submission.
 *
 * This POJO maps to the 'contact_messages' table in the database.
 * It stores user inquiries submitted through the "Contact Us" page,
 * whether from logged‑in customers (with customerId) or anonymous visitors.
 *
 * Used for:
 *      - Capturing form data from the contact page
 *      - Transferring messages to the service/DAO layer for storage
 *      - Displaying messages in the admin panel for review and response
 */
public class ContactMessage {

    /*
     * Unique identifier for the contact message.
     * Maps to primary key column (e.g., message_id) in the database.
     * Auto-generated, used for referencing individual messages in admin replies.
     */
    private int messageId;

    /*
     * ID of the logged‑in customer who submitted the message.
     * Can be NULL if the sender is not registered or not logged in.
     * Wrapped as Integer (not int) to allow null values.
     * Used to link message to a customer account for follow‑up.
     */
    private Integer customerId;

    /*
     * First name of the person submitting the message.
     * Required field, used in admin view and automated reply emails.
     */
    private String firstName;

    /*
     * Last name of the person submitting the message.
     * Combined with firstName for full name display.
     */
    private String lastName;

    /*
     * Email address of the sender.
     * Required field, used for replying to the inquiry and for validation.
     * Format should be validated before storing.
     */
    private String email;

    /*
     * Short subject line of the message.
     * Used in admin lists to quickly identify the topic.
     * Example: "Booking issue", "Payment question", "Feedback"
     */
    private String subject;

    /*
     * Full content of the contact message.
     * May contain line breaks and special characters.
     * Stored as text in the database.
     */
    private String message;

    /*
     * Timestamp when the message was submitted.
     * Typically set by the database (e.g., CURRENT_TIMESTAMP) or by the
     * service layer using system time. Stored as String for flexibility
     * in formatting (e.g., "2025-05-15 10:30:00").
     */
    private String submittedAt;

    /*
     * Default no-argument constructor.
     * Required for frameworks (e.g., JavaBeans specification,
     * reflection-based operations like JSP EL, some ORM tools).
     * Also allows step‑by‑step population via setters.
     */
    public ContactMessage() {
    }

    /*
     * Returns the unique identifier of the message.
     *
     * Used for:
     *      - Identifying which message to delete or mark as replied
     *      - Displaying message ID in admin panel
     *
     * @return messageId as int
     */
    public int getMessageId() {
        return messageId;
    }

    /*
     * Sets the unique identifier of the message.
     * Typically called by the DAO after inserting a new message
     * (to set the auto‑generated ID) or when reading from database.
     *
     * @param messageId the message ID to assign
     */
    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    /*
     * Returns the customer ID associated with this message.
     * May be null if the message was submitted by a non‑logged‑in user.
     *
     * @return customerId as Integer (nullable)
     */
    public Integer getCustomerId() {
        return customerId;
    }

    /*
     * Sets the customer ID for this message.
     * Should be set to null for anonymous submissions.
     *
     * @param customerId the customer ID (or null)
     */
    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    /*
     * Returns the sender's first name.
     *
     * @return firstName as String
     */
    public String getFirstName() {
        return firstName;
    }

    /*
     * Sets the sender's first name.
     * Validation (non‑empty, length limits) should be performed by the service layer.
     *
     * @param firstName first name string
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /*
     * Returns the sender's last name.
     *
     * @return lastName as String
     */
    public String getLastName() {
        return lastName;
    }

    /*
     * Sets the sender's last name.
     *
     * @param lastName last name string
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /*
     * Returns the sender's email address.
     *
     * @return email as String
     */
    public String getEmail() {
        return email;
    }

    /*
     * Sets the sender's email address.
     * Should be validated for correct format before saving.
     *
     * @param email email string
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /*
     * Returns the subject line of the message.
     *
     * @return subject as String
     */
    public String getSubject() {
        return subject;
    }

    /*
     * Sets the subject line of the message.
     *
     * @param subject subject string
     */
    public void setSubject(String subject) {
        this.subject = subject;
    }

    /*
     * Returns the full message content.
     *
     * @return message text as String
     */
    public String getMessage() {
        return message;
    }

    /*
     * Sets the full message content.
     * May contain HTML or plain text; avoid XSS by escaping when displaying.
     *
     * @param message message content
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /*
     * Returns the submission timestamp.
     * Typically formatted as "yyyy-MM-dd HH:mm:ss" or similar.
     *
     * @return submittedAt as String
     */
    public String getSubmittedAt() {
        return submittedAt;
    }

    /*
     * Sets the submission timestamp.
     * Can be assigned by the database or service layer.
     *
     * @param submittedAt timestamp string
     */
    public void setSubmittedAt(String submittedAt) {
        this.submittedAt = submittedAt;
    }
}