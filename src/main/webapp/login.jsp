<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% if (request.getParameter("error") != null) { %>
<div class="alert alert-danger">
    <%= request.getParameter("error") %>
</div>
<% } %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Admin Dashboard for Event Photography and Videography Booking System">
    <meta name="author" content="Vinod Madhuranga">

    <title>Admin Login</title>

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
                <form class="user" style="margin-top: 2rem;" action="LoginServlet" method="post">
                    <h2>Welcome Back!</h2>
                    <div class="input-box">
                        <input type="text" id="email email-input" name="email" required placeholder=" ">
                        <label id="email-label">Email</label>
                        <i class="icon fas fa-envelope"></i>
                    </div>


                    <!--<div class="input-box" style="position: relative; margin: 25px 0; width: 100%;">
                        <input
                                type="password"
                                id="password"
                                name="password"
                                required
                                placeholder=" "
                                style="width: 100%; padding: 15px 45px 15px 15px; border: 1px solid rgba(0, 0, 0, 0.2); border-radius: 6px; font-size: 16px; color: #000; background: rgba(255, 255, 255, 0.9); transition: all 0.3s ease; height: 50px; box-sizing: border-box;"
                        >
                        <label
                                id="password-label"
                                style="position: absolute; left: 15px; top: 15px; color: #666; font-size: 16px; transition: all 0.3s ease; pointer-events: none; background: transparent; padding: 0 5px;"
                        >Password</label>
                        <i
                                class="icon fas fa-lock"
                                style="position: absolute; right: 45px; top: 50%; transform: translateY(-50%); color: #666; font-size: 16px;"
                        ></i>
                        <i
                                class="icon fas fa-eye password-toggle"
                                id="show-password"
                                style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: #666; font-size: 16px; cursor: pointer; z-index: 2;"
                        ></i>
                    </div>

                    <script>
                        document.addEventListener('DOMContentLoaded', function() {
                            const passwordField = document.getElementById('password');
                            const showPasswordToggle = document.getElementById('show-password');
                            const lockIcon = document.querySelector('.fa-lock');

                            if (passwordField && showPasswordToggle) {
                                showPasswordToggle.addEventListener('click', function() {
                                    // Toggle password visibility
                                    if (passwordField.type === 'password') {
                                        passwordField.type = 'text';
                                        this.classList.remove('fa-eye');
                                        this.classList.add('fa-eye-slash');
                                        if (lockIcon) lockIcon.style.display = 'none';
                                    } else {
                                        passwordField.type = 'password';
                                        this.classList.remove('fa-eye-slash');
                                        this.classList.add('fa-eye');
                                        if (lockIcon) lockIcon.style.display = 'block';
                                    }

                                    // Handle label position when typing
                                    if (passwordField.value.length > 0) {
                                        document.getElementById('password-label').style.top = '-10px';
                                        document.getElementById('password-label').style.left = '10px';
                                        document.getElementById('password-label').style.fontSize = '12px';
                                        document.getElementById('password-label').style.background = 'white';
                                    } else {
                                        document.getElementById('password-label').style.top = '15px';
                                        document.getElementById('password-label').style.left = '15px';
                                        document.getElementById('password-label').style.fontSize = '16px';
                                        document.getElementById('password-label').style.background = 'transparent';
                                    }
                                });

                                // Handle label on input focus/blur
                                passwordField.addEventListener('focus', function() {
                                    document.getElementById('password-label').style.top = '-10px';
                                    document.getElementById('password-label').style.left = '10px';
                                    document.getElementById('password-label').style.fontSize = '12px';
                                    document.getElementById('password-label').style.background = 'white';
                                });

                                passwordField.addEventListener('blur', function() {
                                    if (this.value.length === 0) {
                                        document.getElementById('password-label').style.top = '15px';
                                        document.getElementById('password-label').style.left = '15px';
                                        document.getElementById('password-label').style.fontSize = '16px';
                                        document.getElementById('password-label').style.background = 'transparent';
                                    }
                                });
                            }
                        });
                    </script>-->

                    <div class="input-box">
                        <input type="password" id="password" minlength="" name="password" required
                               placeholder=" ">
                        <label id="password-label">Password</label>
                        <i class="icon-right fas fa-eye password-toggle" id="show-password" ></i>
                        <i class="icon fas fa-lock"></i>
                    </div>


                    <button type="submit" class="btn">
                        Login
                    </button>
                    <div class="login-register">
                        <p>Need an Account? <a href="register.jsp">Create an Account!</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Custom scripts for all pages-->
<!--<script src="js/main.js"></script>-->

</body>

</html>
