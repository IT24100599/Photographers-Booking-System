<!-- Not finished -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/style.css">
    <title>Photographer Login</title>
</head>
<body>
    <h1>Login as a photographer</h1>
    <form action="PhotographerLoginServlet" method="post">
        <div class="inputs">
        	<input type="text" id="userIdentifier" name="userIdentifier" required>
        	<label for="userIdentifier">Username or Email</label>
        </div>
        <div class="inputs">
        	<input type="password" id="password" name="password" required>
        	<label for="password">Password</label>
        </div>
        
        <div class="inpBtn">
        	<input type="submit" value="Login">
        </div>	
    </form>
    
    <p>Don't have an account?   <a class="refLink" href="signupPhotographer.jsp">Register here</a></p>
    <br>
    <p>Are you a customer?   <a class="refLink" href="login.jsp">Login here</a></p>
    <br>
    
    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red;"><%= request.getAttribute("error") %></p>
    <% } %>
</body>
</html>