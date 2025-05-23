package com.paymentMgr.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paymentMgr.models.Payment;
import com.paymentMgr.services.PaymentManager;

@WebServlet("/displayPaymentsPHOTO")
public class PhotographerPaymentDisplayServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PaymentManager paymentManager = PaymentManager.getInstance();


        String photographer = request.getParameter("photographer");
        String username = request.getParameter("username");
        
        List<Payment> payments;
        String filterType = "none";
        String filterValue = "";

        if (photographer != null && !photographer.isEmpty()) {
            payments = paymentManager.getPaymentsByPhotographer(photographer);
            filterType = "photographer";
            filterValue = photographer;
            
        } else if (username != null && !username.isEmpty()) {
            payments = paymentManager.getPaymentsByUsername(username);
            filterType = "username";
            filterValue = username;
        } else {
            payments = paymentManager.getAllPayments();
            
            
        }



        
        request.setAttribute("payments", payments);
        request.setAttribute("filterType", filterType);
        
        request.setAttribute("filterValue", filterValue);
        

        request.getRequestDispatcher("/photographer-orders.jsp").forward(request, response);
    }
}
