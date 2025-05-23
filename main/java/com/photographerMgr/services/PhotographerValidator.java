
package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PhotographerValidator {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";

    public boolean isDuplicateUsername(String username) {
        return isDuplicateValue(username, 0);
    }

    public boolean isDuplicateEmail(String email) {
        return isDuplicateValue(email, 2); 
    }

    public boolean isDuplicatePhone(String phone) {
        return isDuplicateValue(phone, 5); 
    }

    private boolean isDuplicateValue(String value, int fieldIndex) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }

        List<String> photographers = loadPhotographersFromFile();

        for (String record : photographers) {
            if (hasValueAtIndex(record, value, fieldIndex)) {
                return true;
            }
        }

        return false;
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

    private boolean hasValueAtIndex(String record, String value, int fieldIndex) {
        String[] fields = record.split(", ");
        return fields.length > fieldIndex && fields[fieldIndex].equals(value);
    }
}
