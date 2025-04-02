<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.userMgr.models.User" %>	
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <h2>Welcome to your Dashboard</h2><br><br>
    
    <% User user = (User)session.getAttribute("user"); %>
    <% if (user != null) { %>
        <h3>User Information</h3>
        <br>
        <p>Username: <%= user.getUsername() %></p>
        <p>Email: <%= user.getEmail() %></p>
        <p>Gender: <%= user.getGender() %></p>
        <p>Address: <%= user.getOriginalAddress() %></p>
        <p>Phone: <%= user.getPhone() %></p>
        <br>
        <p>Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-03-05 17:38:21</p>
        <p>Current User's Login: Saviru</p>
        <br>
        <% 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date loginTime = (java.util.Date)session.getAttribute("loginTime");
        %>
        <p>Login Time: <%= sdf.format(loginTime) %></p>
        
        <div class="inpBtn btns" style="margin-top: 20px;">
            <input type="button" value="Update Profile" onclick="window.location.href='profile.jsp'" class="button">
            <input type="button" value="Logout" onclick="window.location.href='logout.jsp'" class="refBtn">
        </div>
    <% } else { %>
        <p>No user found in session. Please <a href="login.jsp">login</a>.</p>
    <% } %>
</body>
</html>