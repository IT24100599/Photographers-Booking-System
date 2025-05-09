package com.chat.servlet;

import com.chat.dao.UserDAO;
import com.chat.dao.UserStatusDAO;
import com.chat.model.Chat;
import com.chat.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling user login
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("chat.jsp");
            return;
        }
        
        // Otherwise, show the login page
        response.sendRedirect("login.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        System.out.println("Login attempt for user: " + username);
        
        try {
            // Get user by username
            UserDAO userDAO = new UserDAO();
            Chat user = userDAO.getUserByUsername(username);
            
            if (user == null) {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Verify password
            boolean passwordMatches = PasswordUtil.verifyPassword(password, user.getPassword());
            
            if (passwordMatches) {
                // Set user in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Set user status to online
                UserStatusDAO statusDAO = new UserStatusDAO();
                statusDAO.updateUserStatus(user.getId(), "online");
                
                System.out.println("Chat logged in successfully: " + username);
                
                // Redirect to chat page
                response.sendRedirect("chat.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error in LoginServlet: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "An error occurred during login: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}