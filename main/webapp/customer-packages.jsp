<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.userMgr.models.User" %>

<% User user = (User)session.getAttribute("user");%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%if(user!=null) { %>
          <title><%= user.getFullName() %>'s Profile</title>
    <% } else {%>
          <title>My Profile</title>
    <% } %>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="assets/packages.css">
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
                <li><a href="customer-orders.jsp"><i class="fas fa-calendar"></i> My Bookings</a></li>
                <li class="active"><a href="findPhotographers.jsp"><i class="fas fa-camera"></i> Find Photographers</a></li>
                <li><a href="customer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li><a><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="customer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutCustomer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
        
        <div class="main-content">
            <header class="glass-card">
            
            	<%if(user!=null) { %>
                	<h1><span id="customer-name"><%= user.getFullName() %></span>'s Profile</h1>
                <% } else {%>
                    <h1>My Profile</h1>
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
                    <div class="packages-dashboard">
                        <div class="packages-filter">
                            <button class="filter-btn active" data-filter="all">All Packages</button>
                            <button class="filter-btn" data-filter="wedding">Wedding</button>
                            <button class="filter-btn" data-filter="portrait">Portrait</button>
                            <button class="filter-btn" data-filter="event">Event</button>
                        </div>
                    
                        <div class="packages-grid">
                            <div class="package-card" data-category="wedding">
                                <div class="package-header">
                                    <h3>Wedding Basic</h3>
                                    <span class="package-price">Rs.15,000</span>
                                </div>
                                <div class="package-content">
                                    <ul class="package-features">
                                        <li><i class="fas fa-check"></i> 6 Hours Coverage</li>
                                        <li><i class="fas fa-check"></i> 1 Photographer</li>
                                        <li><i class="fas fa-check"></i> 200 Digital Images</li>
                                        <li><i class="fas fa-check"></i> Online Gallery</li>
                                    </ul>
                                    <button class="btn-book"  onclick="payment(15000)">Book Now</button>
                                </div>
                            </div>
                            
                            <div class="package-card" data-category="wedding">
                                <div class="package-header">
                                    <h3>Wedding Premium</h3>
                                    <span class="package-price">Rs.30,000</span>
                                </div>
                                <div class="package-content">
                                    <ul class="package-features">
                                        <li><i class="fas fa-check"></i> 10 Hours Coverage</li>
                                        <li><i class="fas fa-check"></i> 2 Photographers</li>
                                        <li><i class="fas fa-check"></i> 500 Digital Images</li>
                                        <li><i class="fas fa-check"></i> Engagement Session</li>
                                        <li><i class="fas fa-check"></i> Wedding Album</li>
                                    </ul>
                                    <button class="btn-book" onclick="payment(30000)">Book Now</button>
                                </div>
                            </div>
                            
                            <!-- Portrait Packages -->
                            <div class="package-card" data-category="portrait">
                                <div class="package-header">
                                    <h3>Portrait Basic</h3>
                                    <span class="package-price">Rs.2,500</span>
                                </div>
                                <div class="package-content">
                                    <ul class="package-features">
                                        <li><i class="fas fa-check"></i> 1 Hour Session</li>
                                        <li><i class="fas fa-check"></i> 1 Location</li>
                                        <li><i class="fas fa-check"></i> 20 Digital Images</li>
                                        <li><i class="fas fa-check"></i> Online Gallery</li>
                                    </ul>
                                    <button class="btn-book" onclick="payment(2500)">Book Now</button>
                                </div>
                            </div>
                            
                            <!-- Event Package -->
                            <div class="package-card" data-category="event">
                                <div class="package-header">
                                    <h3>Corporate Event</h3>
                                    <span class="package-price">Rs.8,000</span>
                                </div>
                                <div class="package-content">
                                    <ul class="package-features">
                                        <li><i class="fas fa-check"></i> 4 Hours Coverage</li>
                                        <li><i class="fas fa-check"></i> 1 Photographer</li>
                                        <li><i class="fas fa-check"></i> 100 Digital Images</li>
                                        <li><i class="fas fa-check"></i> Quick Turnaround</li>
                                    </ul>
                                    <button class="btn-book" onclick="payment(8000)" >Book Now</button>
                                </div>
                            </div>
                        </div>
                    </div>
   					 <% } else { %>
        			<p>No user found in session. Please <a class="refLink" href="customer-login.jsp" >login</a>.</p>
    				<% } %>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    function payment(amount) {
    	const urlParams = new URLSearchParams(window.location.search);
    	const userValue = urlParams.get('name');
    	
    	window.location.href ="payment.jsp?photographer=" +  userValue + "&amount=" + amount;
    }
    </script>
   
    <script src="assets/dashboards.js"></script>
    <script src="assets/packages.js"></script>
    </body>
</html>
