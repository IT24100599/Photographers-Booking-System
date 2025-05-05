package com.photographerMgr.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photographerMgr.models.Photographer;
import com.photographerMgr.services.PhotographerProfileManager;
import com.photographerMgr.services.PhotographerValidator;

public class PhotographerProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Photographer currentPhotographer = (Photographer) session.getAttribute("photographer");
        
        if (currentPhotographer == null) {
            response.sendRedirect("photographer-login.jsp");
            return;
        }
        
        String originalUsername = request.getParameter("originalUsername");
        String originalEmail = request.getParameter("originalEmail");
        String originalPhone = currentPhotographer.getPhone();
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String skills = request.getParameter("skills");
        String description = request.getParameter("description");
        String experience = request.getParameter("experience");
        
        // Create a UserValidator to check for duplicates
        PhotographerValidator validator = new PhotographerValidator();
        
        // Validate username
        if (!username.equals(originalUsername)) {
            if (validator.isDuplicateUsername(username)) {
                request.setAttribute("error", "Username already exists! Please choose a different username.");
                request.getRequestDispatcher("photographer.jsp").forward(request, response);
                return;
            }
        }
        
        // Validate email
        if (!email.equals(originalEmail)) {
            if (validator.isDuplicateEmail(email)) {
                request.setAttribute("error", "Email already exists! Please use a different email address.");
                request.getRequestDispatcher("photographer.jsp").forward(request, response);
                return;
            }
        }
        
        // Validate phone
        if (!phone.equals(originalPhone)) {
            if (validator.isDuplicatePhone(phone)) {
                request.setAttribute("error", "Phone number already exists! Please use a different phone number.");
                request.getRequestDispatcher("photographer.jsp").forward(request, response);
                return;
            }
        }
        
        Photographer updatedPhotographer = new Photographer(username, password, email, gender, address, phone, skills, fullName);
        updatedPhotographer.setExperience(experience);
        updatedPhotographer.setDescription(description);
        
        PhotographerProfileManager profileManager = new PhotographerProfileManager();
        boolean success = profileManager.updatePhotographerProfile(originalUsername, originalEmail, updatedPhotographer, experience, description);
        
        if (success) {
            // Update the session with the new user data
            session.setAttribute("photographer", updatedPhotographer);
            request.setAttribute("message", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }
        
        request.getRequestDispatcher("photographer.jsp").forward(request, response);
    }
}