<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chat.model.Chat"%>
<%@ page import="com.chat.dao.UserDAO"%>
<%@ page import="com.userMgr.models.User"%>

<%
    User userC = (User) session.getAttribute("user");
    Chat currentUser = (Chat) session.getAttribute("chat");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Chat</title>
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
        .header { 
            background: #535353; 
            color: white; 
            width: 100%;
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }
       
       .content-section {
       		padding:0;
       }
        .status-delivered { color: #2ecc71; }
        .status-read { color: #3498db; }


        .profile-section {
            display: flex;
            flex-direction: column;
            height: 100%;
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
            margin: 0 0 0 0;
            z-index: 10;
        }

        #messages-container {
            flex-grow: 1;
            overflow-y: auto;
            padding: 15px;
            padding-bottom: 1px; /* Increased space for message area */
            display: flex;
            flex-direction: column;
            scroll-behavior: smooth;
            position: relative;
        }

        .message-area {
            padding: 15px;
            display: flex;
            gap: 10px;
            border-radius: 0 0 15px 15px;
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 100;
            margin: 0 auto;
            width: 100%;
            box-sizing: border-box;
        }

        /* Add this to ensure proper spacing */
        .messages-wrapper {
            position: relative;
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 0;
            max-height: 100%;
            padding: 0 0 75px;
            overflow: hidden;
        }
        
        .message-sender {
            font-weight: 600;
            font-size: 0.8em;
            color: black;
        }
        #message-input {
            flex-grow: 1;
            padding: 12px 15px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        #message-input:focus {
            outline: none;
            box-shadow: 0 0 0 2px #444444;
            background: rgba(255, 255, 255, 0.15);
        }

        #send-button {
            background: #5e5e5e;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 10px 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        #send-button:hover {
            background: #555555;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
        }

        .message {
            padding: 12px 15px;
            margin-bottom: 12px;
            max-width: 75%;
            border-radius: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            position: relative;
            animation: fadeIn 0.3s ease;
            word-break: break-word;
        }

        .message-sent {
            background: rgba(82, 82, 82, 0.7);
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
            margin-left: auto;
        }

        .message-received {
            background: rgba(105, 105, 105, 0.7);
            backdrop-filter: blur(10px);
            align-self: flex-start;
            border-bottom-left-radius: 4px;
            color: white;
            margin-right: auto;
        }

        .message-info {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 5px;
            font-size: 0.75em;
            margin-top: 5px;
            opacity: 0.9;
        }
        
        .loading, .no-messages {
            text-align: center;
            padding: 20px;
            color: rgba(255, 255, 255, 0.7);
            font-style: italic;
            margin: auto;
        }
        
        /* Custom scrollbar for messages container */
        #messages-container::-webkit-scrollbar {
            width: 6px;
        }
        
        #messages-container::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
        }
        
        #messages-container::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 3px;
        }
        
        #messages-container::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        /* Updated status indicators for black and white theme */
        .status-delivered {
            color: #dddddd;
            font-size: 1.1em;
        }
        
        .status-read {
            color: #ffffff;
            font-size: 1.1em;
        }
        
        /* Add typing indicator */
        .typing-indicator {
            align-self: flex-start;
            background: rgba(88, 88, 88, 0.4);
            padding: 8px 15px;
            border-radius: 15px;
            color: rgba(255, 255, 255, 0.8);
            font-style: italic;
            margin-bottom: 10px;
            display: none;
        }
        .back-button {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    font-decoration: none;
}

.back-button:hover {
    background: rgba(255, 255, 255, 0.3);
    transform: translateY(-3px);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    border-color: rgba(255, 255, 255, 0.4);
}

