<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.paymentMgr.models.Payment" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Records</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        .filter-info {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .filter-form {
            margin: 20px 0;
            padding: 15px;
            background-color: #eef;
            border-radius: 5px;
        }
        .filter-form div {
            margin-bottom: 10px;
        }
        .filter-form label {
            display: inline-block;
            width: 100px;
        }
        .filter-form input[type="text"] {
            padding: 5px;
            width: 200px;
        }
        .filter-form input[type="submit"] {
            padding: 5px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    
    
    <h1>Payment Records</h1>
    
    <div class="filter-form">
        <h3>Filter Payments</h3>
        <form action="displayPayments" method="get">
            <div>
                <label for="username">Username:</label>
                <input type="text" id="username" name="username">
            </div>
            <div>
                <label for="photographer">Photographer:</label>
                <input type="text" id="photographer" name="photographer">
            </div>
            <div>
                <input type="submit" value="Apply Filter">
                <a href="displayPayments">Clear Filters</a>
            </div>
        </form>
    </div>
    
    <% 
    String filterType = (String)request.getAttribute("filterType");
    String filterValue = (String)request.getAttribute("filterValue");
    
    if (filterType != null && !filterType.equals("none")) { 
    %>
        <div class="filter-info">
            <strong>Filtered by:</strong> <%= filterType %> = <%= filterValue %>
        </div>
    <% } %>
    
    <% 
    List<Payment> payments = (List<Payment>)request.getAttribute("payments");
    
    if (payments == null || payments.isEmpty()) { 
    %>
        <p>No payment records found.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Cardholder</th>
                    <th>Card Number</th>
                    <th>Expiry Date</th>
                    <th>Submission Date</th>
                    <th>Username</th>
                    <th>Photographer</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <% for (Payment payment : payments) { %>
                    <tr>
                        <td><%= payment.getCardholderName() %></td>
                        <td><%= payment.getMaskedCardNumber() %></td>
                        <td><%= payment.getExpiryDate() %></td>
                        <td><%= payment.getSubmissionDate() %></td>
                        <td><%= payment.getUsername() %></td>
                        <td><%= payment.getPhotographer() != null ? payment.getPhotographer() : "N/A" %></td>
                        <td><%= payment.getAmount() != null ? payment.getAmount() : "N/A" %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>
