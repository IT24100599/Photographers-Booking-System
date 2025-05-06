package com.admin.servlet;

import com.admin.util.FileHandler;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String report = FileHandler.generateReport();
            request.setAttribute("report", report);
            
            // Parse report data for individual metrics
            String[] lines = report.split("\n");
            if (lines.length >= 3) {
                request.setAttribute("totalBookings", lines[0].split(":")[1].trim());
                request.setAttribute("completedBookings", lines[1].split(":")[1].trim());
                request.setAttribute("totalEarnings", lines[2].split(":")[1].trim());
            } else {
                // Set default values if report is empty or malformed
                request.setAttribute("totalBookings", "0");
                request.setAttribute("completedBookings", "0");
                request.setAttribute("totalEarnings", "$0.00");
            }
        } catch (IOException e) {
            request.setAttribute("report", "Error generating report: " + e.getMessage());
            request.setAttribute("totalBookings", "0");
            request.setAttribute("completedBookings", "0");
            request.setAttribute("totalEarnings", "$0.00");
        }
        
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 