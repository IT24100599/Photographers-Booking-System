package com.photographyweb.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Payment {
    private String cardholderName;
    private String cardNumber;
    private String expiryDate;
    private String cvv;
    private LocalDateTime submissionDateTime;

    public Payment(String cardholderName, String cardNumber, String expiryDate, String cvv) {
        this.cardholderName = cardholderName;
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
        this.submissionDateTime = LocalDateTime.now();
    }

    public Payment(String cardholderName, String cardNumber, String expiryDate, String cvv, LocalDateTime submissionDateTime) {
        this.cardholderName = cardholderName;
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
        this.submissionDateTime = submissionDateTime;
    }


    public String getCardholderName() {
        return cardholderName;
    }

    public void setCardholderName(String cardholderName) {
        this.cardholderName = cardholderName;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public String getMaskedCardNumber() {
        if (cardNumber.length() < 4) {
            return cardNumber;
        }
        return "****-****-****-" + cardNumber.substring(cardNumber.length() - 4);
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public LocalDateTime getSubmissionDateTime() {
        return submissionDateTime;
    }

    public String getSubmissionDate() {
        return submissionDateTime.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }

    public String getSubmissionTime() {
        return submissionDateTime.format(DateTimeFormatter.ISO_LOCAL_TIME);
    }

    public String toFileString() {
        return cardholderName + "|" +
                cardNumber + "|" +
                expiryDate + "|" +
                cvv + "|" +
                submissionDateTime.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
    }

    public static Payment fromFileString(String fileData) {
        String[] parts = fileData.split("\\|");
        if (parts.length >= 5) {
            LocalDateTime dateTime = LocalDateTime.parse(parts[4], DateTimeFormatter.ISO_LOCAL_DATE_TIME);
            return new Payment(parts[0], parts[1], parts[2], parts[3], dateTime);
        }
        throw new IllegalArgumentException("Invalid payment data format");
    }
}