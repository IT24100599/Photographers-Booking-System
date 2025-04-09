<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.photographerMgr.models.Photographer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="assets/dashboards.css">
    <link rel="stylesheet" href="assets/portfolio.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <% Photographer photographer = (Photographer)session.getAttribute("photographer"); %>
    <%if(photographer!=null) { %>
             <script src="assets/loadimg.js" type="text/javascript"></script>
    <% }%>
</head>
<body>
    <div class="background"></div>
    
    <div class="dashboard-container">
        <div class="sidebar glass-card">
            <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
            <ul class="nav-links">
                <li><a href="#"><i class="fas fa-building"></i> Dashboard</a></li>
                <li><a href="#"><i style="margin: 0 0 0 3px;" class="fas fa-calendar"></i> Bookings</a></li>
                <li class="active"><a href="portfolio.jsp"><i class="fas fa-images"></i> Portfolio</a></li>
                <li><a href="#"><i style="margin: 0 3px 0 5px;" class="fas fa-dollar-sign"></i> Earnings</a></li>
                <li><a href="photographer.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="photographer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li> 
            </ul>
            <div class="sidebar-footer">
                <a href="logoutPhotographer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
        <div class="main-content">
            <header class="glass-card">
            
            	<%if(photographer!=null) { %>
                	<h1><span id="customer-name"><%=photographer.getFullName() %></span>'s Portfolio</h1>
                <% } else {%>
                    <h1>Photographer Portfolio !</h1>
                    <% } %>
                <div class="user-info">
                    <div class="notifications">
                        <i style="color: white !important;" class="fas fa-bell"></i>
                        <!-- <span class="badge">2</span>-->
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
                <%if(photographer!=null) { %>
                    <div class="profile-header">
                        <h2>My Photos</h2>
                        <form action="upload" method="post" enctype="multipart/form-data" class="upload-form">
                            <label for="image-upload" class="btn-animated upload-btn">
                                <i class="fas fa-upload"></i> Upload Photo
                            </label>
                            <input type="hidden" name="title" value="<%= photographer.getUsername() %>">
                            <input type="file" id="image-upload" name="image" accept="image/*" class="hidden-file-input" onchange="this.form.submit()">
                        </form>
                    </div>
                    <div id="image-grid" class="image-grid">
                <% } else {%>
                    <h1>No user found in session. Please <a class="refLink" href="photographer-login.jsp" >login</a>.</h1>
                <% } %>            
                
                <!-- Image Preview Modal -->
                <div class="image-preview-modal">
                    <div class="modal-overlay"></div>
                    <div class="modal-content">
                        <img src="" alt="Preview" id="preview-image">
                        <button class="close-modal"><i class="fas fa-times"></i></button>
                    </div>
                </div>
                
                </div>
            </div>
        </div>
    </div>

    <script src="assets/dashboards.js"></script>
    <script src="assets/portfolio.js"></script>
</body>
</html>
