package com.feedback.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.feedback.model.Feedback;
import com.feedback.service.FeedbackService;

@WebServlet("/submitFeedback")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackService feedbackService;
    
    public FeedbackServlet() {
        super();
        feedbackService = new FeedbackService();
    }

    @Override
    public void init() throws ServletException {
        super.init();

        if (feedbackService == null) {
            feedbackService = new FeedbackService();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String username = request.getParameter("username");
            String userId = request.getParameter("userId");
            String feedbackText = request.getParameter("feedbackText");
            int rating = 5;
            

            if (request.getParameter("rating") != null) {
                rating = Integer.parseInt(request.getParameter("rating"));
            }

            Feedback feedback = new Feedback(username, userId, feedbackText, rating);
            boolean saved = feedbackService.saveFeedback(feedback, request);
            
            if (saved) {
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                    response.getWriter().write("success");
                } else {
                    request.setAttribute("feedback", feedback);
                    request.getRequestDispatcher("thank-you.jsp").forward(request, response);
                }
            } else {
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("error: Unable to save feedback");
                } else {
                    request.setAttribute("error", "Failed to save feedback. Please try again.");
                    request.getRequestDispatcher("feedback-form.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error: " + e.getMessage());
            } else {
            	
            	
                request.setAttribute("error", "An error occurred: " + e.getMessage());
                request.getRequestDispatcher("feedback-form.jsp").forward(request, response);
            }
        }
    }
    
    
}