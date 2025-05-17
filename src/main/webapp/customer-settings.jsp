<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.userMgr.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Settings</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="assets/dashboards.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="background"></div>
    
    <div class="dashboard-container">
        <div class="sidebar glass-card">
            <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
            <ul class="nav-links">
                <li><a href="customer-dashboard.jsp"><i class="fas fa-building"></i> Dashboard</a></li>
                <li><a href="#"><i class="fas fa-calendar"></i> My Bookings</a></li>
                <li><a href="findPhotographers.jsp"><i class="fas fa-camera"></i> Find Photographers</a></li>
                <li><a href="customer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li><a href="customer.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                <li class="active"><a><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutCustomer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
        <% User user = (User)session.getAttribute("user");%>
        
        <div class="main-content">
            <header class="glass-card">
            
            	<%if(user!=null) { %>
                	<h1><span id="customer-name"><%= user.getFullName() %></span>'s Settings</h1>
                <% } else {%>
                    <h1>My Settings</h1>
                <% } %>
                <div class="user-info">
                    <div class="notifications">
                        <i style="color: white !important;" class="fas fa-bell"></i>
                        <span class="badge">2</span>
                    </div>
                    
                    <div class="user-avatar">
                    	<% if (user != null) { %>                  		
                    		<img src="displayProfilePicUSER?targetName=<%= user.getUsername() %>" alt="Profile Picture" id="profile-picture">
                        <% } else { %>
		                    <img src="assets/defaults/unknown.gif" alt="Profile Picture" id="profile-picture">
               	        <% } %>
                    
                    </div>
                </div>
            </header>
            
            <div class="content-section glass-card">
                <div class="profile-section">
    			<% if (user != null) { %>
                    <div class="profile-header">
                        <h2>Profile Settings</h2>
                    </div>
                    
                   
                        
                        	<% if (request.getAttribute("message") != null) { %>
    	        	    	<p style="color: green;"><%= request.getAttribute("message") %></p>
        	    			<% } %>
            				<% if (request.getAttribute("error") != null) { %>
                			<p style="color: red;"><%= request.getAttribute("error") %></p>
            				<% } %>
                        
                            <button type="button" class="btn btn-animated delete-btn" id="delete-profile-btn" onclick="handleDeleteProfile(event)">
                            	<i class="fas fa-trash-alt"></i> Delete Profile
                        	</button>
                        	<br>
                        	<hr class="glass-hr">
                        	<br>
                        	<div class="profile-header">
                        		<h2>Website Details</h2>
                    		</div>
                       
        		
   					 <% } else { %>
        			<p>No user found in session. Please <a class="refLink" href="customer-login.jsp" >login</a>.</p>
    				<% } %>
                </div>
            </div>
        </div>
    </div>
    

    <div class="modal" id="delete-confirmation-modal">
        <div class="modal-content glass-card">
            <h3><i class="fas fa-exclamation-triangle"></i> Delete Profile</h3>
            <p>Are you sure you want to delete your profile? This action cannot be undone.</p>
            <% if (user != null) { %>
            <div class="modal-actions">
            	<form action="DeleteServlet" method="post">
            		<input type="hidden" name="originalUsername" value="<%= user.getUsername() %>">
                	<button type="button" class="btn btn-animated cancel-modal-btn" onclick="handleCancelDelete(event)">Cancel</button>
                	<button type="submit" class="button btn btn-animated confirm-delete-btn">Yes, Delete My Profile</button> <!-- onclick="handleConfirmDelete(event)" -->
                </form>
            </div>
            <% } %>
        </div>
    </div>
    
    <!--  <script src="assets/main.js"></script> -->
    <script src="assets/dashboards.js"></script>
    </body>
</html>
