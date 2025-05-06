package com.admin.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final String FILE_PATH = "E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get current username from session
        String userName = (String) session.getAttribute("userName");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        File file = new File(FILE_PATH);
        File tempFile = new File(file.getParent(), "admin_credentials.tmp");

        try (BufferedReader reader = new BufferedReader(new FileReader(file));
             PrintWriter writer = new PrintWriter(new FileWriter(tempFile))) {

            String line;
            boolean found = false;

            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData.length > 1 && userData[1].equals(userName)) {
                    // Update the matching record
                    writer.println(fullName + "," + userName + "," + email + "," +
                            gender + "," + phone + "," + password);
                    found = true;
                } else {
                    writer.println(line);
                }
            }

            if (!found) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "User not found in database.");
                return;
            }
        }

        // Backup the original file
        File backupFile = new File(file.getParent(), "admin_credentials.bak");
        if (!file.renameTo(backupFile)) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Could not create backup file.");
            return;
        }

        // Replace the old file with the updated file
        if (!tempFile.renameTo(file)) {
            // Restore backup if rename fails
            backupFile.renameTo(file);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update profile.");
            return;
        }

        // Delete backup if everything succeeded
        backupFile.delete();

        // Update session attributes
        session.setAttribute("fullName", fullName);
        session.setAttribute("userName", userName);
        session.setAttribute("email", email);
        session.setAttribute("gender", gender);
        session.setAttribute("phone", phone);
        session.setAttribute("password", password);

        response.sendRedirect("profile.jsp");
    }
}