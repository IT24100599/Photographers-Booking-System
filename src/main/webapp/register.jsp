<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Admin Dashboard for Event Photography and Videography Booking System">
    <meta name="author" content="Vinod Madhuranga">

    <title>Register</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">

    <!-- Custom styles -->
    <link href="css/main.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>

<body>
<div class="background"></div>
<div class="container">
    <!--<div class="content">
        <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
        <div class="text-sci">
            <h2><span>Create an Account</span></h2>
        </div>
    </div>-->
    <div class="logreg-box">
        <div class="form-container active">
            <div class="form-box">
                <form class="user" action="RegisterServlet" method="post">
                <h2>Create an Account!</h2>

                <div class="input-box">
                    <input type="text" id="fullName name-input" minlength="5" maxlength="35" name="fullName" required
                           placeholder=" ">
                    <label id="name-label">Full Name</label>
                    <i class="icon fas fa-user"></i>
                </div>

                <div class="input-box">
                    <input type="text" id="username username-input" minlength="5" maxlength="15" name="userName"
                           required placeholder=" ">
                    <label id="username-label">Username</label>
                    <i class="icon fas fa-file-signature"></i>
                </div>

                <div class="input-box">
                    <input type="text" id="email email-input" name="email" required placeholder=" ">
                    <label id="email-label">Email</label>
                    <i class="icon fas fa-envelope"></i>
                </div>

                <div class="gender-selection">
                    <div class="gender-label-container">
                        <span class="gender-label">Gender</span>
                        <i class="icon fas fa-venus-mars"></i>
                    </div>
                    <div class="radio-group">
                        <label><input type="radio" id="gender" name="gender" value="Male" required> Male</label>
                        <label><input type="radio" id="gender" name="gender" value="Female" required> Female</label>
                    </div>
                </div>

                <div class="input-box">
                    <input type="number" id="phone phone-input" minlength="10" maxlength="10" name="phone" required
                           placeholder=" ">
                    <label id="phone-label">Phone</label>
                    <i class="icon fas fa-phone"></i>
                </div>

                <div class="input-box">
                    <input type="password" id="password-input" minlength="" name="password" required
                           placeholder=" ">
                    <label id="password-label">Password</label>
                    <i class="icon-right fas fa-eye password-toggle" id="show-password"></i>
                    <i class="icon fas fa-lock"></i>
                </div>

                <div class="input-box">
                    <input type="password" id="confirm-password-input" minlength="" required placeholder=" ">
                    <label id="confirm-password-label">Confirm Password</label>
                    <i class="icon-right fas fa-eye password-toggle" id="show-password"></i>
                    <i class="icon fas fa-lock"></i>
                    <span id="password-error"
                          style="color: red; font-size: 12px; display: none;">Passwords do not match</span>
                </div>

                <div class="remember-forgot">
                    <label><input type="checkbox" required>I agree to the <a href="#">Terms & Conditions</a></label>
                </div>

                <button type="submit" class="btn">Register Account</button>

                <div class="login-register">
                    <p>Already have an account? <a href="login.jsp">Login</a></p>

                    <%
                        String errorType = request.getParameter("type");
                        String errorMessage = request.getParameter("message");
                        if (errorType != null && errorMessage != null) {
                    %>
                    <div style="color: red;">
                        <%= errorMessage %> error here
                    </div>

                    <% } %>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Custom scripts for all pages-->
<script src="js/main.js"></script>

</body>

</html>
