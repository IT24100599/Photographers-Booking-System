<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.userMgr.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Photographers</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="assets/portfolio.css">
    <link rel="stylesheet" href="assets/dashboards.css">
    <link rel="stylesheet" href="assets/findPhotographers.css">
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
                <li class="active"><a href="#"><i class="fas fa-camera"></i> Find Photographers</a></li>
                <li><a href="customer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li><a href="customer.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="customer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutCustomer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
         <% User user = (User)session.getAttribute("user");%>
        
        <div class="main-content">
            <header class="glass-card">
                <h1>Find Perfect Photographers</h1>
                <div class="user-info">
                    <div class="notifications">
                        <i class="fas fa-bell"></i>
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
            <% if (user != null) { %>
                <div id="ph-top"></div>
                <div class="search-filter-section" >
                    <div class="search-box glass-input">
                        <i class="fas fa-search"></i>
                        <input type="text" id="photographer-search" placeholder="Search by name, specialty or location...">
                    </div>
                    <div class="filter-options">
                        <select id="specialty-filter" class="glass-input">
                            <option value="">All Specialties</option>
                            <option value="Wedding">Wedding</option>
                            <option value="Portrait">Portrait</option>
                            <option value="Event">Event</option>
                            <option value="Fashion">Fashion</option>
                            <option value="Commercial">Commercial</option>
                        </select>
                        <select id="rating-filter" class="glass-input">
                            <option value="">All Ratings</option>
                            <option value="5">5 Stars</option>
                            <option value="4">4+ Stars</option>
                            <option value="3">3+ Stars</option>
                        </select>
                    </div>
                </div>
                
                <div class="photographers-grid" id="photographers-container">

                </div>
                

                <div class="modal" id="photographer-details-modal">
                    <div class="modal-content glass-card wide-modal">
                        <div class="modal-header">
                            <h3>Photographer Details</h3>
                            <button class="close-btn" id="close-details-modal"><i class="fas fa-times"></i></button>
                        </div>
                        <div class="photographer-detail-content">
                            <div class="photographer-detail-header">
                                <img src="" alt="Photographer" class="photographer-profile-img" id="modal-photographer-img">
                                <div class="photographer-header-info">
                                    <h4 id="modal-photographer-name"></h4>
                                    <p class="specialty" id="modal-photographer-specialty"></p>
                                    <div class="rating" id="modal-photographer-rating"></div>
                                </div>
                            </div>
                            <div class="photographer-detail-item">
                                <h5>About</h5>
                                <p id="modal-photographer-bio"></p>
                            </div>
                            <div class="photographer-detail-item">
                                <h5>Location</h5>
                                <p id="modal-photographer-location"></p>
                            </div>
                            <div class="photographer-detail-item">
                                <h5>Experience</h5>
                                <p id="modal-photographer-experience"></p>
                            </div>
                            <div class="photographer-detail-item">
                                <h5>Pricing</h5>
                                <p id="modal-photographer-pricing"></p>
                            </div>
                            
                            <div id="photographer-gallery">
                                <h4>Portfolio Samples</h4>
                                <div class="sample-images-grid" id="sample-images-container">
                                    <!-- Sample images will be added here -->
                                </div>
                            </div>
                            
                            <div class="modal-actions">
                                <button class="btn-animated message-btn" id="message-photographer-btn">
                                    <i class="fas fa-envelope"></i> Message
                                </button>
                                <button class="btn-animated book-now-btn" id="book-photographer-btn">
                                    <i class="fas fa-calendar-check"></i> Book Now
                                </button>
                            </div>
                        </div>
                        <% } else { %>
        			<h1>No user found in session. Please <a class="refLink" href="customer-login.jsp" >login</a>.</h1>
    				<% } %>
                    </div>
                </div>
                
                <!-- Image Preview Modal - Moved inside content-section
                <div class="modal" id="image-preview-modal">
                    <div class="image-preview-content">
                        <button class="close-btn" id="close-preview-modal"><i class="fas fa-times"></i></button>
                        <img src="" alt="Preview Image" id="preview-image">
                        <div class="image-navigation">
                            <button class="nav-btn prev-btn" id="prev-image-btn"><i class="fas fa-chevron-left"></i></button>
                            <button class="nav-btn next-btn" id="next-image-btn"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>
                </div>-->
            </div>
        </div>
    </div>

    <script src="assets/findPhotographers.js"></script>
</body>
</html>
