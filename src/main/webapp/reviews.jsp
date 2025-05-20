<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.feedback.model.Feedback" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photography Service Reviews</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Montserrat', sans-serif;
        }
        
        .page-header {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1554080353-a576cf803bda');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 0;
            margin-bottom: 50px;
            text-align: center;
        }
        
        .review-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 50px;
        }
        
        .review-card {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }
        
        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .rating-stars {
            color: #f8b739;
            font-size: 18px;
            margin-bottom: 10px;
        }
        
        .review-date {
            color: #6c757d;
            font-size: 14px;
        }
        
        .review-text {
            margin-top: 15px;
            font-style: italic;
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
        
        .sort-options {
            margin-bottom: 20px;
        }
        
        .sort-options .btn-group .btn {
            border-color: #dee2e6;
        }
        
        .sort-options .btn-group .btn.active {
            background-color: #2c3e50;
            border-color: #2c3e50;
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px 0;
        }
        
        .empty-state i {
            font-size: 60px;
            color: #dee2e6;
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
                    <li class="nav-item">
                        <a class="nav-link active" href="reviews">Reviews</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="page-header">
        <div class="container">
            <h1>Customer Reviews</h1>
            <p class="lead">See what others are saying about our photography services</p>
        </div>
    </header>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="review-container">
                    <h2 class="text-center mb-4">All Reviews</h2>
                    
                    <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                    
                    <div class="sort-options d-flex justify-content-between align-items-center">
                        <div>
                            <span class="me-2">Sort by:</span>
                            <div class="btn-group" role="group">
                                <a href="reviews?sort=date" class="btn btn-sm <%= request.getParameter("sort") == null || "date".equals(request.getParameter("sort")) ? "active" : "" %>">
                                    Date
                                </a>
                                <a href="reviews?sort=rating" class="btn btn-sm <%= "rating".equals(request.getParameter("sort")) ? "active" : "" %>">
                                    Rating
                                </a>
                                <a href="reviews?sort=name" class="btn btn-sm <%= "name".equals(request.getParameter("sort")) ? "active" : "" %>">
                                    Name
                                </a>
                            </div>
                        </div>
                        <a href="feedback-form.jsp" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus me-1"></i> Add Review
                        </a>
                    </div>
                    
                    <%
                        List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
                        if (feedbackList != null && !feedbackList.isEmpty()) {
                            for (Feedback feedback : feedbackList) {
                    %>
                    <div class="review-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-1"><%= feedback.getUsername() %></h5>
                                <% if(feedback.getUserId() != null && !feedback.getUserId().isEmpty()) { %>
                                <small class="text-muted">ID: <%= feedback.getUserId() %></small>
                                <% } %>
                            </div>
                            <span class="review-date"><%= feedback.getDatetime() %></span>
                        </div>
                        
                        <div class="rating-stars">
                            <% for(int i=0; i < feedback.getRating(); i++) { %>
                                <i class="fas fa-star"></i>
                            <% } %>
                            <% for(int i=feedback.getRating(); i < 5; i++) { %>
                                <i class="far fa-star"></i>
                            <% } %>
                        </div>
                        
                        <p class="review-text"><%= feedback.getFeedbackText() %></p>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="empty-state">
                        <i class="fas fa-comment-slash"></i>
                        <h4>No Reviews Yet</h4>
                        <p class="text-muted">Be the first to leave a review for our photography services.</p>
                        <a href="feedback-form.jsp" class="btn btn-primary mt-3">
                            <i class="fas fa-pen me-2"></i>Write a Review
                        </a>
                    </div>
                    <% } %>
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