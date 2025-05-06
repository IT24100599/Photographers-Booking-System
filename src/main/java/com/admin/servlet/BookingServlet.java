package com.admin.servlet;

import com.admin.model.Booking;
import com.admin.util.FileHandler;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            List<Booking> bookings = FileHandler.loadBookings();
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("bookings.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            String bookingId = request.getParameter("bookingId");
            String status = request.getParameter("status");
            
            List<Booking> bookings = FileHandler.loadBookings();
            for (Booking booking : bookings) {
                if (booking.getBookingId().equals(bookingId)) {
                    booking.setStatus(status);
                    break;
                }
            }
            
            // Save updated bookings
            FileHandler.saveBookings(bookings);
            response.sendRedirect("bookings.jsp");
        }
    }
} 