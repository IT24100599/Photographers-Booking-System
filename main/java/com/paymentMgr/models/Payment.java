package com.paymentMgr.models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Payment {
    private String cardholderName;
    private String cardNumber;
    private String expiryDate;
    private String cvv;
    private LocalDateTime submissionDateTime;
    private String username;
    private String photographer;
    private String amount;

    public Payment(String cardholderName, String cardNumber, String expiryDate, String cvv, String username, String photographer, String amount) {
        this.cardholderName = cardholderName;
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
        this.submissionDateTime = LocalDateTime.now();
        this.username = username;
        this.photographer = photographer;
        this.amount = amount;
    }

    public Payment(String cardholderName, String cardNumber, String expiryDate, String cvv, LocalDateTime submissionDateTime) {
        this.cardholderName = cardholderName;
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
        this.submissionDateTime = submissionDateTime;
    }
    
    public Payment(String cardholderName, String cardNumber, String expiryDate, LocalDateTime submissionDateTime, String username, String photographer, String amount) {
        this.cardholderName = cardholderName;
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.submissionDateTime = submissionDateTime;
        this.username = username;
        this.photographer = photographer;
        this.amount = amount;
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
        return submissionDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public String getSubmissionTime() {
        return submissionDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
    
    public String  getPhotographer() {
		return photographer;
	}
    
    public String getUsername() {
    	return username;
    }
    
    public String getAmount() {
		return amount;
	}

    public String toFileString() {
        return cardholderName + "|" +
                cardNumber + "|" +
                expiryDate + "|" +
                submissionDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + '|' +
                username + "|" +
                photographer + "|" +
                amount;
    }

    public static Payment fromFileString(String fileData) {
        String[] parts = fileData.split("\\|");
        if (parts.length >= 7) {
            LocalDateTime dateTime = LocalDateTime.parse(parts[3], DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            return new Payment(parts[0], parts[1], parts[2], dateTime, parts[4], parts[5], parts[6]);
        }
        throw new IllegalArgumentException("Invalid payment data format");
    }
}