<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.photographerMgr.models.Photographer" %>
 
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
        
        <% Photographer photographer = (Photographer)session.getAttribute("photographer"); %>
        <% if (photographer != null) { %>
            <p>You are about to delete your profile: <strong><%= photographer.getUsername() %></strong></p>
            <p style="color:red;">This action cannot be undone. All your data will be permanently removed.</p>
            
            <div class="inpBtn btns">
                <form action="DeleteServlet" method="post">
                    <input type="submit" value="Confirm Delete" class="refBtn">
                    <input type="button" value="Cancel" onclick="window.location.href='profilePhotographer.jsp'" class="button">
                </form>
            </div>
        <% } else { %>
            <p>Nophotographerr found in session. Please <a href="loginPhotographer.jsp">login</a>.</p>
        <% } %>
    </div>
</body>
</html>