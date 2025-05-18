package com.photographyweb.service;

import com.photographyweb.model.Payment;
import com.photographyweb.model.PaymentQueue;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.*;

public class PaymentManager {

    private static final String PAYMENT_FILE = "C:\\Users\\savin\\IdeaProjects\\photography\\payments.txt";

    private static PaymentManager instance;

    private PaymentQueue paymentQueue;

    private List<Payment> paymentsCache;

    private PaymentManager() {
        paymentQueue = new PaymentQueue();

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
            paymentQueue.add(payment);

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
            while (!paymentQueue.isEmpty()) {
                Payment payment = paymentQueue.poll();
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

    public List<Payment> getAllPayments() {
        return new ArrayList<>(paymentsCache);
    }

    public List<Payment> getPaymentsSortedByDate() {
        List<Payment> payments = getAllPayments();

        Collections.sort(payments, new Comparator<Payment>() {
            @Override
            public int compare(Payment p1, Payment p2) {
                return p2.getSubmissionDateTime().compareTo(p1.getSubmissionDateTime());
            }
        });

        return payments;
    }

    public List<Payment> searchPaymentsByName(String name) {
        List<Payment> payments = getAllPayments();
        List<Payment> result = new ArrayList<>();

        for (Payment payment : payments) {
            if (payment.getCardholderName().toLowerCase().contains(name.toLowerCase())) {
                result.add(payment);
            }
        }

        return result;
    }

    public static String getPaymentFilePath() {
        return PAYMENT_FILE;
    }
}