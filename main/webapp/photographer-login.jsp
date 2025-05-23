<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photographer Login</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="background"></div>
    <div class="container">
        <div class="content">
            <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
            <div class="text-sci">
                <h2>Welcome!<br><span>To Our New Website</span></h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum euismod suscipit risus.</p>
                
                <!-- User Type Selection -->
                <div class="user-type-question">Login as a</div>
                <div class="user-type-selection">
                    <a href="customer-login.jsp" class="user-type-link">Customer</a>
                    <a href="photographer-login.jsp" class="user-type-link active">Photographer</a>
                </div>
                
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
        <div class="logreg-box">
            <div class="form-container active">
                <div class="form-box login">
                    <form action="PhotographerLoginServlet" method="post">
                        <h2>Sign In</h2>
                        <div class="input-box">
                            <span class="icon"><i class="fas fa-envelope"></i></span>
                            <input type="text" name="userIdentifier" name="userIdentifier" id="photographer-email-input" required>
                            <label for="photographer-email-input">Username or Email</label>
                        </div>
                        <div class="input-box">
                            <span class="icon"><i class="fas fa-shield-alt"></i></span>
                            <input name="password" type="password" name="password" id="photographer-password-input" required>
                            <label for="photographer-password-input">Password</label>
                        </div>
                        <div class="remember-forgot">
                            <label><input type="checkbox">Remember me</label>
                            <a href="#">Forgot password?</a>
                        </div>
                        <button type="submit" class="btn">Sign In</button>
                        <div class="login-register">
                            <p>Don't have an account? <a href="photographer-signup.jsp">Register as Photographer</a></p>
                            <% if (request.getAttribute("error") != null) { %>
        						<p style="color: red;"><%= request.getAttribute("error") %></p>
   							<% } %>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="assets/main.js"></script>
</body>
</html>
