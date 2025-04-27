
package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PhotographerValidator {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";

    /**
     * Checks if a username already exists
     *
     * @param username the username to check
     * @return true if the username is a duplicate, false otherwise
     */
    public boolean isDuplicateUsername(String username) {
        return isDuplicateValue(username, 0); // Username is index 0
    }

    /**
     * Checks if an email already exists
     *
     * @param email the email to check
     * @return true if the email is a duplicate, false otherwise
     */
    public boolean isDuplicateEmail(String email) {
        return isDuplicateValue(email, 2); // Email is index 2
    }

    /**
     * Checks if a phone number already exists
     *
     * @param phone the phone number to check
     * @return true if the phone number is a duplicate, false otherwise
     */
    public boolean isDuplicatePhone(String phone) {
        return isDuplicateValue(phone, 5); // Phone is index 5
    }

    /**
     * General method to check for duplicate values
     *
     * @param value the value to check
     * @param fieldIndex the index of the field in the comma-separated record
     * @return true if the value is a duplicate, false otherwise
     */
    private boolean isDuplicateValue(String value, int fieldIndex) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }

        List<String> photographers = loadPhotographersFromFile();

        // Check each photographer record for the value at the specified field index
        for (String record : photographers) {
            if (hasValueAtIndex(record, value, fieldIndex)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Loads all photographers from photographers.txt into a list
     *
     * @return List of photographer records as strings
     */
    private List<String> loadPhotographersFromFile() {
        List<String> photographers = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                photographers.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return photographers;
    }

    /**
     * Checks if a record has the specified value at the given field index
     *
     * @param record the record string
     * @param value the value to check for
     * @param fieldIndex the index of the field in the comma-separated record
     * @return true if the record has the value at the specified field index
     */
    private boolean hasValueAtIndex(String record, String value, int fieldIndex) {
        String[] fields = record.split(", ");
        return fields.length > fieldIndex && fields[fieldIndex].equals(value);
    }
}