.back-button i {
    font-size: 0.9em;
}
       
     #chatName {
            font-size: 1.5em;
            color: white;
     }
    </style>

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
                <li class="active"><a><i class="fas fa-comments"></i> Messages</a></li>
                <li><a href="customer.jsp"><i class="fas fa-calendar"></i> My Profile</a></li>
                <li><a href="customer-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <div class="sidebar-footer">
                <a href="logoutCustomer.jsp" class="logout-btn btn-animated"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
                        <% if (userC != null) { %>                  		
                    		<img src="displayProfilePicUSER?targetName=<%= userC.getUsername() %>" alt="Profile Picture" id="profile-picture">
                        <% } else { %>
		                    <img src="assets/defaults/unknown.gif" alt="Profile Picture" id="profile-picture">
               	        <% } %>
                    </div>
                </div>
            </header>
            
            <div class="content-section glass-card">
            <% if(userC != null) {

   			String selectedUserIdParam = request.getParameter("userId");
   		 	String selectedUsername = request.getParameter("username");
   		 	String selectedemailParam = request.getParameter("email");
    
    
   		 	int selectedUserId = Integer.parseInt(selectedUserIdParam);
			%>
                <div class="profile-section">
                    <div class="header">
        <button type="button" id="edit-profile-btn" class="btn-animated" onclick="window.location.href='customer_chatList.jsp'"><i class="fas fa-arrow-left"></i> Back</button>
    	<div class="user-avatar">               		
             <img src="displayProfilePic?targetName=<%= selectedUsername %>" alt="Profile Picture" id="profile-picture">
         </div>
    	<h3 id="chatName"><%= selectedUsername %></h3>
    </div>
    
    <!-- Add wrapper div -->
    <div class="messages-wrapper">
        <div id="messages-container">
            <!-- Messages will be loaded here -->
            <div class="loading">Loading messages...</div>
            <div class="typing-indicator">User is typing...</div>
        </div>
        
        <div class="message-area">
            <input type="text" id="message-input" placeholder="Type your message...">
            <button id="send-button">Send</button>
        </div>
    </div>
    
    <script>
        // Basic variables
        var currentUserId = <%= currentUser.getId() %>;
        var currentUsername = "<%= currentUser.getUsername() %>";
        var selectedUserId = <%= selectedUserId %>;
        var selectedUsername = "<%= selectedUsername %>";
        var messageCache = {};
        var lastLoadTime = 0;
        var refreshInterval;
        
        // Load messages
        function loadMessages() {
            const container = document.getElementById('messages-container');
            const isAtBottom = container.scrollHeight - container.clientHeight <= container.scrollTop + 50;
            
            fetch('getMessages?receiverId=' + selectedUserId + '&_=' + new Date().getTime())
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(messages => {
                    // Store current message count to detect new messages
                    const hadMessages = container.querySelectorAll('.message').length > 0;
                    const previousCount = container.querySelectorAll('.message').length;
                    
                    // Update statuses for received messages
                    messages.forEach(message => {
                        if (message.senderId !== currentUserId && message.status !== "read") {
                            updateMessageStatus(message.id, "read");
                        }
                    });

                    // Display the messages
                    displayMessages(messages);
                    
                    // Smart scrolling: Only scroll to bottom if user was already at bottom
                    // or if new messages arrived in an empty chat
                    const currentCount = container.querySelectorAll('.message').length;
                    if (isAtBottom || currentCount > previousCount || !hadMessages) {
                        scrollToBottom();
                    }
                })
                .catch(error => {
                    console.error("Error loading messages:", error);
                    const errorMsg = document.createElement('div');
                    errorMsg.className = 'loading';
                    errorMsg.textContent = 'Failed to load messages. Please try again.';
                    
                    // Only show error if container is empty
                    if (container.querySelector('.loading')) {
                        container.innerHTML = '';
                        container.appendChild(errorMsg);
                    }
                });
        }

        // Display messages
        function displayMessages(messages) {
            var container = document.getElementById('messages-container');
            
            if (messages.length === 0) {
                container.innerHTML = '<div class="no-messages">No messages yet. Start the conversation!</div>';
                return;
            }
            
            // Build HTML
            var html = '';
            messages.forEach(message => {
                var isSent = message.senderId === currentUserId;
                var className = isSent ? 'message message-sent' : 'message message-received';
                var sender = isSent ? 'You' : selectedUsername;
                var time = formatTime(new Date(message.sentTime));
                var status = '';
                
                if (isSent) {
                    if (message.status === 'delivered') {
                        status = '<span class="status-delivered">✓✓</span>';
                    } else if (message.status === 'read') {
                        status = '<span class="status-read">✓✓</span>';
                    } else {
                        status = '<span>✓</span>';
                    }
                }
                
                html += '<div class="' + className + '" data-id="' + message.id + '">' +
                    '<div class="message-sender">' + sender + '</div>' +
                    '<div class="message-content">' + message.content + '</div>' +
                    '<div class="message-info">' + time + ' ' + status + '</div>' +
                '</div>';
            });
            
            // Only update if content changed
            if (container.innerHTML.replace(/<div class="loading">.*?<\/div>|<div class="no-messages">.*?<\/div>|<div class="typing-indicator">.*?<\/div>/g, '') !== html) {
                // Preserve typing indicator
                const typingIndicator = container.querySelector('.typing-indicator');
                container.innerHTML = html;
                if (typingIndicator) container.appendChild(typingIndicator);
            }
            
            // Scroll to bottom
            
        }
        
        // Format time
        function formatTime(date) {
            var hours = date.getHours().toString().padStart(2, '0');
            var minutes = date.getMinutes().toString().padStart(2, '0');
            return hours + ':' + minutes;
        }
        
        // Send a message
        function sendMessage() {
            var input = document.getElementById('message-input');
            var content = input.value.trim();
            
            if (!content) return;
            
            // Clear input
            input.value = '';
            
            // Create form data
            var formData = new URLSearchParams();
            formData.append('receiverId', selectedUserId);
            formData.append('content', content);
            
            // Send to server
            fetch('sendMessage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    loadMessages(); // Reload messages to show sent message
                } else {
                    alert('Failed to send message: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error sending message:', error);
                alert('Network error, please try again');
            });
        }
        
        // Update message status
        function updateMessageStatus(messageId, status) {
            var formData = new URLSearchParams();
            formData.append('messageId', messageId);
            formData.append('status', status);
            
            fetch('updateMessageStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData
            }).catch(error => console.error('Status update error:', error));
        }
        
        // Set up event listeners
        document.addEventListener('DOMContentLoaded', function() {
            // Send button click
            document.getElementById('send-button').addEventListener('click', sendMessage);
            
            // Enter key press
            document.getElementById('message-input').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    sendMessage();
                }
            });
            
            // Initial message load
            loadMessages();
            
            // Set up refresh interval
            refreshInterval = setInterval(loadMessages, 3000);
        });
        
        // Clean up on page leave
        window.addEventListener('beforeunload', function() {
            clearInterval(refreshInterval);
        });
        

     // Add after the sendMessage function
     function scrollToBottom() {
         var container = document.getElementById('messages-container');
         // Use smooth scrolling animation
         container.scrollTo({
             top: container.scrollHeight,
             behavior: 'smooth'
         });
     }
    
    // Add typing indicator functionality
    let typingTimer;
    const typingIndicator = document.querySelector('.typing-indicator');
    
    document.getElementById('message-input').addEventListener('input', function() {
        // Notify server that user is typing (implement server endpoint as needed)
        fetch('userTyping?receiverId=' + selectedUserId, {method: 'POST'})
            .catch(err => console.log('Could not send typing status', err));
            
        clearTimeout(typingTimer);
        typingTimer = setTimeout(() => {
            // Notify server that user stopped typing
            fetch('userStoppedTyping?receiverId=' + selectedUserId, {method: 'POST'})
                .catch(err => console.log('Could not send stopped typing status', err));
        }, 1000);
    });
    </script>
                    
                    
            </div>
            <% } else { %>
                <h1>No user found in session. Please <a class="refLink" href="customer-login.jsp">login</a>.</h1>
            <% } %>
        </div>
    </div>
    
    <!-- Confirmation Modal -->
    <template id="delete-form-template">
        <form class="delete-image-form">
            <input type="hidden" name="imageIndex" value="">
            <button type="submit" class="portfolio-control-btn delete-btn">
                <i class="fas fa-trash"></i>
            </button>
        </form>
    </template>
    
    <script src="assets/main.js"></script>
    <script src="assets/customer-dashboard.js"></script>
    <script src="assets/portfolio.js"></script>
</body>
</html>
