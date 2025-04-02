<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.userMgr.models.User"%>
 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Delete Profile</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <div class="container">
        <h2>Confirm Profile Deletion</h2><br>
        
        <% User user = (User)session.getAttribute("user"); %>
        <% if (user != null) { %>
            <p>You are about to delete your profile: <strong><%= user.getUsername() %></strong></p>
      
            <p style="color:red;">This action cannot be undone. All your data will be permanently removed.</p>
            
            <div class="inpBtn btns">
                <form action="DeleteServlet" method="post">
                    <input type="submit" value="Confirm Delete" class="refBtn">
                    <input type="button" value="Cancel" onclick="window.location.href='profile.jsp'" class="button">
                </form>
            </div>
        <% } else { %>
            <p>No user found in session. Please <a href="login.jsp">login</a>.</p>
        <% } %>
    </div>
</body>
</html>