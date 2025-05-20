
package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.photographerMgr.models.Photographer;

public class PhotographerDataProcessor {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";

    public Photographer authenticateUser(String userIdentifier, String password) {
        List<Photographer> photographers = loadPhotographersFromFile();
        
        System.out.println("User Identifier: " + userIdentifier + ", Password: " + password+"\n");

        for (Photographer photographer : photographers) {
        	System.out.println("Checking photographer: " + photographer.getUsername() + ", Password: " + photographer.getPassword());
            if (isMatchingUser(photographer, userIdentifier, password)) {
                return photographer;
            }
        }

        return null;
    }
    
    public Photographer getPhotographerByUsername(String tagUser) {
		List<Photographer> photographers = loadPhotographersFromFile();

		
		
		try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(", ");

                if (parts.length >= 11) {
                    String username = parts[0];
                    String pwd = "null";
                    String email = parts[2];
                    String gender = parts[3];
                    String address = parts[4];
                    String phone = parts[5];
                    String skills = parts[6];
                    String fullName = parts[7];
                    String experience = parts[8];
                    String description = parts[9];
                    Double ratings = Double.parseDouble(parts[10]);

                    Photographer photographer = new Photographer(username, pwd, email, gender, address, phone, skills, fullName);
                    photographer.setExperience(experience);
                    photographer.setDescription(description);
                    photographer.setRatings(ratings);
                    photographers.add(photographer);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
		
		for (Photographer photographer : photographers) {
			if (photographer.getUsername().equals(tagUser)) {
				return photographer;
			}
		}

		return null;
	}

    private List<Photographer> loadPhotographersFromFile() {
        List<Photographer> photographers = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(", ");

                if (parts.length >= 11) {
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
                    Double ratings = Double.parseDouble(parts[10]);

                    Photographer photographer = new Photographer(username, pwd, email, gender, address, phone, skills, fullName);
                    photographer.setExperience(experience);
                    photographer.setDescription(description);
                    photographer.setRatings(ratings);
                    photographers.add(photographer);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return photographers;
    }

    private boolean isMatchingUser(Photographer photographer, String userIdentifier, String password) {
        return (photographer.getUsername().equals(userIdentifier) || 
                photographer.getEmail().equals(userIdentifier)) && 
                photographer.getPassword().equals(password);
    }
}
