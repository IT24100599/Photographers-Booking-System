
package com.userMgr.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class UserDeletionManager {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\users.txt";

    /**
     * Deletes a user profile from the users.txt file
     *
     * @param username the username of the user to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteUserProfile(String username) {
        List<String> users = loadUsersFromFile();
        boolean userFound = false;

        try {
            // Create a new list without the user to be deleted
            List<String> updatedUsers = new ArrayList<>();

            for (String user : users) {
                if (isUserRecord(user, username)) {
                    userFound = true;
                } else {
                    updatedUsers.add(user);
                }
            }

            if (userFound) {
                // Write the updated records back to the file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                    for (String record : updatedUsers) {
                        writer.write(record);
                        writer.newLine();
                    }
                }
            }

            return userFound;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Loads all users from users.txt into a list
     *
     * @return List of user records as strings
     */
    private List<String> loadUsersFromFile() {
        List<String> users = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                users.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return users;
    }

    /**
     * Checks if a user record matches the given username
     *
     * @param record the user record string
     * @param username the username to match
     * @return true if the record matches the username, false otherwise
     */
    private boolean isUserRecord(String record, String username) {
        String[] parts = record.split(", ");
        return parts.length > 1 && parts[1].equals(username);
    }
}
