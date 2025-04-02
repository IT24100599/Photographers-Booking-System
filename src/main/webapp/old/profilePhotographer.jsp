<!-- Not finished -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.photographerMgr.models.Photographer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <h2>Edit Your Profile</h2>
    
    <% Photographer photographer = (Photographer)session.getAttribute("photographer"); %>
    <% if (photographer != null) { %>
        <div class="form-container">
            <form action="ProfileServlet" method="post">
                <input type="hidden" name="originalUsername" value="<%= photographer.getUsername() %>">
                <input type="hidden" name="originalEmail" value="<%= photographer.getEmail() %>">
                
                <div class="form-group inputs">
                    <input type="text" id="username" name="username" value="<%= photographer.getUsername() %>" required>
                    <label for="username">Username</label>
                </div>
                
                <div class="form-group inputs">
                    <input type="password" id="password" name="password" value="<%= photographer.getPassword() %>" required>
                    <label for="password">Password</label>
                </div>

                <div class="form-group inputs">
                    <input type="email" id="email" name="email" value="<%= photographer.getEmail() %>" required>
                    <label for="email">Email</label>
                </div>
                
                <div class="form-group inputs">
                    <input type="text" id="gender" name="gender" value="<%= photographer.getGender() %>" required>
                    <label for="gender">Gender</label>
                </div>
                
                <div class="form-group inputs">
                    <input type="text" id="address" name="address" value="<%= photographer.getOriginalAddress() %>" required>
                    <label for="address">Address</label>
                </div>
                
                <div class="form-group inputs">
                    <input type="text" id="phone" name="phone" value="<%= photographer.getPhone() %>" required>
                    <label for="phone">Phone Number</label>
                </div>
                
                <div class="form-group inputs">
                    <input type="text" id="skills" name="skills" value="<%= photographer.getOriginalSkills() %>" required>
                    <label for="skills">Skills</label>
                </div>
                
                <div class="form-group inpBtn btns">
                    <a href="deleteConfirm.jsp" class="refBtn">Delete Profile</a>
                    <input type="submit" value="Update Profile" class="button">
                </div>
                
                <div class="inpBtn">
                    <a class="refLink" href="dashboardPhotographer.jsp" style="margin-left: 10px;">Back to Dashboard</a>
                </div>
            </form>
            
            <% if (request.getAttribute("message") != null) { %>
                <p style="color: green;"><%= request.getAttribute("message") %></p>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <p style="color: red;"><%= request.getAttribute("error") %></p>
            <% } %>
        </div>
    <% } else { %>
        <p>No photographer found in session. Please <a class="refLink" href="loginPhotographer.jsp" >login</a>.</p>
    <% } %>
</body>
</html>