package com.paymentMgr.services;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.*;

import com.paymentMgr.models.Payment;
import com.paymentMgr.models.OrderQueue;

public class PaymentManager {

    private static final String PAYMENT_FILE = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\payments.txt";

    private static PaymentManager instance;
    
    @SuppressWarnings("unused")
	private OrderQueue orderQueue;

    private List<Payment> paymentsCache;

    private PaymentManager() {
    	orderQueue = new OrderQueue();
    	
        paymentsCache = new ArrayList<>();

        try {
            File file = new File(PAYMENT_FILE);
            System.out.println("Payment file absolute path: " + file.getAbsolutePath());

            File parentDir = file.getParentFile();
            if (parentDir != null && !parentDir.exists()) {
                parentDir.mkdirs();
            }

            if (!file.exists()) {
                file.createNewFile();
                System.out.println("Created new payment file at: " + file.getAbsolutePath());
            } else {
                System.out.println("Using existing payment file at: " + file.getAbsolutePath());
                loadPaymentsFromFile();
            }
        } catch (IOException e) {
            System.err.println("Error accessing payment file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static synchronized PaymentManager getInstance() {
        if (instance == null) {
            instance = new PaymentManager();
        }
        return instance;
    }

    private void loadPaymentsFromFile() {
        try (BufferedReader reader = new BufferedReader(new FileReader(PAYMENT_FILE))) {
            String line;
            int count = 0;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    try {
                        Payment payment = Payment.fromFileString(line);
                        paymentsCache.add(payment);
                        count++;
                    } catch (Exception e) {
                        System.err.println("Error parsing line: " + line);
                    }
                }
            }
            System.out.println("Loaded " + count + " payments from file");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean addPayment(Payment payment) {
        try {
            orderQueue.insert(payment, "Adding payment: ");

            processQueue();

            paymentsCache.add(payment);

            System.out.println("Payment from " + payment.getCardholderName() + " added successfully");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private synchronized void processQueue() {
        try {
            while (!orderQueue.isEmpty()) {
                Payment payment = orderQueue.remove();
                if (payment != null) {
                    String paymentData = payment.toFileString() + System.lineSeparator();
                    Files.write(Paths.get(PAYMENT_FILE), paymentData.getBytes(),
                            StandardOpenOption.APPEND);
                    System.out.println("Payment written to file: " + PAYMENT_FILE);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getPaymentFilePath() {
        return PAYMENT_FILE;
    }
    
    public List<Payment> getPaymentsByPhotographer(String photographer) {
        OrderQueue tempQueue = new OrderQueue();
        List<Payment> filteredPayments = new ArrayList<>();

        // Add all cached payments to the queue
        for (Payment payment : paymentsCache) {
            tempQueue.insert(payment, "Reading payment: ");
        }

        // Process the queue to retrieve payments by photographer
        while (!tempQueue.isEmpty()) {
            Payment payment = tempQueue.remove();
            if (payment != null && payment.getPhotographer().equals(photographer)) {
                filteredPayments.add(payment);
            }
        }

        return Collections.unmodifiableList(filteredPayments);
    }
    
    public List<Payment> getPaymentsByUsername(String username) {
        OrderQueue tempQueue = new OrderQueue();
        List<Payment> filteredPayments = new ArrayList<>();

        // Add all cached payments to the queue
        for (Payment payment : paymentsCache) {
            tempQueue.insert(payment, "Reading payment: ");
        }

        // Process the queue to retrieve payments by username
        while (!tempQueue.isEmpty()) {
            Payment payment = tempQueue.remove();
            if (payment != null && payment.getUsername().equals(username)) {
                filteredPayments.add(payment);
            }
        }

        return Collections.unmodifiableList(filteredPayments);
    }


    public List<Payment> getAllPayments() {
    	OrderQueue tempQueue = new OrderQueue();
    	List<Payment> allPayments = new ArrayList<>();

    	// First add all cached payments to the queue
    	for (Payment payment : paymentsCache) {
    		tempQueue.insert(payment, "Reading payment: ");
    	}

    	// Process the queue to retrieve all payments
    	while (!tempQueue.isEmpty()) {
    		Payment payment = tempQueue.remove();
    		if (payment != null) {
    			allPayments.add(payment);
    		}
    	}

    	return Collections.unmodifiableList(allPayments);
    }


	public void clearPayments() {
		paymentsCache.clear();
		orderQueue = new OrderQueue();
	}
}