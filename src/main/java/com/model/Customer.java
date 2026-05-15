package com.model;

import java.sql.Timestamp;

/*
 * Model class representing a registered customer (user) in the system.
 *
 * This POJO maps to the 'customers' table in the database.
 * It holds all personal, authentication, and profile information
 * for users who have registered on the platform.
 *
 * Used for:
 *      - User registration and login (username/password validation)
 *      - Profile display and editing (personal details, license, image)
 *      - Referral system (referral_code)
 *      - Linking to bookings, contact messages, and favorite vehicles
 */
public class Customer {

    /*
     * Unique identifier for the customer.
     * Maps to primary key column (customer_id) in the database.
     * Auto-generated, used as foreign key in other tables (bookings, contact_messages, favorites).
     */
    private int customer_id;

    /*
     * Customer's first name (given name).
     * Required field, used for personalization and official documents.
     */
    private String first_name;

    /*
     * Customer's last name (family name).
     * Combined with first_name for full name display.
     */
    private String last_name;

    /*
     * Customer's gender.
     * Typically values: "Male", "Female", "Other", or "Prefer not to say".
     * Optional field for demographic purposes.
     */
    private String gender;

    /*
     * Customer's email address.
     * Used as primary contact, also for login (if username is not used).
     * Must be unique and validated for correct format.
     */
    private String customer_email;

    /*
     * Customer's phone number with country code.
     * Example: "+977 9876543210" or "123-456-7890".
     * Used for SMS notifications and emergency contact.
     */
    private String customer_phoneNo;

    /*
     * Customer's date of birth.
     * Stored as String (e.g., "1990-05-15" or "15/05/1990").
     * Used for age verification (e.g., minimum driving age).
     */
    private String customer_dob;

    /*
     * Customer's residential address.
     * Free‑text field, used for billing and rental agreement.
     */
    private String customer_address;

    /*
     * Customer's country of residence.
     * Used for legal compliance, currency preferences, and tax purposes.
     */
    private String customer_country;

    /*
     * Customer's driving license number.
     * Required for vehicle rental. Should be validated against official format.
     */
    private String customer_license;

    /*
     * Unique username chosen by the customer.
     * Used for login authentication alongside password.
     * Must be unique across all customers.
     */
    private String customer_username;

    /*
     * Referral code that belongs to this customer.
     * Can be shared with others to get discounts or rewards.
     * Typically auto-generated upon registration (e.g., "REF123ABC").
     */
    private String referral_code;

    /*
     * Customer's hashed password.
     * Never stored as plain text; always encrypted/secured.
     * Used for authentication during login.
     */
    private String password;

    /*
     * Path or filename of the customer's profile picture.
     * Example: "customer_123.jpg" or "/uploads/avatars/456.png".
     * Can be null if no image uploaded (default avatar may be used).
     */
    private String customer_image;

    /*
     * Timestamp of when the customer account was created.
     * Set automatically by the database (e.g., CURRENT_TIMESTAMP).
     * Used for account age calculations and reporting.
     */
    private Timestamp created_at;

    /*
     * Full constructor for creating a Customer object with all fields.
     *
     * Parameters:
     *      customer_id         - Unique ID from database (auto‑generated)
     *      first_name          - Customer's first name
     *      last_name           - Customer's last name
     *      gender              - Customer's gender
     *      customer_email      - Email address
     *      customer_phoneNo    - Phone number
     *      customer_dob        - Date of birth as String
     *      customer_address    - Residential address
     *      customer_country    - Country of residence
     *      customer_license    - Driving license number
     *      customer_username   - Unique login username
     *      referral_code       - Personal referral code
     *      password            - Hashed password
     *      customer_image      - Profile image path/filename
     *      created_at          - Account creation timestamp
     *
     * Called by the DAO when reading a row from the 'customers' table.
     */
    public Customer(int customer_id, String first_name, String last_name, String gender,
                    String customer_email, String customer_phoneNo, String customer_dob,
                    String customer_address, String customer_country, String customer_license,
                    String customer_username, String referral_code, String password,
                    String customer_image, Timestamp created_at) {
        this.customer_id = customer_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.customer_email = customer_email;
        this.customer_phoneNo = customer_phoneNo;
        this.customer_dob = customer_dob;
        this.customer_address = customer_address;
        this.customer_country = customer_country;
        this.customer_license = customer_license;
        this.customer_username = customer_username;
        this.referral_code = referral_code;
        this.password = password;
        this.customer_image = customer_image;
        this.created_at = created_at;
    }

    /*
     * Returns the hashed password of the customer.
     *
     * Used during login to compare with the input password after hashing.
     * This value should never be exposed in logs or frontend responses.
     *
     * @return password hash as String
     */
    public String getPassword() { return password; }

    /*
     * Returns the unique identifier of the customer.
     *
     * Used for:
     *      - Session attribute ("user") to identify logged‑in user
     *      - Retrieving bookings, favorites, contact messages for this customer
     *
     * @return customer_id as int
     */
    public int getCustomer_id() { return customer_id; }

    /*
     * Returns the customer's first name.
     *
     * @return first_name as String
     */
    public String getFirst_name() { return first_name; }

    /*
     * Returns the customer's last name.
     *
     * @return last_name as String
     */
    public String getLast_name() { return last_name; }

    /*
     * Returns the customer's email address.
     *
     * Used for email notifications, password reset, and contact.
     *
     * @return customer_email as String
     */
    public String getCustomer_email() { return customer_email; }

    /*
     * Returns the customer's phone number.
     *
     * @return customer_phoneNo as String
     */
    public String getCustomer_phoneNo() { return customer_phoneNo; }

    /*
     * Returns the customer's driving license number.
     *
     * @return customer_license as String
     */
    public String getCustomer_license() { return customer_license; }

    /*
     * Returns the customer's residential address.
     *
     * @return customer_address as String
     */
    public String getCustomer_address() { return customer_address; }

    /*
     * Returns the customer's username for login.
     *
     * @return customer_username as String
     */
    public String getCustomer_username() { return customer_username; }

    /*
     * Returns the customer's date of birth as a String.
     *
     * @return customer_dob as String
     */
    public String getCustomer_dob() { return customer_dob; }

    /*
     * Returns the customer's country of residence.
     *
     * @return customer_country as String
     */
    public String getCustomer_country() { return customer_country; }

    /*
     * Returns the customer's gender.
     *
     * @return gender as String
     */
    public String getGender() { return gender; }

    /*
     * Returns the customer's personal referral code.
     *
     * @return referral_code as String
     */
    public String getReferral_code() { return referral_code; }

    /*
     * Returns the path/filename of the customer's profile image.
     *
     * May be null; UI should handle with default avatar.
     *
     * @return customer_image as String
     */
    public String getCustomer_image() { return customer_image; }

    /*
     * Returns the account creation timestamp.
     *
     * @return created_at as Timestamp
     */
    public Timestamp getCreated_at() { return created_at; }

    /*
     * Returns the customer's full name by concatenating first and last name.
     *
     * Example:
     *      first_name = "John", last_name = "Doe" → "John Doe"
     *
     * Used in UI headings, email greetings, booking summaries.
     *
     * @return full name as String
     */
    public String getFullName() {
        return first_name + " " + last_name;
    }
}