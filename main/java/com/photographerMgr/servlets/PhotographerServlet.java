package com.photographerMgr.servlets;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chat.dao.UserDAO;
import com.chat.model.Chat;
import com.chat.util.PasswordUtil;
import com.photographerMgr.models.Photographer;
import com.photographerMgr.services.PhotographerValidator;

public class PhotographerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\photographers.txt";
    private static final String UPLOAD_DIRECTORY = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\photographerSamples\\";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String skills = request.getParameter("skills");
            

            PhotographerValidator validator = new PhotographerValidator();
            

            if (validator.isDuplicateUsername(username)) {
                request.setAttribute("errorMessage", "Username already exists! Please choose a different username.");
                request.getRequestDispatcher("photographer-signup.jsp").forward(request, response);
                //response.sendRedirect("photographer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Username already exists! Please choose a different username.", "UTF-8"));
                return;
            }
            
            if (validator.isDuplicateEmail(email)) {
                request.setAttribute("errorMessage", "Email already exists! Please use a different email address.");
                request.getRequestDispatcher("photographer-signup.jsp").forward(request, response);
            	//response.sendRedirect("photographer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Invalid email format! Please enter a valid email address.", "UTF-8"));
                return;
            }
            
            if (validator.isDuplicatePhone(phone)) {
                request.setAttribute("errorMessage", "Phone number already exists! Please use a different phone number.");
                request.getRequestDispatcher("photographer-signup.jsp").forward(request, response);
            	//response.sendRedirect("customer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Phone number already exists! Please choose a different phone number.", "UTF-8"));
                return;
            }
            
            Photographer photographer = new Photographer(username, password, email, gender, address, phone, skills, fullName);
            
            String defaults = photographer.getExperience()+", "+photographer.getDescription();
            

            try {
				File uploadDir = new File(UPLOAD_DIRECTORY + username);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
			} catch (Exception e) {
				request.setAttribute("errorMessage", "Failed to create upload directory: " + e.getMessage());
				request.getRequestDispatcher("photographer-signup.jsp").forward(request, response);
				return;
			}
            
            try (FileWriter writer = new FileWriter(FILE_PATH, true)) {
                writer.write(photographer.toString()+ ", " + defaults + ", 0.0" + System.lineSeparator());
            }
            
            UserDAO registerChat = new UserDAO();
            
            String hashedPassword = PasswordUtil.hashPassword(password);
            
            Chat newUser = new Chat();
            newUser.setUsername(username);
            newUser.setPassword(hashedPassword);
            newUser.setEmail(email);
            newUser.setCreatedAt(new Date());
            

            registerChat.registerUser(newUser);
            response.sendRedirect("photographer-login.jsp");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("photographer-signup.jsp").forward(request, response);
           // response.sendRedirect("photographer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Phone number already exists! Please choose a different phone number.", "UTF-8"));
        }
    }
}
