package com.sorting.event_photography_and_videography_booking_system;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {
    private static final String MESSAGE_FILE = "D:/Project/Event Photography and Videography Booking System/src/main/webapp/Database/messages.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String photographerName = request.getParameter("photographerName");
        String userName = request.getParameter("userName");
        String messageContent = request.getParameter("messageContent");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(MESSAGE_FILE, true))) {
            writer.write("Photographer: " + photographerName);
            writer.newLine();
            writer.write("From: " + userName);
            writer.newLine();
            writer.write("Message: " + messageContent);
            writer.newLine();
            writer.write("----------");
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h3>Message sent to " + photographerName + " successfully!</h3>");
        out.println("<a href='photographers'>Back to Photographers</a>");
        out.println("</body></html>");
    }
}
