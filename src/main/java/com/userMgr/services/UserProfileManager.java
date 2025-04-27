
package com.userMgr.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.userMgr.models.User;

public class UserProfileManager {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\users.txt";

    /**
     * Updates a user's profile in the users.txt file
     *
     * @param originalUsername the original username to identify the user
     * @param originalEmail the original email to identify the user (as backup)
     * @param updatedUser the updated user information
     * @return true if update was successful, false otherwise
     */
    public boolean updateUserProfile(String originalUsername, String originalEmail, User updatedUser) {
        List<String> users = loadUsersFromFile();
        boolean userFound = false;

        System.out.println("\n\nUN: " + originalUsername + ", Email: " + originalEmail);

        try {
            // Find and update the user record
            for (int i = 0; i < users.size(); i++) {
                if (isUserRecord(users.get(i), originalUsername, originalEmail)) {
                    users.set(i, updatedUser.toString());
                    userFound = true;
                    System.out.println("User found: " + users.get(i));
                    break;
                }
            }

            if (userFound) {
                // Write the updated records back to the file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                    for (String record : users) {
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
     * Checks if a user record matches the given username or email
     *
     * @param record the user record string
     * @param username the username to match
     * @param email the email to match
     * @return true if the record matches the username or email, false otherwise
     */
    private boolean isUserRecord(String record, String username, String email) {
        String[] parts = record.split(", ");
        if (parts.length >= 4) {
            String recordUsername = parts[1];
            String recordEmail = parts[3];

            return recordUsername.equals(username) || recordEmail.equals(email);
        }
        return false;
    }
}
