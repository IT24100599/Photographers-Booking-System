package com.feedback.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Feedback {
    private String username;
    private String userId;
    private String feedbackText;
    private int rating;
    private String datetime;

    public Feedback() {
        this.datetime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public Feedback(String username, String userId, String feedbackText, int rating) {
        this.username = username;
        this.userId = userId;
        this.feedbackText = feedbackText;
        this.rating = rating;
        this.datetime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFeedbackText() {
        return feedbackText;
    }

    public void setFeedbackText(String feedbackText) {
        this.feedbackText = feedbackText;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    @Override
    public String toString() {
        return "Username: " + username + 
               (userId != null && !userId.isEmpty() ? " | UserID: " + userId : "") +
               " | Rating: " + rating + 
               " | Date: " + datetime + 
               " | Feedback: " + feedbackText;
    }
}