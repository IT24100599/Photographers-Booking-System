<!-- Not finished -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.photographerMgr.models.Photographer" %>	
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <h2>Welcome to your Dashboard</h2>
    
    <% Photographer photographer = (Photographer)session.getAttribute("photographer"); %>
    <% if (photographer != null) { %>
        <h3>photographer Information</h3>
        <p>Username: <%= photographer.getUsername() %></p>
        <p>Email: <%= photographer.getEmail() %></p>
        <p>Gender: <%= photographer.getGender() %></p>
        <p>Address: <%= photographer.getOriginalAddress() %></p>
        <p>Phone: <%= photographer.getPhone() %></p>
        <p>Skills: <%= photographer.getOriginalSkills() %></p>
        <br>
        <p>Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-03-05 17:38:21</p>
        <p>Current photographer's Login: Saviru</p>
        <br>
        <% 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date loginTime = (java.util.Date)session.getAttribute("loginTime");
        %>
        <p>Login Time: <%= sdf.format(loginTime) %></p>
        
        <div class="inpBtn btns" style="margin-top: 20px;">
            <input type="button" value="Update Photographer Profile" onclick="window.location.href='profilePhotographer.jsp'" class="button">
            <input type="button" value="Logout" onclick="window.location.href='logoutPhotographer.jsp'" class="refBtn">
        </div>
    <% } else { %>
        <p>No photographer found in session. Please <a href="loginPhotographer.jsp">Login here.</a>.</p>
    <% } %>
</body>
</html>