
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

    public boolean deleteUserProfile(String username) {
        List<String> users = loadUsersFromFile();
        boolean userFound = false;

        try {
            List<String> updatedUsers = new ArrayList<>();

            for (String user : users) {
                if (isUserRecord(user, username)) {
                    userFound = true;
                } else {
                    updatedUsers.add(user);
                }
            }

            if (userFound) {
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

    private boolean isUserRecord(String record, String username) {
        String[] parts = record.split(", ");
        return parts.length > 1 && parts[1].equals(username);
    }
}
