<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photographer Sign Up</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="background"></div>
    <div class="container">
        <div class="content">
            <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
            <div class="text-sci">
                <h2>Join Us!<br><span>Create an Account</span></h2>
                <p>Become a member and enjoy exclusive benefits.</p>
                
                <!-- User Type Selection -->
                <div class="user-type-question">Sign up as a</div>
                <div class="user-type-selection">
                    <a href="customer-signup.jsp" class="user-type-link">Customer</a>
                    <a href="photographer-signup.jsp" class="user-type-link active">Photographer</a>
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
                <div class="form-box">
                    <form action="PhotographerServlet" method="post">
                        <h2>Sign Up</h2>
                    
                        <div class="input-box">
                            <input type="text" id="photographer-email-input" name="fullName" required placeholder=" ">
                            <label for="photographer-email-input">Full Name</label>
                            <i class="icon fas fa-envelope"></i>
                        </div>
                        
                        <div class="input-box">
                            <input type="text" id="photographer-email-input" name="username" required placeholder=" ">
                            <label for="photographer-email-input">Username</label>
                            <i class="icon fas fa-envelope"></i>
                        </div>

                        <div class="input-box">
                            <input type="text" id="photographer-email-input" name="email" required placeholder=" ">
                            <label for="photographer-email-input">Email</label>
                            <i class="icon fas fa-envelope"></i>
                        </div>

                        <div class="gender-selection">
                            <div class="gender-label-container">
                                <span class="gender-label">Gender</span>
                                <i class="icon fas fa-venus-mars"></i>
                            </div>
                            <div class="radio-group">
                                <label><input type="radio" name="gender" value="Male" required> Male</label>
                                <label><input type="radio" name="gender" value="Female" required> Female</label>
                                <label><input type="radio" name="gender" value="Other" required> Other</label>
                            </div>
                        </div>

                        <div class="input-box">
                            <input type="phone" id="phone-input" name="phone" required placeholder=" ">
                            <label id="phone-label">Phone</label>
                            <i class="icon fas fa-phone"></i>
                        </div>

                        <div class="input-box">
                            <input type="address" id="address-input" name="address"  required placeholder=" ">
                            <label id="address-label">Address</label>
                            <i class="icon fas fa-house"></i>
                        </div>
                        
                        <div class="input-box">
                            <input type="text" id="photographer-specialty-input" name="skills" required placeholder=" ">
                            <label for="photographer-specialty-input">Photography Specialty</label>
                            <i class="icon fas fa-camera"></i>
                        </div>
                        
                        <!--  <div class="portfolio-upload">
                            <label for="portfolio">Portfolio Samples (Optional)</label>
                            <div class="file-upload-wrapper">
                                <input type="file" id="portfolio" name="portfolio" multiple accept="image/*" class="hidden-file-input">
                                <button type="button" class="file-upload-btn" onclick="document.getElementById('portfolio').click()">
                                    <i class="fas fa-upload"></i>
                                </button>
                                <span class="file-info">No files selected</span>
                            </div>
                        </div> -->
                        
                        <div class="input-box">
                            <input type="password" id="photographer-password-input" name="password" required placeholder=" ">
                            <label for="photographer-password-input">Password</label>
                            <i class="icon fas fa-lock"></i>
                        </div>
                        
                        <div class="input-box">
                            <input type="password" id="photographer-confirm-password-input" required placeholder=" ">
                            <label for="photographer-confirm-password-input">Confirm Password</label>
                            <i class="icon fas fa-lock"></i>
                        </div>
                        
                        
                        
                        <div class="remember-forgot">
                            <label><input type="checkbox" required>I agree to the <a href="#">Photographer Terms</a></label>
                        </div>
                        
                        <button type="submit" class="btn">Register as Photographer</button>
                        
                        <div class="login-register">
                            <p>Already have an account? <a href="photographer-login.jsp">Login</a></p>
                            
                            <% if (request.getAttribute("errorMessage") != null) { %>
        						<p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
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
