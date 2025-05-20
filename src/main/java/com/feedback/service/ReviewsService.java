package com.feedback.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.feedback.model.Feedback;

public class ReviewsService {
    private static final String FEEDBACK_FILE_NAME = "C:\\Users\\Tharusha\\Documents\\Java projects\\feedback\\src\\main\\webapp\\WEB-INF\\feedbacks.txt";

    public List<Feedback> getAllFeedback(HttpServletRequest request) throws IOException {
        List<Feedback> feedbackList = new ArrayList<>();
        File feedbackFile = findFeedbackFile(request);
        
        if (feedbackFile != null && feedbackFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(feedbackFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    Feedback feedback = parseFeedbackLine(line);
                    if (feedback != null) {
                        feedbackList.add(feedback);
                    }
                }
            }
        }
        
        return feedbackList;
    }
    

    private File findFeedbackFile(HttpServletRequest request) {
        File file = new File(FEEDBACK_FILE_NAME);
        if (file.exists()) {
            return file;
        }
        

        String userHome = System.getProperty("user.home");
        file = new File(userHome + File.separator + FEEDBACK_FILE_NAME);
        if (file.exists()) {
            return file;
        }
        

        String tempDir = System.getProperty("java.io.tmpdir");
        
        file = new File(tempDir + File.separator + FEEDBACK_FILE_NAME);
        
        if (file.exists()) {
            return file;
        }

        return new File(FEEDBACK_FILE_NAME);
    }
    
    private Feedback parseFeedbackLine(String line) {
        try {
            Feedback feedback = new Feedback();
            
            Pattern usernamePattern = Pattern.compile("Username: ([^|]+)");
            Matcher usernameMatcher = usernamePattern.matcher(line);
            if (usernameMatcher.find()) {
                feedback.setUsername(usernameMatcher.group(1).trim());
            }
            

            Pattern userIdPattern = Pattern.compile("\\| UserID: ([^|]+)");
            Matcher userIdMatcher = userIdPattern.matcher(line);
            if (userIdMatcher.find()) {
                feedback.setUserId(userIdMatcher.group(1).trim());
            }
            Pattern ratingPattern = Pattern.compile("\\| Rating: (\\d+)");
            Matcher ratingMatcher = ratingPattern.matcher(line);
            
            
            if (ratingMatcher.find()) {
                feedback.setRating(Integer.parseInt(ratingMatcher.group(1).trim()));
            }

            Pattern datePattern = Pattern.compile("\\| Date: ([^|]+)");
            Matcher dateMatcher = datePattern.matcher(line);
            if (dateMatcher.find()) {
                feedback.setDatetime(dateMatcher.group(1).trim());
            }
            
            Pattern feedbackPattern = Pattern.compile("\\| Feedback: (.+)$");
            Matcher feedbackMatcher = feedbackPattern.matcher(line);
            
            if (feedbackMatcher.find()) {
                feedback.setFeedbackText(feedbackMatcher.group(1).trim());
            }
            
            return feedback;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}