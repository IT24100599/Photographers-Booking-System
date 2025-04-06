package com.photographerMgr.services;

import java.io.*;
import java.util.LinkedList;
import java.util.Queue;

public class PhotographerDeletionManager {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";
    
    /**
     * Deletes a user profile from the users.txt file using bubble search and queue
     * 
     * @param username the username of the user to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deletePhotographerProfile(String username) {
        Queue<String> photographerQueue = loadPhotographerIntoQueue();
        boolean photographerFound = false;
        
        
        try {
            // Convert queue to array for bubble search
            String[] photographerArray = photographerQueue.toArray(new String[0]);
            
            // Find the user index using bubble search
            int photographerIndex = bubbleSearchPhotographerIndex(photographerArray, username);
            
            if (photographerIndex != -1) {
                // Remove the user by rebuilding the array
                String[] newPhotographerArray = new String[photographerArray.length - 1];
                
                
                // Copy elements before the index
                for (int i = 0; i < photographerIndex; i++) {
                    newPhotographerArray[i] = photographerArray[i];
                }
                
                // Copy elements after the index
                for (int i = photographerIndex + 1; i < photographerArray.length; i++) {
                    newPhotographerArray[i - 1] = photographerArray[i];
                }
                
                // Write the updated records back to the file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                    for (String record : newPhotographerArray) {
                        writer.write(record);
                        writer.newLine();
                    }
                }
                
                photographerFound = true;
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
    private Queue<String> loadPhotographerIntoQueue() {
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
     * @return the index of the user in the array, or -1 if not found
     */
    private int bubbleSearchPhotographerIndex(String[] userArray, String username) {
        for (int i = 0; i < userArray.length - 1; i++) {
            for (int j = 0; j < userArray.length - i - 1; j++) {
                // Check if current record matches
                if (isPhotographerRecord(userArray[j], username)) {
                    return j;
                }
                
                // Check if next record matches
                if (isPhotographerRecord(userArray[j + 1], username)) {
                    return j + 1;
                }
                
                // Bubble sort swap if needed (optional - not relevant for search)
                if (comparePhotographerRecords(userArray[j], userArray[j + 1]) > 0) {
                    String temp = userArray[j];
                    userArray[j] = userArray[j + 1];
                    userArray[j + 1] = temp;
                }
            }
        }
        
        // Check last element for single element array
        if (userArray.length > 0 && isPhotographerRecord(userArray[userArray.length - 1], username)) {
            return userArray.length - 1;
        }
        
        return -1; // User not found
    }
    
    /**
     * Checks if a user record matches the given username
     * 
     * @param record the user record string
     * @param username the username to match
     * @return true if the record matches the username, false otherwise
     */
    private boolean isPhotographerRecord(String record, String username) {
        String[] parts = record.split(", ");
        return parts.length > 0 && parts[0].equals(username);
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