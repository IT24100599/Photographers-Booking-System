<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.userMgr.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
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
                <li><a href="#"><i class="fas fa-building"></i> Dashboard</a></li>
                <li><a href="#"><i class="fas fa-calendar"></i> My Bookings</a></li>
                <li><a href="#"><i class="fas fa-camera"></i> Find Photographers</a></li>
                <li><a href="#"><i class="fas fa-history"></i> Booking History</a></li>
                <li class="active"><a href="customer.html"><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="#"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutCustomer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
        <% User user = (User)session.getAttribute("user");%>
        
        <div class="main-content">
            <header class="glass-card">
            
            	<%if(user!=null) { %>
                	<h1>Welcome, <span id="customer-name"><%= user.getFullName() %></span>!</h1>
                <% } else {%>
                    <h1>Welcome to Dashboard !</h1>
                <% } %>
                <div class="user-info">
                    <div class="notifications">
                        <i style="color: white !important;" class="fas fa-bell"></i>
                        <span class="badge">2</span>
                    </div>
                    
                    <div class="user-avatar">
                    	<% if (user != null) { %>                  		
                    		<img src="assets/defaults/<%=user.getDefaultProfilePic()%>" alt="Profile Picture" id="profile-picture">
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
                        <h2>My Profile</h2>
                        <button type="button" id="edit-profile-btn" class="btn-animated" onclick="handleEditProfile(event)"><i class="fas fa-edit"></i> Edit Profile</button>
                    </div>
                    
                    <form action="ProfileServlet" method="post" id="profile-form">
                        <input type="hidden" name="originalUsername" value="<%= user.getUsername() %>">
                        <input type="hidden" name="originalEmail" value="<%= user.getEmail() %>">
                        <div class="profile-grid"> <!-- corrected the class name back to profile-grid -->
                        	<div class="profile-field">
                                <label>Full Name</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="fullName customer-username-input" minlength="5" maxlength="35" name="fullName" value="<%= user.getFullName() %>" required disabled>
                                    <i class="icon fas fa-user"></i>
                                </div>
                            </div>
                        
                        
                            <div class="profile-field">
                                <label>Username</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="username customer-name-input" minlength="5" maxlength="15" name="username" value="<%= user.getUsername() %>" required disabled>
                                    <i class="icon fas fa-user"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Email</label>
                                <div class="input-box glass-input">
                                    <input type="email" id="email customer-email-input" name="email" value="<%= user.getEmail() %>" required disabled>
                                    <i class="icon fas fa-envelope"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Gender</label>
                                <div class="gender-display glass-input" id="gender-display"><%= user.getGender() %></div>
                                <div class="gender-edit hidden">
                                    <div class="radio-group">
                                        <label><input type="radio" id="gender" name="gender" value="Male"> Male</label>
                                        <label><input type="radio" id="gender" name="gender" value="Female"> Female</label>
                                        <label><input type="radio" id="gender" name="gender" value="Other"> Other</label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Phone</label>
                                <div class="input-box glass-input">
                                    <input type="tel" id="phone phone-input" name="phone" minlength="10" maxlength="10"  value="<%= user.getPhone() %>" required disabled>
                                    <i class="icon fas fa-phone"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Address</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="address address-input" name="address" minlength="5" value="<%= user.getOriginalAddress() %>" required disabled>
                                    <i class="icon fas fa-house"></i>
                                </div>
                            </div>
                            
                            
                            <!--  <div class="profile-field">
                                <label>Photography Preferences</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="customer-preferences-input" value="No Data !" required disabled>
                                    <i class="icon fas fa-image"></i>
                                </div>
                            </div>-->
                            
                            <div class="profile-field edit-only" style="display: none;">
                                <label>New Password</label>
                                <div class="input-box glass-input">
                                    <input type="password" id="password secondary-address-input" minlength="6" name="password" value="<%= user.getPassword() %>" placeholder="Your Password"disabled>
                                    <i class="icon fas fa-lock"></i>
                                </div>
                            </div>
                            
                        </div>
                        
                        	<% if (request.getAttribute("message") != null) { %>
    	        	    	<p style="color: green;"><%= request.getAttribute("message") %></p>
        	    			<% } %>
            				<% if (request.getAttribute("error") != null) { %>
                			<p style="color: red;"><%= request.getAttribute("error") %></p>
            				<% } %>
                        
                        <div class="form-actions hidden">
	                    	
                            <button type="submit"  class="button btn btn-animated save-btn">Save Changes</button> <!-- onclick="handleSaveProfile(event)" -->
                            <button type="button" class="btn btn-animated cancel-btn" id="cancel-edit-btn" onclick="handleCancelEdit(event)">Cancel</button>
                        </div>
                    </form>
                    
                    <div class="delete-profile-container">
                    		
                        <form>
                            <button type="button" class="btn btn-animated delete-btn" id="delete-profile-btn" onclick="handleDeleteProfile(event)">
                            	<i class="fas fa-trash-alt"></i> Delete Profile
                        	</button>
                        </form>
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
