
package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.photographerMgr.models.Photographer;

public class PhotographerProfileManager {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";

    /**
     * Updates a photographer's profile in the photographers.txt file
     *
     * @param originalUsername the original username to identify the photographer
     * @param originalEmail the original email to identify the photographer (as backup)
     * @param updatedUser the updated photographer information
     * @return true if update was successful, false otherwise
     */
    public boolean updatePhotographerProfile(String originalUsername, String originalEmail, Photographer updatedUser) {
        List<String> photographers = loadPhotographersFromFile();
        boolean photographerFound = false;
        int indexToUpdate = -1;

        // Find the photographer to update
        for (int i = 0; i < photographers.size(); i++) {
            if (isPhotographerRecord(photographers.get(i), originalUsername, originalEmail)) {
                indexToUpdate = i;
                photographerFound = true;
                break;
            }
        }

        if (photographerFound) {
            try {
                // Update the photographer record
                photographers.set(indexToUpdate, updatedUser.toString());

                // Write all records back to the file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                    for (String record : photographers) {
                        writer.write(record);
                        writer.newLine();
                    }
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
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
     * Checks if a photographer record matches the given username or email
     *
     * @param record the photographer record string
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
}
