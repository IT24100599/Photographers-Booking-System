package com.admin.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Booking implements Serializable {
    private String bookingId;
    private String customerName;
    private String eventType;
    private LocalDateTime eventDate;
    private String location;
    private double payment;
    private String status;

    public Booking(String bookingId, String customerName, String eventType, 
                  LocalDateTime eventDate, String location, double payment, String status) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.eventType = eventType;
        this.eventDate = eventDate;
        this.location = location;
        this.payment = payment;
        this.status = status;
    }

    // Getters and Setters
    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getEventType() { return eventType; }
    public void setEventType(String eventType) { this.eventType = eventType; }

    public LocalDateTime getEventDate() { return eventDate; }
    public void setEventDate(LocalDateTime eventDate) { this.eventDate = eventDate; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public double getPayment() { return payment; }
    public void setPayment(double payment) { this.payment = payment; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double calculateEarnings() {
        return payment * 0.20; // 20% of payment
    }

    @Override
    public String toString() {
        return bookingId + "," + customerName + "," + eventType + "," + 
               eventDate + "," + location + "," + payment + "," + status;
    }
} 