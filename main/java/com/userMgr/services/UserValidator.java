
package com.userMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class UserValidator {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\users.txt";

    public boolean isDuplicateUsername(String username) {
        return isDuplicateValue(username, 1); // Username is index 1
    }
    public boolean isDuplicateEmail(String email) {
        return isDuplicateValue(email, 3); // Email is index 3
    }

 
    public boolean isDuplicatePhone(String phone) {
        return isDuplicateValue(phone, 6); // Phone is index 6
    }

    private boolean isDuplicateValue(String value, int fieldIndex) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }

        List<String> users = loadUsersFromFile();

        for (String record : users) {
            if (hasValueAtIndex(record, value, fieldIndex)) {
                return true;
            }
            
            
            
        }
        return false;
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

    private boolean hasValueAtIndex(String record, String value, int fieldIndex) {
        String[] fields = record.split(", ");
        return fields.length > fieldIndex && fields[fieldIndex].equals(value);
    }
}
