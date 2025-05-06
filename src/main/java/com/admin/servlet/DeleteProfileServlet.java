package com.admin.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {
    private static final String FILE_PATH = "E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userName = (String) session.getAttribute("userName");

        File inputFile = new File(FILE_PATH);
        File tempFile = new File("temp.txt");

        BufferedReader reader = new BufferedReader(new FileReader(inputFile));
        BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile));

        String currentLine;
        boolean deleted = false;

        while ((currentLine = reader.readLine()) != null) {
            String[] parts = currentLine.split(",");
            if (parts.length >= 2 && parts[1].equals(userName)) {
                deleted = true; // Skip this line (user to be deleted)
                continue;
            }
            writer.write(currentLine + System.lineSeparator());
        }

        writer.close();
        reader.close();

        if (deleted) {
            if (!inputFile.delete()) {
                response.getWriter().write("error");
                return;
            }
            if (!tempFile.renameTo(inputFile)) {
                response.getWriter().write("error");
                return;
            }
            session.invalidate(); // Logout the user
            response.getWriter().write("success");
        } else {
            response.getWriter().write("not_found");
        }
    }
}
