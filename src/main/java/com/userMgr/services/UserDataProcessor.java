package com.userMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

import com.userMgr.models.User;

public class UserDataProcessor {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\users.txt";
    
    /**
     * Authenticates a user using bubble search algorithm on a queue of users
     * @param userIdentifier username or email
     * @param password user's password
     * @return User object if authenticated, null otherwise
     */
    public User authenticateUser(String userIdentifier, String password) {
        Queue<User> userQueue = loadUsersIntoQueue();
        User user = bubbleSearchUser(userQueue, userIdentifier, password);
        return user;
    }
    
    /**
     * Loads all users from users.txt into a queue
     * @return Queue of User objects
     */
    private Queue<User> loadUsersIntoQueue() {
        Queue<User> queue = new LinkedList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(", ");
                if (parts.length >= 7) {
                	String fullName = parts[0];
                    String username = parts[1];
                    String pwd = parts[2];
                    String email = parts[3];
                    String gender = parts[4];
                    String address = parts[5];
                    String phone = parts[6];
                    
                    User user = new User(fullName, username, pwd, email, gender, address, phone);
                    queue.add(user);
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

private User bubbleSearchUser(Queue<User> userQueue, String userIdentifier, String password) {
    int size = userQueue.size();
    User[] users = new User[size];

    // Convert queue to array and preserve queue contents
    for (int i = 0; i < size; i++) {
        User user = userQueue.remove();
        users[i] = user;
        userQueue.add(user); // Add back to queue
    }

    // Simple linear search is more appropriate for finding a user
    for (User user : users) {
        if (isMatchingUser(user, userIdentifier, password)) {
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
    private boolean isMatchingUser(User user, String userIdentifier, String password) {
    	
        return (user.getUsername().equals(userIdentifier) || 
                user.getEmail().equals(userIdentifier)) && 
               user.getPassword().equals(password);
    }
}