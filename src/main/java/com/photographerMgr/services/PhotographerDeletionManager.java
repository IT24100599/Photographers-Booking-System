
package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PhotographerDeletionManager {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";

    /**
     * Deletes a photographer profile from the photographers.txt file
     *
     * @param username the username of the photographer to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deletePhotographerProfile(String username) {
        List<String> photographers = loadPhotographersFromFile();
        boolean photographerFound = false;

        try {
            // Create a new list without the photographer to be deleted
            List<String> updatedPhotographers = new ArrayList<>();

            for (String photographer : photographers) {
                if (isPhotographerRecord(photographer, username)) {
                    photographerFound = true;
                } else {
                    updatedPhotographers.add(photographer);
                }
            }

            if (photographerFound) {
                // Write the updated records back to the file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                    for (String record : updatedPhotographers) {
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
     * Checks if a photographer record matches the given username
     *
     * @param record the photographer record string
     * @param username the username to match
     * @return true if the record matches the username, false otherwise
     */
    private boolean isPhotographerRecord(String record, String username) {
        String[] parts = record.split(", ");
        return parts.length > 0 && parts[0].equals(username);
    }
}
