
package com.userMgr.services;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.userMgr.models.User;

public class UserDataProcessor {
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\users.txt";

    public User authenticateUser(String userIdentifier, String password) {
        List<User> users = loadUsersFromFile();
        return findUser(users, userIdentifier, password);
    }

    private List<User> loadUsersFromFile() {
    	List<User> users = new ArrayList<>(); 
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
                    users.add(user);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return users;
    }

    private User findUser(List<User> users, String userIdentifier, String password) {
        for (User user : users) {
            if (isMatchingUser(user, userIdentifier, password)) {
                return user;
            }
        }
        return null;
    }


    private boolean isMatchingUser(User user, String userIdentifier, String password) {
        return (user.getUsername().equals(userIdentifier) ||
                user.getEmail().equals(userIdentifier)) &&
               user.getPassword().equals(password);
    }
    
    
}
