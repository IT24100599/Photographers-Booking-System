package com.feedback.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.feedback.model.Feedback;
import com.feedback.service.ReviewsService;

@WebServlet("/reviews")
public class ReviewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewsService reviewsService;
    
    public ReviewsServlet() {
        super();
        reviewsService = new ReviewsService();
    }
    
    @Override
    public void init() throws ServletException {
        super.init();
        if (reviewsService == null) {
            reviewsService = new ReviewsService();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String sortBy = request.getParameter("sort");
            
            List<Feedback> feedbackList = reviewsService.getAllFeedback(request);
            

            
            
            if (sortBy != null) {
                sortFeedbackList(feedbackList, sortBy);
            }

            request.setAttribute("feedbackList", feedbackList);
            request.getRequestDispatcher("reviews.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            
            
            
            request.setAttribute("error", "Failed to load reviews: " + e.getMessage());
            request.getRequestDispatcher("reviews.jsp").forward(request, response);
        }
    }
    
    private void sortFeedbackList(List<Feedback> feedbackList, String sortBy) {
        switch(sortBy) {
            case "rating":
                Collections.sort(feedbackList, (f1, f2) -> Integer.compare(f2.getRating(), f1.getRating()));
                break;
            case "date":
                break;
            case "name":
                Collections.sort(feedbackList, (f1, f2) -> f1.getUsername().compareToIgnoreCase(f2.getUsername()));
                break;
            default:
                break;
        }
    }
}