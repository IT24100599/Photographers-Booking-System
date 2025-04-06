package com.photographerMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

import com.photographerMgr.models.Photographer;

public class PhotographerDataProcessor {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";
    
    /**
     * Authenticates a user using bubble search algorithm on a queue of users
     * @param userIdentifier username or email
     * @param password user's password
     * @return User object if authenticated, null otherwise
     */
    public Photographer authenticateUser(String userIdentifier, String password) {
    	System.out.println("\nauthenticateUser");
        Queue<Photographer> photographerQueue = loadUsersIntoQueue();
        
        System.out.println("Queue: " + photographerQueue);
        System.out.println();
        
        return bubbleSearchUser(photographerQueue, userIdentifier, password);
    }
    
    /**
     * Loads all users from users.txt into a queue
     * @return Queue of User objects
     */
    private Queue<Photographer> loadUsersIntoQueue() {
    	System.out.println("\nloadUsersIntoQueue");
    	
        Queue<Photographer> queue = new LinkedList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            
            
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(", ");
                System.out.println("Reading file: " + line);
                
                System.out.println("Parts: " + parts.length);
                
                if (parts.length >= 8) {
                    String username = parts[0];
                    String pwd = parts[1];
                    String email = parts[2];
                    String gender = parts[3];
                    String address = parts[4];
                    String phone = parts[5];
                    String skills = parts[6];
                    String fullName = parts[7];
                    
                    System.out.println("\nAdding photographer: " + username);
                    System.out.println("Password: " + pwd);
                    System.out.println("Email: " + email);
                    System.out.println("Full Name: " + fullName);
                    System.out.println("Gender: "+ gender);
                    System.out.println("Address: " + address);
                    System.out.println("Phone: " + phone);
                    System.out.println("Skills: " + skills+ "\n");
                    
                    Photographer photographer = new Photographer(username, pwd, email, gender, address, phone, skills, fullName);
                    
                    System.out.println("Photographer object created: " + photographer);
                    queue.add(photographer);
                    System.out.println();
              	   System.out.println("Photographer added: " + photographer);
                }  
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return queue;
    }
    
    /**
     * Implements bubble search algorithm on a queue of users
     * Bubble search: We compare adjacent elements (in this case, we're using it to search through the queue)
     * @param userQueue queue of users
     * @param userIdentifier username or email
     * @param password user's password
     * @return User object if found and authenticated, null otherwise
     */
   /* private Photographer bubbleSearchUser(Queue<Photographer> userQueue, String userIdentifier, String password) {
        int size = userQueue.size();
        Photographer[] photographers = new Photographer[size];
        
        // Convert queue to array for bubble search
        for (int i = 0; i < size; i++) {
            photographers[i] = userQueue.remove();
        }
        
        // Bubble search algorithm
        for (int i = 0; i < size - 1; i++) {
            for (int j = 0; j < size - i - 1; j++) {
                // Check current position
                if (isMatchingUser(photographers[j], userIdentifier, password)) {
                    return photographers[j];
                }
                
                // Check next position
                if (isMatchingUser(photographers[j+1], userIdentifier, password)) {
                    return photographers[j+1];
                }
            }
        }
        
        return null; // User not found or credentials don't match
    }*/
    
    private Photographer bubbleSearchUser(Queue<Photographer> userQueue, String userIdentifier, String password) {
    	
    	System.out.println("\nbubbleSearchUser");
        int size = userQueue.size();
        Photographer[] photographers = new Photographer[size];
        
        
        System.out.println("Size of queue: " + size);
        
        // Convert queue to array and preserve queue contents
        for (int i = 0; i < size; i++) {
        	Photographer photographer = userQueue.remove();
            photographers[i] = photographer;
            userQueue.add(photographer); // Add back to queue
        }

        // Simple linear search is more appropriate for finding a user
        for (Photographer user : photographers) {
            if (isMatchingUser(user, userIdentifier, password)) {
            	System.out.println("user: " + user.getUsername() + ", " + user.getEmail());
                return user;
            }
        }

        return null; // User not found or credentials don't match
    }

    
    /**
     * Checks if a user matches the provided credentials
     * @param user User object
     * @param userIdentifier username or email
     * @param password user's password
     * @return true if matching, false otherwise
     */
    private boolean isMatchingUser(Photographer user, String userIdentifier, String password) {
       System.out.println("Checking user: " + user.getUsername() + ", " + user.getEmail());
		System.out.println("Against: " + userIdentifier + ", " + password);
		
		// Check if username or email matches and if password matches
    	
    	
    	return (user.getUsername().equals(userIdentifier) || 
                user.getEmail().equals(userIdentifier)) && 
               user.getPassword().equals(password);
        
       
    }
}