<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Feedback - Photography Services</title>
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
                        url('https://images.unsplash.com/photo-1452587925148-ce544e77e70d');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 0;
            margin-bottom: 50px;
            text-align: center;
        }
        
        .form-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 50px;
        }
        
        .star-rating {
            direction: rtl;
            display: inline-block;
            padding: 20px 0;
        }
        
        .star-rating input[type=radio] {
            display: none;
        }
        
        .star-rating label {
            color: #bbb;
            font-size: 30px;
            padding: 0 5px;
            cursor: pointer;
        }
        
        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input[type=radio]:checked ~ label {
            color: #f8b739;
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
                    <a class="nav-link active" href="feedback-form.jsp">Leave Feedback</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="reviews">Reviews</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

    <header class="page-header">
        <div class="container">
            <h1>Share Your Experience</h1>
            <p class="lead">We appreciate your feedback on our photography services</p>
        </div>
    </header>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-container">
                    <h2 class="text-center mb-4">Feedback Form</h2>
                    
                    <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                    
                    <div class="alert alert-success" id="success-alert" style="display: none;">
                        <strong>Success!</strong> Your feedback has been submitted. Thank you!
                    </div>
                    
                    <div class="alert alert-danger" id="error-alert" style="display: none;">
                        <strong>Error!</strong> <span id="error-message">There was a problem submitting your feedback. Please try again.</span>
                    </div>
                    
                    <form id="feedbackForm" action="submitFeedback" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="userId" class="form-label">Your ID (Optional)</label>
                            <input type="text" class="form-control" id="userId" name="userId" placeholder="e.g. User ID">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Your Rating</label>
                            <div class="star-rating text-center">
                                <input type="radio" id="star5" name="rating" value="5" checked>
                                <label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
                                
                                <input type="radio" id="star4" name="rating" value="4">
                                <label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
                                
                                <input type="radio" id="star3" name="rating" value="3">
                                <label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
                                
                                <input type="radio" id="star2" name="rating" value="2">
                                <label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
                                
                                <input type="radio" id="star1" name="rating" value="1">
                                <label for="star1" title="1 star"><i class="fas fa-star"></i></label>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="feedbackText" class="form-label">Your Feedback</label>
                            <textarea class="form-control" id="feedbackText" name="feedbackText" rows="5" required></textarea>
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane me-2"></i>Submit Feedback
                            </button>
                        </div>
                    </form>
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
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Check if there's a URL parameter for error
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('error')) {
                $("#error-message").text(decodeURIComponent(urlParams.get('error')));
                $("#error-alert").show();
            }
            
            // Pre-fill user ID if it exists
            const defaultId = "";
            if ($("#userId").val() === "") {
                $("#userId").val(defaultId);
            }
            
            $("#feedbackForm").submit(function(event) {
                // Don't prevent default for regular form submission
                
                // For AJAX submission
                if (window.ajaxEnabled) {
                    event.preventDefault();
                    
                    $.ajax({
                        type: "POST",
                        url: "submitFeedback",
                        data: $(this).serialize(),
                        success: function(response) {
                            if (response === "success") {
                                $("#success-alert").fadeIn();
                                $("#error-alert").hide();
                                $("#feedbackForm")[0].reset();
                                
                                // Hide success message after 5 seconds
                                setTimeout(function() {
                                    $("#success-alert").fadeOut();
                                }, 5000);
                            } else {
                                $("#error-message").text("There was a problem submitting your feedback. Please try again.");
                                $("#error-alert").fadeIn();
                                $("#success-alert").hide();
                            }
                        },
                        error: function(xhr) {
                            let errorMessage = "There was a problem submitting your feedback. Please try again.";
                            if (xhr.responseText) {
                                errorMessage = xhr.responseText;
                            }
                            $("#error-message").text(errorMessage);
                            $("#error-alert").fadeIn();
                            $("#success-alert").hide();
                        }
                    });
                }
            });
            
            // Toggle between AJAX and regular form submission
            // Default to regular form submission for more reliable error handling
            window.ajaxEnabled = false;
        });
    </script>
</body>
</html>