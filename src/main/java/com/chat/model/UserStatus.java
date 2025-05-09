package com.chat.model;

import java.util.Date;

public class UserStatus {
    private int id;
    private int userId;
    private String status; // online, offline, away
    private Date lastUpdated;
    
    public UserStatus() {
        this.lastUpdated = new Date();
        this.status = "offline";
    }
    
    public UserStatus(int userId, String status) {
        this.userId = userId;
        this.status = status;
        this.lastUpdated = new Date();
    }
    
    // Getters and setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getLastUpdated() {
        return lastUpdated;
    }
    
    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}