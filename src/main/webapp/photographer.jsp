<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.photographerMgr.models.Photographer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photographer Profile</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="assets/dashboards.css" defer>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="background"></div>
    
    <div class="dashboard-container">
        <div class="sidebar glass-card">
            <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
            <ul class="nav-links">
                <li><a href="#"><i class="fas fa-building"></i> Dashboard</a></li>
                <li><a href="#"><i style="margin: 0 0 0 3px;" class="fas fa-calendar"></i> Bookings</a></li>
                <li><a href="#"><i style="margin: 0 3px 0 5px;" class="fas fa-dollar-sign"></i> Earnings</a></li>
                <li><a href="photographer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li class="active"><a><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="portfolio.jsp"><i class="fas fa-images"></i> Portfolio</a></li>
                <li><a href="photographer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li> 
            </ul>
            <div class="sidebar-footer">
                <a href="logoutPhotographer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
        <% Photographer photographer = (Photographer)session.getAttribute("photographer"); %>
        <div class="main-content">
            <header class="glass-card">
            
            	
                	<h1>My Chat</h1>
                
                <div class="user-info">
                    <div class="notifications">
                        <i style="color: white !important;" class="fas fa-bell"></i>
                        <span class="badge">2</span>
                    </div>
                    <div class="user-avatar">
                    	<% if (photographer != null) { %>                  		
                    		<img src="displayProfilePic?targetName=<%= photographer.getUsername() %>" alt="Profile Picture" id="profile-picture">
                        <% } else { %>
		                    <img src="assets/defaults/unknown.gif" alt="Profile Picture" id="profile-picture">
               	        <% } %>
                    
                    </div>
                </div>
            </header>
            
            <div class="content-section glass-card">
                <div class="profile-section">

                <!--Start-->
    			<% if (photographer != null) { %>   			   			    			
                    <div class="profile-header">
                        <h2>Profile Picture</h2>
                    </div>
                    
                    <form action="uploadProfilePic" method="post" enctype="multipart/form-data" class="profile-picture-form">
                        <input type="hidden" name="targetName" value="<%= photographer.getUsername() %>">
                        <div class="profile-picture-upload">
                            <div class="profile-picture-container glass-card">
                                <img src="displayProfilePic?targetName=<%= photographer.getUsername() %>" alt="Profile Picture" id="profile-picture-preview">
                                <div class="profile-picture-overlay">
                                    <button type="button" class="btn-animated picture-btn" onclick="triggerFileInput()">
                                        <i class="fas fa-camera"></i>
                                    </button>
                                </div>
                            </div>
                            <input type="file" id="profile-picture-input" name="profilePic" accept="image/*" class="hidden-file-input">
                            <button type="submit" class="btn-animated picture-submit-btn hidden">
                                <i class="fas fa-save"></i> Save Photo
                            </button>
                        </div>
                    </form>
                    <% if (request.getAttribute("errorMessage") != null) { %>
        				<p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    				<% } %>
                    <hr class="glass-hr">
                    <br>
                    
                    
                    <div class="profile-header">
                        <h2>Photographer Profile</h2>
                        <button type="button" id="edit-profile-btn" class="btn-animated" onclick="handleEditProfile(event)"><i class="fas fa-edit"></i> Edit Profile</button>
                    </div>
                    
                    <form action="PhotographerProfileServlet" method="post" id="profile-form">
                        <input type="hidden" name="originalUsername" value="<%= photographer.getUsername() %>">
                        <input type="hidden" name="originalEmail" value="<%= photographer.getEmail() %>">
                        <div class="profile-grid">
                        	<div class="profile-field">
                                <label>Full Name</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="username customer-name-input" minlength="5" maxlength="35" name="fullName" value="<%= photographer.getFullName() %>" required disabled>
                                    <i class="icon fas fa-user"></i>
                                </div>
                            </div>
                        
                        
                            <div class="profile-field">
                                <label>Username</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="username customer-name-input" minlength="5" maxlength="15" name="username" value="<%= photographer.getUsername() %>" required disabled>
                                    <i class="icon fas fa-user"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Email</label>
                                <div class="input-box glass-input">
                                    <input type="email" id="email customer-email-input" name="email" value="<%= photographer.getEmail() %>" required disabled>
                                    <i class="icon fas fa-envelope"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Gender</label>
                                <div class="gender-display glass-input" id="gender-display"><%= photographer.getGender() %></div>
                                <div class="gender-edit hidden">
                                    <div class="radio-group">
                                        <label><input type="radio" id="gender" name="gender" value="Male" checked> Male</label>
                                        <label><input type="radio" id="gender" name="gender" value="Female"> Female</label>
                                        <label><input type="radio" id="gender" name="gender" value="Other"> Other</label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Phone</label>
                                <div class="input-box glass-input">
                                    <input type="tel" id="phone phone-input" name="phone" minlength="10" maxlength="10"  value="<%= photographer.getPhone() %>" required disabled>
                                    <i class="icon fas fa-phone"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Address</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="address address-input" name="address" minlength="5" value="<%= photographer.getOriginalAddress() %>" required disabled>
                                    <i class="icon fas fa-house"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field edit-only" style="display: none;">
                                <label>New Password</label>
                                <div class="input-box glass-input">
                                    <input type="password" id="password secondary-address-input" minlength="6" name="password" value="<%= photographer.getPassword() %>" placeholder="Your Password"disabled>
                                    <i class="icon fas fa-lock"></i>
                                </div>
                            </div>
                            
                        
                            
                            <div class="profile-field">
                                <label>Skills</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="customer-preferences-input" name="skills" value="<%= photographer.getOriginalSkills() %>" required disabled>
                                    <i class="icon fas fa-star"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Description</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="customer-preferences-input" name="description" value="<%= photographer.getDescription() %>" required disabled>
                                    <i class="icon fas fa-book"></i>
                                </div>
                            </div>
                            
                            <div class="profile-field">
                                <label>Experience</label>
                                <div class="input-box glass-input">
                                    <input type="text" id="customer-preferences-input" name="experience" value="<%= photographer.getExperience() %>" required disabled>
                                    <i class="icon fas fa-briefcase"></i>
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
                    
                     
        		
   					 <% } else { %>
        			<h1>No user found in session. Please <a class="refLink" href="photographer-login.jsp" >login</a>.</h1>
    				<% } %>
        			

                    <!--End-->
                </div>
            </div>
        </div>
    </div>
    
    <!--  --><script src="assets/main.js"></script>
    <script src="assets/dashboards.js"></script>
</body>
</html>
