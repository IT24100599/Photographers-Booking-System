
package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.photographerMgr.models.Photographer;

public class PhotographerDataProcessor {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";

    /**
     * Authenticates a user based on username/email and password
     * 
     * @param userIdentifier username or email
     * @param password user's password
     * @return Photographer object if authenticated, null otherwise
     */
    public Photographer authenticateUser(String userIdentifier, String password) {
        List<Photographer> photographers = loadPhotographersFromFile();
        
        System.out.println("User Identifier: " + userIdentifier + ", Password: " + password+"\n");

        for (Photographer photographer : photographers) {
        	System.out.println("Checking photographer: " + photographer.getUsername() + ", Password: " + photographer.getPassword());
            if (isMatchingUser(photographer, userIdentifier, password)) {
                return photographer;
            }
        }

        return null; // User not found or credentials don't match
    }

    /**
     * Loads all photographers from photographers.txt file
     * 
     * @return List of Photographer objects
     */
    private List<Photographer> loadPhotographersFromFile() {
        List<Photographer> photographers = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(", ");

                if (parts.length >= 10) {
                    String username = parts[0];
                    String pwd = parts[1];
                    String email = parts[2];
                    String gender = parts[3];
                    String address = parts[4];
                    String phone = parts[5];
                    String skills = parts[6];
                    String fullName = parts[7];
                    String experience = parts[8];
                    String description = parts[9];

                    Photographer photographer = new Photographer(username, pwd, email, gender, address, phone, skills, fullName);
                    photographer.setExperience(experience);
                    photographer.setDescription(description);
                    photographers.add(photographer);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return photographers;
    }

    /**
     * Checks if a photographer matches the provided credentials
     * 
     * @param photographer Photographer object
     * @param userIdentifier username or email
     * @param password photographer's password
     * @return true if matching, false otherwise
     */
    private boolean isMatchingUser(Photographer photographer, String userIdentifier, String password) {
        return (photographer.getUsername().equals(userIdentifier) || 
                photographer.getEmail().equals(userIdentifier)) && 
                photographer.getPassword().equals(password);
    }
}
