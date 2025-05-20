<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.feedback.model.Feedback" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You - Photography Services</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Montserrat', sans-serif;
        }
        
        .thank-you-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1515378791036-0648a3ef77b2');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            text-align: center;
            margin-bottom: 50px;
        }
        
        .thank-you-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 50px;
        }
        
        .btn-primary {
            background-color: #2c3e50;
            border-color: #2c3e50;
            padding: 12px 30px;
            font-weight: 600;
        }
        
        .btn-primary:hover {
            background-color: #1a252f;
            border-color: #1a252f;
        }
        
        .rating-stars {
            color: #f8b739;
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-camera-retro me-2"></i>PhotoFeedback
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="feedback-form.jsp">Leave Feedback</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="thank-you-section">
        <div class="container">
            <h1><i class="fas fa-check-circle me-3"></i>Thank You!</h1>
            <p class="lead">Your feedback has been successfully submitted.</p>
        </div>
    </section>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="thank-you-card text-center">
                    <% 
                        Feedback feedback = (Feedback) request.getAttribute("feedback");
                        if (feedback != null) {
                    %>
                    <h2>Feedback Summary</h2>
                    <p class="lead">Thank you, <strong><%= feedback.getUsername() %></strong>, for your valuable feedback!</p>
                    
                    <% if(feedback.getUserId() != null && !feedback.getUserId().isEmpty()) { %>
                    <p>User ID: <strong><%= feedback.getUserId() %></strong></p>
                    <% } %>
                    
                    <div class="rating-stars">
                        <% for(int i=0; i < feedback.getRating(); i++) { %>
                            <i class="fas fa-star"></i>
                        <% } %>
                        <% for(int i=feedback.getRating(); i < 5; i++) { %>
                            <i class="far fa-star"></i>
                        <% } %>
                    </div>
                    
                    <div class="feedback-text mb-4">
                        <h5>Your Comments:</h5>
                        <p class="border p-3 rounded bg-light"><%= feedback.getFeedbackText() %></p>
                    </div>
                    <% } else { %>
                    <h2>Feedback Submitted</h2>
                    <p class="lead">Thank you for your valuable feedback!</p>
                    <% } %>
                    
                    <a href="index.jsp" class="btn btn-primary">
                        <i class="fas fa-home me-2"></i>Return to Homepage
                    </a>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-4">
        <div class="container">
            <p class="mb-0">&copy; 2025 PhotoFeedback. All rights reserved.</p>
            <p class="small text-muted mt-1">Current Date: <%= java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %></p>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>