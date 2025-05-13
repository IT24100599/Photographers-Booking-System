package com.chat.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Database utility class for managing connections and resources
 */
public class DBUtil {
    // Database connection parameters
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/chatapp?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";
    
    // You should adjust these values based on your actual database configuration
    
    static {
        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load MySQL JDBC driver: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Gets a connection to the database
     * @return a database connection
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }
    
    /**
     * Closes database resources safely
     * @param conn the database connection to close
     * @param stmt the statement to close
     * @param rs the result set to close
     */
    public static void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        // Close resources in reverse order of creation
        
        // Close ResultSet
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.err.println("Error closing ResultSet: " + e.getMessage());
            }
        }
        
        // Close Statement (PreparedStatement extends Statement)
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                System.err.println("Error closing Statement: " + e.getMessage());
            }
        }
        
        // Close Connection
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing Connection: " + e.getMessage());
            }
        }
    }
    
    /**
     * Tests the database connection
     * @return true if connection is successful
     */
    public static boolean testConnection() {
        Connection conn = null;
        try {
            System.out.println("Testing database connection...");
            conn = getConnection();
            System.out.println("Database connection successful!");
            return true;
        } catch (SQLException e) {
            System.err.println("Database connection failed: " + e.getMessage());
            return false;
        } finally {
            closeResources(conn, null, null);
        }
    }
}