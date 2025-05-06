package com.admin.model;

public class Payment {
    private String paymentId;
    private String bookingId;
    private double amount;
    private String status;

    public Payment(String paymentId, String bookingId, double amount, String status) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.amount = amount;
        this.status = status;
    }

    public String getPaymentId() { return paymentId; }
    public String getBookingId() { return bookingId; }
    public double getAmount() { return amount; }
    public String getStatus() { return status; }
}
