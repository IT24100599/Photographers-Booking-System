package com.sorting.event_photography_and_videography_booking_system;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;

@WebServlet("/photographers")
public class PhotographerServlet extends HttpServlet {
    private PhotographerService photographerService = new PhotographerService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Photographer> photographers = photographerService.getPhotographers();



        // Filter by event type if provided
        String eventType = request.getParameter("eventType");
        if (eventType != null && !eventType.isEmpty()) {
            photographers.removeIf(p -> !p.getEventType().equalsIgnoreCase(eventType));
        }
        String sortBy = request.getParameter("sortBy"); // "rating" or "price"
        String order = request.getParameter("order");   // "asc" or "desc"

        boolean ascending = "asc".equalsIgnoreCase(order);

        if ("rating".equalsIgnoreCase(sortBy)) {
            photographers = photographerService.sortByRating(photographers, ascending);
        } else if ("price".equalsIgnoreCase(sortBy)) {
            photographers = photographerService.sortByPrice(photographers, ascending);
        }

        request.setAttribute("photographers", photographers);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}