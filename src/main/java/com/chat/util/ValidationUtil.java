package com.chat.util;

import java.util.regex.Pattern;

/**
 * Utility class for validating user input
 */
public class ValidationUtil {
    
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
    
    // Username validation pattern (3-20 chars, letters, numbers, underscore, hyphen)
    private static final Pattern USERNAME_PATTERN =
        Pattern.compile("^[a-zA-Z0-9_-]{3,20}$");
    
    // Password validation pattern (min 8 chars, at least 1 uppercase, 1 lowercase, 1 number)
    private static final Pattern PASSWORD_PATTERN =
        Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$");
    
    /**
     * Validates an email address format
     * @param email the email address to validate
     * @return true if the email is valid
     */
    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }
    
    /**
     * Validates a username format
     * @param username the username to validate
     * @return true if the username is valid
     */
    public static boolean isValidUsername(String username) {
        if (username == null) {
            return false;
        }
        return USERNAME_PATTERN.matcher(username).matches();
    }
    
    /**
     * Validates a password format
     * @param password the password to validate
     * @return true if the password is valid
     */
    public static boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        return PASSWORD_PATTERN.matcher(password).matches();
    }
    
    /**
     * Sanitizes input to prevent XSS attacks
     * @param input the string to sanitize
     * @return the sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return "";
        }
        
        return input.replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#x27;")
                   .replace("&", "&amp;")
                   .replace("/", "&#x2F;");
    }
}