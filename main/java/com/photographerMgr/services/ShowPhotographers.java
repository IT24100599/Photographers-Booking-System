package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.photographerMgr.models.Photographer;

public class ShowPhotographers {
	private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";
	
	public static List<Photographer> getPhotographerList(String sortBy) {		
        List<Photographer> photographers = new ArrayList<>();
        List<Photographer> sortedPhotographers = new ArrayList<>();
        BubbleSort bubbleSort = new BubbleSort();
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
        
        if (sortBy.equals("r_LH")) {
        	sortedPhotographers = bubbleSort.ratingsLH(photographers);
		} else if (sortBy.equals("r_HL")) {
			sortedPhotographers = bubbleSort.ratingsHL(photographers);
		} else if (sortBy.equals("default") || sortBy.equals("")) {
			sortedPhotographers = photographers;
		} else {
			System.out.println("Invalid sorting. Return unsorted list.");
			sortedPhotographers = photographers;
		}
		
		/*System.out.println("Sorted Photographers:");
		for (Photographer photographer : sortedPhotographers) {
			System.out.println(photographer);
		}*/
        
        return sortedPhotographers;
    }
}
	

class BubbleSort {
    int n;
    boolean swapped;
    
    public List<Photographer> ratingsLH(List<Photographer> array) {
        n = array.size();

        /*System.out.print("Array: ");
        for (Photographer i: array) {
            System.out.print(i+", ");
        }
        System.out.println();*/

        do {
            swapped = false;
            for (int i = 1; i < n; i++) {
                if (array.get(i).getRatings() < array.get(i - 1).getRatings()) {
                    Photographer temp = array.get(i);
                    array.set(i, array.get(i-1));
                    array.set(i-1, temp);
                    swapped = true;
                }
            }
            n--;
        } while (swapped);

        return array;

    }
    

    public List<Photographer> ratingsHL(List<Photographer> array) {
        n = array.size();

        /*System.out.print("Array: ");
        for (Photographer i: array) {
            System.out.print(i+", ");
        }
        System.out.println();*/

        do {
            swapped = false;
            for (int i = 1; i < n; i++) {
                if (array.get(i).getRatings() > array.get(i - 1).getRatings()) {
                    Photographer temp = array.get(i);
                    array.set(i, array.get(i-1));
                    array.set(i-1, temp);
                    swapped = true;
                }
            }
            n--;
        } while (swapped);

        return array;

    }
}
