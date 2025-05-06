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

        if (sortBy != null) {
            Comparator<Photographer> comparator = null;

            if ("rating".equalsIgnoreCase(sortBy)) {
                comparator = Comparator.comparingDouble(Photographer::getRating);
            } else if ("price".equalsIgnoreCase(sortBy)) {
                comparator = Comparator.comparingDouble(Photographer::getPrice);
            }

            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed(); // Reverse order for descending sort
                }
                photographers.sort(comparator);
            }
        }

        // Set the list in request attribute
        request.setAttribute("photographers", photographers);

        // Forward to JSP page
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
