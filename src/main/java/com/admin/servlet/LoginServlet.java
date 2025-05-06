package com.admin.servlet;

import com.admin.model.Admin;
import com.admin.util.FileReaderUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        // Path to the admin credentials file
        String credentialsFilePath = "E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt";

        try {
            Admin admin = FileReaderUtil.getAdminCredentials(credentialsFilePath, email, password);
            if (admin != null) {
                // Create session and store admin info
                HttpSession session = request.getSession();
                session.setAttribute("adminUser", admin);  // Store Admin object
                session.setAttribute("fullName", admin.getFullName());
                session.setAttribute("userName", admin.getUserName());
                session.setAttribute("email", admin.getEmail());
                session.setAttribute("gender", admin.getGender());
                session.setAttribute("phone", admin.getPhone());
                session.setAttribute("password", admin.getPassword());

                response.sendRedirect("dashboard.jsp");
            } else {
                // Invalid credentials
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=exception");
        }
    }
}
