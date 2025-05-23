
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

    public boolean updateUserProfile(String originalUsername, String originalEmail, User updatedUser) {
        List<String> users = loadUsersFromFile();
        boolean userFound = false;

        System.out.println("\n\nUN: " + originalUsername + ", Email: " + originalEmail);

        try {
            for (int i = 0; i < users.size(); i++) {
                if (isUserRecord(users.get(i), originalUsername, originalEmail)) {
                    users.set(i, updatedUser.toString());
                    userFound = true;
                    System.out.println("User found: " + users.get(i));
                    break;
                }
            }

            if (userFound) {
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
