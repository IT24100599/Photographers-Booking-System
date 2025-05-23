<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.photographerMgr.models.Photographer" %>

<%@ page import="com.chat.model.Chat"%>
<%@ page import="com.chat.dao.UserDAO"%>
<%@ page import="com.chat.dao.MessageDAO"%>
<%@ page import="com.chat.dao.UserStatusDAO"%>
<%@ page import="com.chat.model.UserStatus"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<% 
Photographer user = (Photographer)session.getAttribute("photographer");

Chat currentUser = (Chat) session.getAttribute("chat");

MessageDAO messageDAO = new MessageDAO();
Map<Integer, Integer> unreadCounts = new HashMap<>();
%>

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
    <link rel="stylesheet" href="assets/finalDash.css">
    
    <link rel="stylesheet" href="assets/dashboards.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="background"></div>
    
    <div class="dashboard-container">
        <div class="sidebar glass-card">
            <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
            <ul class="nav-links">
                <li class="active"><a><i class="fas fa-building"></i> Dashboard</a></li>
                <li><a href="photographer-orders.jsp"><i class="fas fa-calendar"></i> My Bookings</a></li>
                <li><a href="findPhotographers.jsp"><i class="fas fa-camera"></i> Find Photographers</a></li>
                <li><a href="photographer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li><a href="photographer.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="photographer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutCustomer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
        
        <div class="main-content">
            <header class="glass-card">
            
            	<%if(user!=null) { %>
                	<h1><span id="customer-name"><%= user.getFullName() %></span>'s Dashboard</h1>
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
                    		<img src="displayProfilePic?targetName=<%= user.getUsername() %>" alt="Profile Picture" id="profile-picture">
                        <% } else { %>
		                    <img src="assets/defaults/unknown.gif" alt="Profile Picture" id="profile-picture">
               	        <% } %>
                    
                    </div>
                </div>
            </header>
            
            <div class="content-section glass-card">
            
            <% if (user != null) {
    		// Get all users
    		UserDAO userDAO = new UserDAO();
    		List<Chat> users = userDAO.getAllUsers();

   			 // Get user statuses
   			UserStatusDAO statusDAO = new UserStatusDAO();
    		List<UserStatus> allStatuses = statusDAO.getAllUserStatuses();
    		Map<Integer, String> userStatuses = new HashMap<>();
    		for (UserStatus status : allStatuses) {
        		userStatuses.put(status.getUserId(), status.getStatus());
    		}
		    
    		int received = 0;
    		int tolUsers = 0;
    		int totalMessages = 0;
    		boolean hasUsers = false;
			%>
                <div class="profile-section">
                	<% 
                		for (Chat userls : users) {
							Map<String, Integer> messageCounts = messageDAO.getMessageCountsBetweenUsers(currentUser.getId(), userls.getId());
                                
							received = messageCounts.get("received");

                            	
                           if ((userls.getId() != currentUser.getId())) {
                              hasUsers = true;
                                    
                              int count = messageDAO.countUnreadMessages(userls.getId(), currentUser.getId());
                              unreadCounts.put(userls.getId(), count);
                                    
                              if (received > 0) {
                                 totalMessages += unreadCounts.getOrDefault(userls.getId(), 0);
                                 tolUsers++;
                              }
                           }
                        } 
                     %>
                    <div class="profileSum">
                        <div class="profile-picture-container glass-card">
                            <img src="displayProfilePic?targetName=<%= user.getUsername() %>" alt="Profile Picture" id="profile-picture-preview">   
                        </div>

                        <div class="profData">
                            <h2><%= user.getFullName() %></h2>
                            <h4>@<%= user.getUsername() %></h4>
                            <hr id="profbr">
                            <p>Email: <%= user.getEmail() %></p>
                            <p>Phone: <%= user.getPhone() %></p>
                            <p>Ratings: <%= user.getRatings() %></p>
                            <hr id="profbr">
                            <button type="button"  onclick="window.location.href='customer.jsp'" class="btn-animated"><i class="fas fa-edit"></i> Edit Profile</button>
                        </div>
                    </div>
                    <div class="hrzBR"></div>
                    <div class="messageSum">
                        <i class="fas fa-envelope"></i>
                        <%if(totalMessages == 0) {%>
                    	    <h4>No unread messages.</h4>
                    	<%} else if(tolUsers == 1) {%>
                        	<% if (totalMessages == 1) { %>
                        		<h4>You have a message</h4>
                        	<% } else { %>
                        	    <h4>You have <%= totalMessages %> messages</h4>
                        	<% } %>
                        	<h4>from a user.</h4>
                        <%} else {%>
	                        <h4>You have <%= totalMessages %> messages</h4>
	                        <h4>from <%= tolUsers %> users</h4>
                        <%} %>  	                       	
                        <button type="button"  onclick="window.location.href='customer_chatList.jsp'" class="btn-animated"><i class="fas fa-comments"></i> View All Messages</button>
                    </div>    
                </div>

                <br>
                <hr class="glass-hr">
                <br>
    			
                <div class="profile-header">
                    <h2>My Latest Bookings</h2>
                    <button type="button" id="edit-profile-btn" class="btn-animated" ><i class="fas fa-edit"></i> View All Bookings</button>
                </div>
                    
                <br>
                <hr class="glass-hr">
                <br>  
                
                <div class="profile-header">
                    <h2>My Latest Payment</h2>
                </div>
                
                <br>
                <hr class="glass-hr">
                <br>
    			
                <div class="profile-header">
                    <h2>My Reviews</h2>
                    <button type="button" id="edit-profile-btn" class="btn-animated" ><i class="fas fa-edit"></i> View All Reviews</button>
                </div>


            </div>
            <%} else { %>
        			<h1>No user found in session. Please <a class="refLink" href="customer-login.jsp" >login</a>.</h1>
        	<% } %>
            </div>
        </div>
        </div>
   
    <script src="assets/dashboards.js"></script>
    </body>
</html>
