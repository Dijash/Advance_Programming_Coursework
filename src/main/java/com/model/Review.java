package com.model;

import java.sql.Timestamp;

/*
 * Model class representing a customer review/feedback.
 *
 * This POJO maps to the 'reviews' table in the database.
 * It stores testimonials or feedback submitted by customers
 * about their experience with the vehicle rental service.
 *
 * Used for:
 *      - Displaying customer testimonials on the website homepage
 *      - Showing reviews in the admin panel for moderation
 *      - Building trust and social proof for new visitors
 *      - Allowing customers to share their rental experiences
 */
public class Review {

    /*
     * Unique identifier for the review.
     * Maps to primary key column (e.g., review_id) in the database.
     * Auto-generated, used for editing, deleting, or moderating specific reviews.
     */
    private int reviewId;

    /*
     * ID of the customer who submitted the review.
     * Maps to customer_id in the 'customers' table (foreign key relationship).
     * Used to link the review back to a registered user account.
     * Integer (not Integer wrapper) assuming every review is from a logged‑in customer.
     */
    private int customerId;

    /*
     * Full name of the customer who wrote the review.
     * Denormalized field – stored directly in the reviews table for display purposes,
     * avoiding a JOIN with the customers table every time reviews are shown.
     * Derived from customer's first_name + last_name at submission time.
     */
    private String customerName;

    /*
     * The actual feedback/review content written by the customer.
     * May include ratings (if applicable), comments about the vehicle,
     * service quality, staff behavior, etc.
     * Stored as TEXT in the database to accommodate longer messages.
     */
    private String reviewDescription;

    /*
     * Timestamp when the review was submitted.
     * Set automatically by the database (e.g., CURRENT_TIMESTAMP).
     * Used for sorting reviews (most recent first) and for showing submission date.
     */
    private Timestamp reviewDate;

    /*
     * Profile image filename of the customer who wrote the review.
     * Fetched via JOIN with the customer table.
     * May be null if the customer has not uploaded a profile photo;
     * the UI should fall back to a default avatar in that case.
     */
    private String customerImage;

    /*
     * Constructs a new Review object with all fields initialized.
     *
     * Parameters:
     *      reviewId           - Unique ID of the review (from database)
     *      customerId         - ID of the customer who wrote the review
     *      customerName       - Full name of the customer (denormalized)
     *      reviewDescription  - The review/feedback content text
     *      reviewDate         - Submission timestamp
     *      customerImage      - Profile image filename of the reviewer (nullable)
     *
     * Called by the DAO when reading a row from the 'reviews' table.
     * Also used by service layer when creating a new review from form data.
     */
    public Review(int reviewId, int customerId, String customerName,
                  String reviewDescription, Timestamp reviewDate, String customerImage) {
        this.reviewId = reviewId;
        this.customerId = customerId;
        this.customerName = customerName;
        this.reviewDescription = reviewDescription;
        this.reviewDate = reviewDate;
        this.customerImage = customerImage;
    }

    /*
     * Returns the unique identifier of the review.
     *
     * Used for:
     *      - Deleting or hiding a review from the admin panel
     *      - Editing an existing review (if allowed)
     *
     * @return reviewId as int
     */
    public int getReviewId() { return reviewId; }

    /*
     * Returns the full name of the customer who submitted the review.
     *
     * Displayed alongside the review content on the website.
     * Example: "John Doe" or "Jane Smith"
     *
     * @return customerName as String
     */
    public String getCustomerName() { return customerName; }

    /*
     * Returns the review/feedback content.
     *
     * Shown as the main testimonial text on the homepage or reviews page.
     * Should be escaped before rendering in HTML to prevent XSS attacks.
     *
     * @return reviewDescription as String
     */
    public String getReviewDescription() { return reviewDescription; }

    /*
     * Returns the timestamp when the review was submitted.
     *
     * Used for:
     *      - Sorting reviews (newest to oldest)
     *      - Displaying submission date (e.g., "Reviewed on May 15, 2026")
     *      - Showing relative time (e.g., "Posted 3 days ago")
     *
     * @return reviewDate as Timestamp
     */
    public Timestamp getReviewDate() { return reviewDate; }

    /*
     * Returns the profile image filename of the reviewer.
     *
     * Used to display the reviewer's actual photo in the testimonials section.
     * May be null — JSP must fall back to a default avatar when null or empty.
     *
     * @return customerImage as String (nullable)
     */
    public String getCustomerImage() { return customerImage; }
}