package com.photographyweb;

import com.photographyweb.model.Payment;
import com.photographyweb.service.PaymentManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;

@WebServlet("/paymentp")
public class PaymentServlet extends HttpServlet {
    private PaymentManager paymentManager;

    @Override
    public void init() throws ServletException {
        try {
            paymentManager = PaymentManager.getInstance();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize PaymentManager", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        try {
            String name = request.getParameter("name");
            String cardNumber = request.getParameter("cardNumber");
            String expiry = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");

            if (name == null || cardNumber == null || expiry == null || cvv == null) {
                response.getWriter().write("Error: Missing required parameters");
                return;
            }

            Payment payment = new Payment(name, cardNumber, expiry, cvv);

            boolean success = paymentManager.addPayment(payment);

            if (success) {
                response.getWriter().write(
                        "<!DOCTYPE html>" +
                                "<html lang='en'>" +
                                "<head>" +
                                "<meta charset='UTF-8'>" +
                                "<title>Payment Success</title>" +
                                "<script src='https://cdn.tailwindcss.com'></script>" +
                                "</head>" +
                                "<body>" +
                                "<div class='flex items-center justify-center min-h-screen bg-[#9999f7]'>" +
                                "<div class='w-full max-w-2xl p-12 mx-4 text-center transition-all transform bg-white shadow-lg rounded-xl hover:shadow-xl'>" +
                                "<div class='flex items-center justify-center w-24 h-24 mx-auto mb-8 bg-green-100 rounded-full'>" +
                                "<svg class='w-12 h-12 text-green-600' fill='none' stroke='currentColor' viewBox='0 0 24 24'>" +
                                "<path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 13l4 4L19 7'></path>" +
                                "</svg></div>" +
                                "<h1 class='mb-6 text-4xl font-extrabold text-green-600'>Payment Successful!</h1>" +
                                "<p class='mb-8 text-xl text-gray-700'>Thank you for your purchase.</p>" +

                                "<div class='mt-12 flex gap-4'>" +
                                "<a href='OldPayment.html' class='inline-block px-8 py-4 text-lg font-semibold text-white transition-colors duration-200 bg-green-600 rounded-lg hover:bg-green-700'>View payment history</a>" +

                                "<a href='payment.html' class='inline-block px-8 py-4 text-lg font-semibold text-black transition-colors duration-200 bg-gray-200 rounded-lg hover:bg-gray-300'>Make another payment</a>" +
                                "</div></div></div></body></html>"
                );

            } else {
                response.getWriter().write("Error: Failed to save payment");
            }
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String searchName = request.getParameter("name");
            String sortOrder = request.getParameter("sort");

            List<Payment> payments;
            if (searchName != null && !searchName.trim().isEmpty()) {
                payments = paymentManager.searchPaymentsByName(searchName);
            } else {
                payments = paymentManager.getAllPayments();
            }

            if (sortOrder != null) {
                if (sortOrder.equals("oldest")) {
                    Collections.sort(payments, new Comparator<Payment>() {
                        @Override
                        public int compare(Payment p1, Payment p2) {
                            return p1.getSubmissionDateTime().compareTo(p2.getSubmissionDateTime());
                        }
                    });
                } else {
                    Collections.sort(payments, new Comparator<Payment>() {
                        @Override
                        public int compare(Payment p1, Payment p2) {
                            return p2.getSubmissionDateTime().compareTo(p1.getSubmissionDateTime());
                        }
                    });
                }
            } else {
                Collections.sort(payments, new Comparator<Payment>() {
                    @Override
                    public int compare(Payment p1, Payment p2) {
                        return p2.getSubmissionDateTime().compareTo(p1.getSubmissionDateTime());
                    }
                });
            }

            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");

            for (int i = 0; i < payments.size(); i++) {
                Payment payment = payments.get(i);

                jsonBuilder.append("{");
                jsonBuilder.append("\"id\":\"").append(i + 1).append("\",");
                jsonBuilder.append("\"cardholderName\":\"").append(escapeJson(payment.getCardholderName())).append("\",");
                jsonBuilder.append("\"cardNumber\":\"").append(escapeJson(payment.getCardNumber())).append("\",");
                jsonBuilder.append("\"expiry\":\"").append(escapeJson(payment.getExpiryDate())).append("\",");
                jsonBuilder.append("\"submissionDateTime\":\"").append(escapeJson(payment.getSubmissionDateTime().toString())).append("\",");

                jsonBuilder.append("\"amount\":100.00");
                jsonBuilder.append("}");

                if (i < payments.size() - 1) {
                    jsonBuilder.append(",");
                }
            }

            jsonBuilder.append("]");

            response.getWriter().write(jsonBuilder.toString());

        } catch (Exception e) {
            e.printStackTrace();

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }

        return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}