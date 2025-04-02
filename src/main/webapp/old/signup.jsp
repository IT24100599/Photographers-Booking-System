<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <h2>Registration Form</h2>
    <form action="UserServlet" method="post">
    
        <div class="inputs">
        	<input type="text" id="username" name="username" required>
        	<label for="username">Username</label>
        </div>
        
        <div class="inputs">
        	<input type="password" id="password" name="password" required>
        	<label for="password">Password</label>	
        </div>	
        
        <div class="inputs">
        	<input type="email" id="email" name="email" required>
        	<label for="email">Email</label>	
        </div>
        
        <div class="inputs">
        	<input type="text" id="gender" name="gender" required>
        	<label for="gender">Gender</label>
       </div>
       
       <div class="inputs">
        	<input type="text" id="address" name="address" required>
        	<label for="address">Address</label>
        </div>	
        
        <div class="inputs">
        	<input type="text" id="phone" name="phone" required>	
        	<label for="phone">Phone Number</label>
        </div>	

        
        <div class="inpBtn">
        	<input type="submit" value="Register">
        </div>
    </form>
    
    <p>Already have an account? <a class="refLink" href="login.jsp">Login here</a></p>
    <br>
    
    <p>Are you a photographer? <a class="refLink" href="signupPhotographer.jsp">Register here</a></p>
    <br>
    
    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>
    
</body>
</html>