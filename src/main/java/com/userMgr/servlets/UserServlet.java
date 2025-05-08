package com.userMgr.servlets;

import java.io.FileWriter;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.userMgr.models.User;
import com.userMgr.services.UserValidator;


//Chat
import com.chat.dao.UserDAO;
import com.chat.model.Chat;
import com.chat.util.PasswordUtil;


public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String FILE_PATH = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	String fullName = request.getParameter("fullName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            
            // Create validator to check for duplicate values
            UserValidator validator = new UserValidator();
            
            // Check for duplicate username
            if (validator.isDuplicateUsername(username)) {
                request.setAttribute("errorMessage", "Username already exists! Please choose a different username.");
            	request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
            	//response.sendRedirect("customer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Username already exists! Please choose a different username.", "UTF-8"));
                return;
            }
            
            // Check for duplicate email
            if (validator.isDuplicateEmail(email)) {
                request.setAttribute("errorMessage", "Email already exists! Please use a different email address.");
                request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
                //response.sendRedirect("customer-signup.jsp?error=username&message=" + java.net.URLEncoder.encode("Email already exists! Please choose a different email.", "UTF-8"));
                return;
            }
            
            
            
         // Validate email format
            if (!isValidEmail(email)) {
                request.setAttribute("errorMessage", "Invalid email format! Please enter a valid email address.");
                request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
                //response.sendRedirect("customer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Invalid email format! Please enter a valid email address.", "UTF-8"));
                return;
            }


            
            // Check for duplicate phone number
            if (validator.isDuplicatePhone(phone)) {
                request.setAttribute("errorMessage", "Phone number already exists! Please use a different phone number.");
                request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
                //response.sendRedirect("customer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Phone number already exists! Please choose a different phone number.", "UTF-8"));
                return;
            }
            
            // All validations passed, create user
            User user = new User(fullName, username, password, email, gender, address, phone);
            
            try (FileWriter writer = new FileWriter(FILE_PATH, true)) {
                writer.write(user.toString() + System.lineSeparator());
            }
            
            UserDAO registerChat = new UserDAO();
            
            String hashedPassword = PasswordUtil.hashPassword(password);
            
            // Create a new user
            Chat newUser = new Chat();
            newUser.setUsername(username);
            newUser.setPassword(hashedPassword);
            newUser.setEmail(email);
            newUser.setCreatedAt(new Date());
            
            // Save the user to database
            registerChat.registerUser(newUser);
            
            // Redirect to success page
            response.sendRedirect("customer-login.jsp");
        } catch (Exception e) {
            // Forward to error page with error message
           request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("customer-signup.jsp").forward(request, response);
           // response.sendRedirect("customer-signup.jsp?type=error&message=" + java.net.URLEncoder.encode("Phone number already exists! Please choose a different phone number.", "UTF-8"));
        }
    }

    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        // Check for @ symbol and proper domain format
        int atIndex = email.indexOf('@');
        if (atIndex == -1 || atIndex == 0 || atIndex == email.length() - 1) {
            return false;
        }

        // Check for domain with at least one dot
        String domain = email.substring(atIndex + 1);
        return domain.contains(".") && domain.indexOf(".") < domain.length() - 1;
    }
}
