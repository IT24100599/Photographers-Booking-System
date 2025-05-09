
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.photographerMgr.models.Photographer" %>

<%@ page import="com.chat.model.Chat"%>
<%@ page import="com.chat.dao.UserDAO"%>
<%@ page import="com.chat.dao.UserStatusDAO"%>
<%@ page import="com.chat.model.UserStatus"%>
<%@ page import="com.chat.dao.MessageDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<%
    Photographer userP = (Photographer) session.getAttribute("photographer");
    // Check if user is logged in
    Chat currentUser = (Chat) session.getAttribute("chat");
    
    MessageDAO messageDAO = new MessageDAO();
    Map<Integer, Integer> unreadCounts = new HashMap<>();
	

%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photographer's Message Page</title>
    <link rel="stylesheet" href="assets/main.css">
    <link rel="stylesheet" href="assets/portfolio.css">
    <link rel="stylesheet" href="assets/dashboards.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 0; 
            display: flex; 
            flex-direction: column;
            height: 100vh; 
        }

        .profile-section {
            display: flex;
            flex-direction: column;
            height: 75vh;
            width: 100%;
            position: relative;
            border-radius: 15px;
            overflow: hidden;
        }

        .profile-section .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px 15px 0 0;
            color: var(--text-color);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 0;
            z-index: 10;
        }
        
        .content-section {
            padding: 0;
         }

        .back-button {
            background: rgba(94, 94, 94, 0.6);
            backdrop-filter: blur(10px);
            color: white;
            border: none;
            border-radius: 20px;
            padding: 8px 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .back-button:hover {
            background: rgba(85, 85, 85, 0.8);
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
        }

        /* Chat list styling */
        h3 {
            margin: 20px;
            color: white;
        }

        .user-list {
            list-style: none;
            padding: 35px;
            margin: 0;
        }

        .user-item {
            margin-bottom: 10px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            padding: 20px 20px;
        }

        .user-item a {
            color: white;
            text-decoration: none;
            flex-grow: 1;
            margin-left: 10px;
            font-weight: 500;
        }

        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 8px;
        }

        .status-online {
            background-color: #2ecc71;
            box-shadow: 0 0 5px #2ecc71;
        }

        .status-offline {
            background-color: #7f8c8d;
        }

        .status-away {
            background-color: #f39c12;
            box-shadow: 0 0 5px #f39c12;
        }

        .user-status {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.85em;
            margin-left: 10px;
        }

        /* Custom scrollbar */
        .user-list-container::-webkit-scrollbar {
            width: 6px;
        }

        .user-list-container::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
        }

        .user-list-container::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 3px;
        }

        .user-list-container::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        /* No users message */
        .no-users {
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            font-style: italic;
            padding: 20px;
        }
    </style>
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
                <li class="active"><a><i class="fas fa-comments"></i> Messages</a></li>
                <li><a href="photographer.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                <li><a href="portfolio.jsp"><i class="fas fa-images"></i> Portfolio</a></li>
                <li><a href="photographer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutPhotographer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <div class="main-content">
            <header class="glass-card">
                <h1>My Messages</h1>
                <div class="user-info">
                    <div class="notifications">
                        <i class="fas fa-bell"></i>
                        <span class="badge">2</span>
                    </div>
                    <div class="user-avatar">
                        <% if (userP != null) { %>                  		
                    		<img src="displayProfilePic?targetName=<%= userP.getUsername() %>" alt="Profile Picture" id="profile-picture">
                        <% } else { %>
		                    <img src="assets/defaults/unknown.gif" alt="Profile Picture" id="profile-picture">
               	        <% } %>
                    </div>
                </div>
            </header>

            <div class="content-section glass-card">
            <%if(userP != null) {

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
    // Count online users
    		int onlineUsers = 0;
    		for (String status : userStatuses.values()) {
        		if ("online".equals(status)) {
           		 onlineUsers++;
        		}
   			 }
  		 	 
			%>
            
                <div class="profile-section">

                        <ul class="user-list">
                            <%
                            boolean hasUsers = false;
                            for (Chat user : users) {
                            	Map<String, Integer> messageCounts = messageDAO.getMessageCountsBetweenUsers(currentUser.getId(), user.getId());
                                
                            	received = messageCounts.get("received");

                            	
                                if ((user.getId() != currentUser.getId())) {
                                    hasUsers = true;
                                    String statusClass = "status-offline";
                                    String userStatus = userStatuses.getOrDefault(user.getId(), "offline");
                                    int count = messageDAO.countUnreadMessages(user.getId(), currentUser.getId());
                                    unreadCounts.put(user.getId(), count);

                                    if ("online".equals(userStatus)) {
                                        statusClass = "status-online";
                                    } else if ("away".equals(userStatus)) {
                                        statusClass = "status-away";
                                    }
                                    
                                    if (received > 0) {
                            %>
                            
                                <li class="btn-animated user-item">
	                                 <div class="user-avatar">               		
                    						<img src="displayProfilePicUSER?targetName=<%= user.getUsername() %>" alt="Profile Picture" id="profile-picture">
                    				 </div>
                                    <a href="photographer_chat.jsp?userId=<%= user.getId() %>&username=<%= user.getUsername() %>">
                                        <%= user.getUsername() %>
                                         <% int unreadCount = unreadCounts.getOrDefault(user.getId(), 0);
                                        if (unreadCount > 0) { %>
                                    		<span>&nbsp;&nbsp;</span>
                                        	<% if (unreadCount == 1) {%>
                                    		<span class="user-status">There is a new message</span>
                                    		<% } else { %>
                                    		<span class="user-status"><%= unreadCount %> new message</span>
                                    		<% }} %>
                                    </a>
                                    <span class="user-status"><%= userStatus %>&nbsp;&nbsp;<span class="status-indicator <%= statusClass %>"></span></span>

                                </li>
                            <%}
                                }
                            }
                            if (!hasUsers) {
                            %>
                                <div class="no-users">No Messages.</div>
                            <% } %>
                        </ul>

                    <script type="text/javascript">
                 // This can be added at the bottom of userlist.jsp for real-time unread counts
                    function updateUnreadCounts() {
                        fetch('getUnreadCounts')
                            .then(response => response.json())
                            .then(data => {
                                // Update unread badges
                                const userItems = document.querySelectorAll('.user-item');
                                userItems.forEach(item => {
                                    const userId = item.getAttribute('data-userid');
                                    const count = data[userId] || 0;
                                    
                                    // Get or create badge
                                    let badge = item.querySelector('.unread-badge');
                                    
                                    if (count > 0) {
                                        if (!badge) {
                                            badge = document.createElement('span');
                                            badge.className = 'unread-badge';
                                            item.insertBefore(badge, item.lastChild);
                                        }
                                        badge.textContent = count;
                                    } else if (badge) {
                                        badge.remove();
                                    }
                                });
                            })
                            .catch(error => console.error('Error updating unread counts:', error));
                    }

                    // Update counts every 5 seconds
                    setInterval(updateUnreadCounts, 5000);

                    // Initial update
                    document.addEventListener('DOMContentLoaded', updateUnreadCounts);
                    
                 // Update counts every 5 seconds
                    setInterval(updateUnreadCounts, 5000);

                    // Initial update
                    document.addEventListener('DOMContentLoaded', updateUnreadCounts);
                    </script>
                </div>
                <% } else { %>
        			<h1>No user found in session. Please <a class="refLink" href="photographer-login.jsp" >login</a>.</h1>
        		<% } %>
            </div>
        </div>
    </div>

    <script src="assets/main.js"></script>
    <script src="assets/customer-dashboard.js"></script>
    <script src="assets/portfolio.js"></script>
</body>
</html>
