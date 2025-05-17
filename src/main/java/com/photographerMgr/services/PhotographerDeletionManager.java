
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

    public boolean deletePhotographerProfile(String username) {
        List<String> photographers = loadPhotographersFromFile();
        boolean photographerFound = false;

        try {
            List<String> updatedPhotographers = new ArrayList<>();

            for (String photographer : photographers) {
                if (isPhotographerRecord(photographer, username)) {
                    photographerFound = true;
                } else {
                    updatedPhotographers.add(photographer);
                }
            }

            if (photographerFound) {
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

    private boolean isPhotographerRecord(String record, String username) {
        String[] parts = record.split(", ");
        return parts.length > 0 && parts[0].equals(username);
    }
}
