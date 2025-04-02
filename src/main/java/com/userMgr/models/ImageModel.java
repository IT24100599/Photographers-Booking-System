package com.userMgr.models;

import java.io.Serializable;

public class ImageModel implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String userId;
    private String filename;
    private long timestamp;
    
    public ImageModel() {
        this.timestamp = System.currentTimeMillis();
    }
    
    public ImageModel(String userId, String filename) {
        this.userId = userId;
        this.filename = filename;
        this.timestamp = System.currentTimeMillis();
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getFilename() {
        return filename;
    }
    
    public void setFilename(String filename) {
        this.filename = filename;
    }
    
    public long getTimestamp() {
        return timestamp;
    }
    
    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }
}