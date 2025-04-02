
package com.userMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

public class UserValidator {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\users.txt";

    /**
     * Checks if a username already exists using bubble search algorithm and queue
     *
     * @param username the username to check
     * @return true if the username is a duplicate, false otherwise
     */
    public boolean isDuplicateUsername(String username) {
        return isDuplicateValue(username, 1); // Username is index 1
    }

    /**
     * Checks if an email already exists using bubble search algorithm and queue
     *
     * @param email the email to check
     * @return true if the email is a duplicate, false otherwise
     */
    public boolean isDuplicateEmail(String email) {
        return isDuplicateValue(email, 3); // Email is index 3
    }

    /**
     * Checks if a phone number already exists using bubble search algorithm and queue
     *
     * @param phone the phone number to check
     * @return true if the phone number is a duplicate, false otherwise
     */
    public boolean isDuplicatePhone(String phone) {
        return isDuplicateValue(phone, 6); // Phone is index 6
    }

    /**
     * General method to check for duplicate values using bubble search algorithm and queue
     *
     * @param value the value to check
     * @param fieldIndex the index of the field in the comma-separated user record
     * @return true if the value is a duplicate, false otherwise
     */
    private boolean isDuplicateValue(String value, int fieldIndex) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }

        Queue<String> userQueue = loadUsersIntoQueue();

        if (userQueue.isEmpty()) {
            return false;
        }

        // Convert queue to array for bubble search
        String[] userArray = userQueue.toArray(new String[0]);

        // Perform bubble search for duplicate value
        return bubbleSearchForDuplicate(userArray, value, fieldIndex);
    }

    /**
     * Loads all users from users.txt into a queue
     *
     * @return Queue of user records as strings
     */
    private Queue<String> loadUsersIntoQueue() {
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
     * Implements bubble search algorithm to find duplicates
     *
     * @param userArray array of user record strings
     * @param value the value to search for
     * @param fieldIndex the index of the field in the comma-separated user record
     * @return true if a duplicate is found, false otherwise
     */
    private boolean bubbleSearchForDuplicate(String[] userArray, String value, int fieldIndex) {
        for (int i = 0; i < userArray.length - 1; i++) {
            for (int j = 0; j < userArray.length - i - 1; j++) {
                // Check if current record has the value
                if (hasValueAtIndex(userArray[j], value, fieldIndex)) {
                    return true;
                }

                // Check if next record has the value
                if (hasValueAtIndex(userArray[j + 1], value, fieldIndex)) {
                    return true;
                }

                // Bubble sort swap if needed (optional - not relevant for search)
                if (compareUserRecords(userArray[j], userArray[j + 1]) > 0) {
                    String temp = userArray[j];
                    userArray[j] = userArray[j + 1];
                    userArray[j + 1] = temp;
                }
            }
        }

        // Check last element in case of single element array
        if (userArray.length > 0) {
            return hasValueAtIndex(userArray[userArray.length - 1], value, fieldIndex);
        }

        return false;
    }

    /**
     * Checks if a user record has the specified value at the given field index
     *
     * @param record the user record string
     * @param value the value to check for
     * @param fieldIndex the index of the field in the comma-separated user record
     * @return true if the record has the value at the specified field index
     */
    private boolean hasValueAtIndex(String record, String value, int fieldIndex) {
        String[] fields = record.split(", ");
        return fields.length > fieldIndex && fields[fieldIndex].equals(value);
    }

    /**
     * Compares two user records for sorting (optional - used for bubble sort)
     *
     * @param record1 first user record
     * @param record2 second user record
     * @return negative if record1 < record2, positive if record1 > record2, 0 if equal
     */
    private int compareUserRecords(String record1, String record2) {
        String[] fields1 = record1.split(", ");
        String[] fields2 = record2.split(", ");

        // Compare by username
        if (fields1.length > 1 && fields2.length > 1) {
            return fields1[1].compareTo(fields2[1]);
        }

        return 0;
    }
}
