package com.chat.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chat.dao.UserDAO;
import com.chat.model.Chat;

/**
 * Servlet to look up a user by username and email
 */
@WebServlet("/lookupUser")
public class UserLookupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from request
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            email == null || email.trim().isEmpty()) {
            // Redirect to error page if parameters are missing
            response.sendRedirect("error.jsp?message=Username and email are required");
            return;
        }
        
        // Look up user in database
        UserDAO userDAO = new UserDAO();
        Chat user = userDAO.getUserByUsernameAndEmail(username, email);
        
        if (user != null) {
            // Chat found - redirect to display page with user details as parameters
            String redirectURL = "customer_chat.jsp?username=" + user.getUsername() + 
                               "&userId=" + user.getId();
            response.sendRedirect(redirectURL);
        } else {
            // Chat not found - redirect to error page
            response.sendRedirect("error.jsp?message=Chat not found");
        }
    }
}