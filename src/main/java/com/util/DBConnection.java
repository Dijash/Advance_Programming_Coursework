package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * Utility class for establishing database connections.
 *
 * This class provides a centralized way to obtain JDBC connections
 * to the MySQL database. It encapsulates database credentials and
 * connection parameters, promoting code reuse and simplifying
 * connection management across the application.
 *
 * Used by all DAO (Data Access Object) classes to interact with
 * the database for CRUD operations (Create, Read, Update, Delete).
 *
 * Design pattern: Singleton-like static factory method pattern.
 * (No instance created; all access via static getConnection() method.)
 */
public class DBConnection {

    /*
     * JDBC URL for MySQL database connection.
     *
     * Format: jdbc:mysql://host:port/database_name?parameters
     *
     * Parameters included:
     *      useSSL=false     – Disables SSL for local development
     *                         (set to true in production with proper certificates)
     *      serverTimezone=UTC – Sets timezone to UTC to avoid date/time inconsistencies
     *
     * Notes:
     *      - Host: localhost (database running on same machine as application)
     *      - Port: 3306 (default MySQL port)
     *      - Database: java_coursework (application's database name)
     */
    private static final String URL = "jdbc:mysql://localhost:3306/java_coursework?useSSL=false&serverTimezone=UTC";

    /*
     * Database username for authentication.
     * Default MySQL root user (has full privileges).
     * In production, this should be changed to a limited-privilege user.
     */
    private static final String USER = "root";

    /*
     * Database password for authentication.
     * Empty string means no password (default for local XAMPP/WAMP setups).
     * IMPORTANT: In production, always use a strong password and
     * store it in environment variables or config files (not hardcoded).
     */
    private static final String PASSWORD = "";

    /*
     * Establishes and returns a connection to the MySQL database.
     *
     * Workflow:
     * 1. Initialize connection reference as null.
     * 2. Load the MySQL JDBC driver class using Class.forName().
     * 3. Establish connection using DriverManager with URL, USER, and PASSWORD.
     * 4. If any exception occurs, print stack trace for debugging.
     * 5. Return the connection object (may be null if connection failed).
     *
     * Important Notes:
     *      - The caller (typically a DAO) is responsible for closing the
     *        connection in a finally block or try-with-resources.
     *      - Failure to close connections leads to resource leaks and
     *        database connection pool exhaustion.
     *      - This method returns null if connection fails; callers should
     *        check for null before using the connection.
     *
     * Example usage in DAO:
     *      Connection conn = null;
     *      try {
     *          conn = DBConnection.getConnection();
     *          // perform database operations
     *      } finally {
     *          if (conn != null) conn.close();
     *      }
     *
     * Alternative (try-with-resources, Java 7+):
     *      try (Connection conn = DBConnection.getConnection()) {
     *          // automatically closed after try block
     *      }
     *
     * @return Connection object connected to the database, or null if the connection fails
     */
    public static Connection getConnection() {

        /*
         * Initialize connection reference.
         * Will be set to the actual connection if successful.
         */
        Connection con = null;

        try {
            /*
             * Load the MySQL JDBC driver class.
             *
             * Class.forName() dynamically loads the driver class into memory.
             * The driver automatically registers itself with DriverManager.
             *
             * For MySQL Connector/J 8.x, the driver class is:
             *      com.mysql.cj.jdbc.Driver
             *
             * For older versions (5.x), it would be:
             *      com.mysql.jdbc.Driver
             */
            Class.forName("com.mysql.cj.jdbc.Driver");

            /*
             * Establish the actual database connection.
             * DriverManager.getConnection() uses the loaded driver to
             * create a physical network connection to the MySQL server.
             *
             * Throws SQLException if:
             *      - URL is malformed
             *      - Credentials are incorrect
             *      - Database server is not running
             *      - Network issues
             */
            con = DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (Exception e) {
            /*
             * Catch any exception that occurs during driver loading
             * or connection establishment.
             *
             * Common exceptions:
             *      - ClassNotFoundException: MySQL driver JAR missing from classpath
             *      - SQLException: Connection failed (wrong credentials, server down)
             *
             * Print stack trace for debugging (should be replaced with
             * proper logging in production.
             */
            e.printStackTrace();
        }

        /*
         * Return the connection (may be null if an exception occurred).
         * The caller must check for null before using.
         */
        return con;
    }
}