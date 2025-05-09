package com.chat.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class for password hashing and verification
 */
public class PasswordUtil {
    
    private static final int SALT_LENGTH = 16; // 16 bytes = 128 bits
    
    /**
     * Hashes a password with a random salt using SHA-256
     * @param password the password to hash
     * @return the hashed password with salt
     * @throws NoSuchAlgorithmException if the algorithm is not available
     */
    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        // Generate a random salt
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        
        // Hash the password with the salt
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        byte[] hashedPassword = md.digest(password.getBytes());
        
        // Combine salt and hashed password and encode with Base64
        byte[] combined = new byte[salt.length + hashedPassword.length];
        System.arraycopy(salt, 0, combined, 0, salt.length);
        System.arraycopy(hashedPassword, 0, combined, salt.length, hashedPassword.length);
        
        return Base64.getEncoder().encodeToString(combined);
    }
    
    /**
     * Verifies a password against a stored hash
     * @param password the password to verify
     * @param storedHash the stored hash
     * @return true if the password matches
     * @throws NoSuchAlgorithmException if the algorithm is not available
     */
    public static boolean verifyPassword(String password, String storedHash) throws NoSuchAlgorithmException {
        // Decode the stored hash
        byte[] combined = Base64.getDecoder().decode(storedHash);
        
        // Extract the salt
        byte[] salt = new byte[SALT_LENGTH];
        System.arraycopy(combined, 0, salt, 0, SALT_LENGTH);
        
        // Hash the provided password with the extracted salt
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        byte[] hashedPassword = md.digest(password.getBytes());
        
        // Compare the hashed provided password with the stored hash
        for (int i = 0; i < hashedPassword.length; i++) {
            if (hashedPassword[i] != combined[SALT_LENGTH + i]) {
                return false;
            }
        }
        
        return true;
    }
}