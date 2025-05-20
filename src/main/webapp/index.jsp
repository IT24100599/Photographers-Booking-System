<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photography Feedback</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Montserrat', sans-serif;
        }
        
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1500051638674-ff996a0ec29e');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 150px 0;
            margin-bottom: 50px;
            text-align: center;
        }
        
        .hero-section h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        .card {
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .card:hover {
            transform: translateY(-10px);
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
        
        .btn-outline-light {
            border-width: 2px;
            font-weight: 600;
            margin-left: 15px;
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
                        <a class="nav-link active" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="feedback-form.jsp">Leave Feedback</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="reviews">Reviews</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="container">
            <h1>Share Your Experience</h1>
            <p class="lead mb-4">We value your opinion about our photography services</p>
            <div>
                <a href="feedback-form.jsp" class="btn btn-primary btn-lg">
                    <i class="fas fa-star me-2"></i>Leave Feedback
                </a>
                <a href="reviews" class="btn btn-outline-light btn-lg">
                    <i class="fas fa-list me-2"></i>View Reviews
                </a>
            </div>
        </div>
    </section>

    <div class="container mb-5">
        <div class="row text-center mb-5">
            <div class="col-lg-4 mb-4">
                <div class="card h-100 p-4">
                    <div class="card-body">
                        <i class="fas fa-camera fa-3x mb-3 text-primary"></i>
                        <h3 class="card-title">Professional Photography</h3>
                        <p class="card-text">Capturing your precious moments with professional equipment and expertise.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="card h-100 p-4">
                    <div class="card-body">
                        <i class="fas fa-edit fa-3x mb-3 text-primary"></i>
                        <h3 class="card-title">Photo Editing</h3>
                        <p class="card-text">Professional editing services to enhance your photographs to perfection.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="card h-100 p-4">
                    <div class="card-body">
                        <i class="fas fa-images fa-3x mb-3 text-primary"></i>
                        <h3 class="card-title">Portfolio Creation</h3>
                        <p class="card-text">Creating stunning portfolios that showcase your best moments and memories.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center">
            <a href="feedback-form.jsp" class="btn btn-primary">
                <i class="fas fa-comment me-2"></i>Share Your Feedback
            </a>
            <a href="reviews" class="btn btn-outline-dark ms-2">
                <i class="fas fa-list me-2"></i>View All Reviews
            </a>
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