package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.photographerMgr.models.Photographer;

public class ShowPhotographers {
	private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";
	
	public static List<Photographer> getPhotographerList() {		
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

}
