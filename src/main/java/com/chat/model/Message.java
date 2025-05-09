package com.chat.model;

import java.util.Date;

public class Message {
    private int id;
    private int senderId;
    private int receiverId;
    private String content;
    private Date sentTime;
    private boolean isRead;
    private String status;  // Added status field
    private String senderUsername;  // Added for convenience
    private String receiverUsername; // Added for convenience
    
    public Message() {
        this.sentTime = new Date();
        this.isRead = false;
        this.status = "sent"; // Default status
    }
    
    // Getters and setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getSenderId() {
        return senderId;
    }
    
    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }
    
    public int getReceiverId() {
        return receiverId;
    }
    
    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public Date getSentTime() {
        return sentTime;
    }
    
    public void setSentTime(Date sentTime) {
        this.sentTime = sentTime;
    }
    
    public boolean isRead() {
        return isRead;
    }
    
    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getSenderUsername() {
        return senderUsername;
    }
    
    public void setSenderUsername(String senderUsername) {
        this.senderUsername = senderUsername;
    }
    
    public String getReceiverUsername() {
        return receiverUsername;
    }
    
    public void setReceiverUsername(String receiverUsername) {
        this.receiverUsername = receiverUsername;
    }
}