package com.userMgr.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.userMgr.models.User;
import com.userMgr.services.UserProfileManager;
import com.userMgr.services.UserValidator;

public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("customer-login.jsp");
            return;
        }
        
        String originalUsername = request.getParameter("originalUsername");
        String originalEmail = request.getParameter("originalEmail");
        String originalPhone = currentUser.getPhone();
        
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        
        System.out.println(fullName + ", " + username + " " + password + " " + email + "" + gender + " " + address + " " + phone);
        
        
        UserValidator validator = new UserValidator();
        
        if (!username.equals(originalUsername)) {
            if (validator.isDuplicateUsername(username)) {
            	request.setAttribute("error", "Username already exists! Please choose a different username.");
            	request.getRequestDispatcher("customer.jsp").forward(request, response);
                return;
            }
        }
        
        if (!email.equals(originalEmail)) {
            if (validator.isDuplicateEmail(email)) {
                request.setAttribute("error", "Email already exists! Please use a different email address.");
                request.getRequestDispatcher("customer.jsp").forward(request, response);
                return;
            }
        }
        if (!phone.equals(originalPhone)) {
            if (validator.isDuplicatePhone(phone)) {
               request.setAttribute("error", "Phone number already exists! Please use a different phone number.");
                request.getRequestDispatcher("customer.jsp").forward(request, response);
                return;
            }
        }
        
        User updatedUser = new User(fullName, username, password, email, gender, address, phone);
        
        System.out.println(updatedUser);
        
        UserProfileManager profileManager = new UserProfileManager();
        
        System.out.println("\n\nUN: " + originalUsername + ", Email: " + originalEmail);
        
        
        boolean success = profileManager.updateUserProfile(originalUsername, originalEmail, updatedUser);
        
        System.out.println(success);
        
        if (success) {
           
            session.setAttribute("user", updatedUser);
            request.setAttribute("message", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }
        
        request.getRequestDispatcher("customer.jsp").forward(request, response);
    }
}