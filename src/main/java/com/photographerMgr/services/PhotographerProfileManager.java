package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

import com.photographerMgr.models.Photographer;

public class PhotographerProfileManager {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";
    
    /**
     * Updates a user's profile in the users.txt file using bubble search algorithm and queue
     * 
     * @param originalUsername the original username to identify the user
     * @param originalEmail the original email to identify the user (as backup)
     * @param updatedUser the updated user information
     * @return true if update was successful, false otherwise
     */
    public boolean updatePhotographerProfile(String originalUsername, String originalEmail, Photographer updatedUser) {
        Queue<String> photographerRecords = loadPhotographersIntoQueue();
        boolean photographerFound = false;
        
        try {
            // Convert queue to array for bubble search
            String[] photographerArray = photographerRecords.toArray(new String[0]);
            int photographerIndex = bubbleSearchPhotographerIndex(photographerArray, originalUsername, originalEmail);
            
            if (photographerIndex != -1) {
                // User found, update the record
                photographerArray[photographerIndex] = updatedUser.toString();
                photographerFound = true;
                
                // Write the updated records back to the file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                    for (String record : photographerArray) {
                        writer.write(record);
                        writer.newLine();
                    }
                }
            }
            
            return photographerFound;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Loads all users from users.txt into a queue
     * 
     * @return Queue of user records as strings
     */
    private Queue<String> loadPhotographersIntoQueue() {
        Queue<String> queue = new LinkedList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                queue.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return queue;
    }
    
    /**
     * Implements bubble search algorithm to find the index of a user in the array
     * 
     * @param userArray array of user record strings
     * @param username the username to search for
     * @param email the email to search for (as backup)
     * @return the index of the user in the array, or -1 if not found
     */
    private int bubbleSearchPhotographerIndex(String[] photographerArray, String username, String email) {
        for (int i = 0; i < photographerArray.length - 1; i++) {
            for (int j = 0; j < photographerArray.length - i - 1; j++) {
                // Check if current record matches
                if (isPhotographerRecord(photographerArray[j], username, email)) {
                    return j;
                }
                
                // Check if next record matches
                if (isPhotographerRecord(photographerArray[j + 1], username, email)) {
                    return j + 1;
                }
                
                // Bubble sort swap if needed (optional - not relevant for search)
                if (comparePhotographerRecords(photographerArray[j], photographerArray[j + 1]) > 0) {
                    String temp = photographerArray[j];
                    photographerArray[j] = photographerArray[j + 1];
                    photographerArray[j + 1] = temp;
                }
            }
        }
        
        // Special case: check the last element if only one element in array
        if (photographerArray.length > 0 && isPhotographerRecord(photographerArray[photographerArray.length - 1], username, email)) {
            return photographerArray.length - 1;
        }
        
        return -1; // User not found
    }
    
    /**
     * Checks if a user record matches the given username or email
     * 
     * @param record the user record string
     * @param username the username to match
     * @param email the email to match
     * @return true if the record matches the username or email, false otherwise
     */
    private boolean isPhotographerRecord(String record, String username, String email) {
        String[] parts = record.split(", ");
        if (parts.length >= 3) {
            String recordUsername = parts[0];
            String recordEmail = parts[2];
            
            return recordUsername.equals(username) || recordEmail.equals(email);
        }
        return false;
    }
    
    /**
     * Compares two user records for sorting (optional - used for bubble sort)
     * 
     * @param record1 first user record
     * @param record2 second user record
     * @return negative if record1 < record2, positive if record1 > record2, 0 if equal
     */
    private int comparePhotographerRecords(String record1, String record2) {
        String[] fields1 = record1.split(", ");
        String[] fields2 = record2.split(", ");
        
        // Compare by username
        if (fields1.length > 0 && fields2.length > 0) {
            return fields1[0].compareTo(fields2[0]);
        }
        
        return 0;
    }
}