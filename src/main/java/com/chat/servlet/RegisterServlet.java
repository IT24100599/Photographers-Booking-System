package com.chat.servlet;

import com.chat.dao.UserDAO;
import com.chat.model.Chat;
import com.chat.util.PasswordUtil;
import com.chat.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

/**
 * Servlet for handling user registration
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to registration page
        response.sendRedirect("register.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        
        // For debugging
        System.out.println("Register attempt - Username: " + username + ", Email: " + email);
        
        // Set default values for error handling
        String errorMessage = null;
        
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            errorMessage = "Username is required";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Password is required";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "Passwords don't match";
        } else if (email == null || email.trim().isEmpty()) {
            errorMessage = "Email is required";
        } else if (!ValidationUtil.isValidEmail(email)) {
            errorMessage = "Invalid email format";
        } else if (!ValidationUtil.isValidUsername(username)) {
            errorMessage = "Username must be 3-20 characters and can only contain letters, numbers, underscore and hyphen";
        } else if (!ValidationUtil.isValidPassword(password)) {
            errorMessage = "Password must be at least 8 characters and include at least one uppercase letter, one lowercase letter, and one number";
        }
        
        // If validation failed, return to registration page with error
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create UserDAO to interact with database
        UserDAO userDAO = new UserDAO();
        
        // Check if username already exists
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Username already exists");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        try {
            // Hash the password
            String hashedPassword = PasswordUtil.hashPassword(password);
            
            // Create a new user
            Chat newUser = new Chat();
            newUser.setUsername(username);
            newUser.setPassword(hashedPassword);
            newUser.setEmail(email);
            newUser.setCreatedAt(new Date());
            
            // Save the user to database
            int userId = userDAO.registerUser(newUser);
            
            if (userId > 0) {
                // Set user in session (auto-login)
                newUser.setId(userId);
                
                HttpSession session = request.getSession();
                session.setAttribute("user", newUser);
                
                // Log the successful registration
                System.out.println("Chat registered successfully: " + username + " (ID: " + userId + ")");
                
                // Set a welcome message for the dashboard
                request.setAttribute("welcomeMessage", "Welcome to Chat App, " + username + "!");
                
                // Redirect to chat page
                response.sendRedirect("chat.jsp");
            } else {
                // Registration failed
                request.setAttribute("error", "Registration failed. Please try again.");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Log the error
            System.err.println("Error in RegisterServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Return to registration page with error
            request.setAttribute("error", "An error occurred during registration: " + e.getMessage());
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}