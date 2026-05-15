package com.model;

/*
 * Model class representing a featured or top-rated vehicle for display.
 *
 * This POJO is typically used for dashboard or homepage carousels
 * to showcase popular vehicles, special offers, or recommended rentals.
 * It may be populated from a database view or a specialized query
 * that aggregates booking data or vehicle ratings.
 *
 * Used for:
 *      - Displaying "Top Vehicles" or "Recommended for You" sections
 *      - Populating vehicle cards on the homepage or user dashboard
 *      - Highlighting vehicles with highest bookings or best reviews
 */
public class TopVehicle {

    /*
     * Brand/manufacturer name of the vehicle.
     * Example: "Toyota", "Honda", "BMW", "Mercedes-Benz"
     * Displayed prominently on vehicle cards for brand recognition.
     */
    private String brand;

    /*
     * Type/category of the vehicle.
     * Example: "SUV", "Sedan", "Hatchback", "Luxury", "Economy"
     * Used for filtering and to give users quick insight into the vehicle class.
     */
    private String type;

    /*
     * Path or filename of the vehicle's image.
     * Example: "toyota_camry_2022.jpg" or "/uploads/vehicles/123.png"
     * Used for displaying the vehicle thumbnail in the UI carousel.
     */
    private String image;

    /*
     * Constructs a new TopVehicle object with all fields initialized.
     *
     * Parameters:
     *      brand – Vehicle brand/manufacturer name (e.g., "Toyota")
     *      type  – Vehicle type/category (e.g., "SUV", "Sedan")
     *      image – Path or filename of the vehicle thumbnail image
     *
     * Called by the DAO when reading data from a database view or query
     * that selects top vehicles based on booking counts or ratings.
     * Also used by the service layer when preparing featured lists
     * for homepage or user dashboard display.
     */
    public TopVehicle(String brand, String type, String image) {
        this.brand = brand;
        this.type = type;
        this.image = image;
    }

    /*
     * Returns the brand/manufacturer name of the vehicle.
     *
     * Displayed as the heading or title on vehicle cards.
     * Example output: "Toyota Camry", "Honda CR-V"
     *
     * @return brand as String
     */
    public String getBrand() {
        return brand;
    }

    /*
     * Returns the type/category of the vehicle.
     *
     * Shown as a badge or subheading on vehicle cards.
     * Helps users quickly identify the class of vehicle.
     * Example output: "SUV", "Sedan", "Luxury"
     *
     * @return type as String
     */
    public String getType() {
        return type;
    }

    /*
     * Returns the image path or filename for the vehicle.
     *
     * Used to construct the src attribute of <img> tags in the UI.
     * Example usage in JSP:
     *      <img src="${pageContext.request.contextPath}/images/${vehicle.image}">
     *
     * @return image as String
     */
    public String getImage() {
        return image;
    }
}