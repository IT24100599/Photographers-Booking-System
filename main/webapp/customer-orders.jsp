<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.userMgr.models.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.paymentMgr.models.Payment" %>
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
    <link rel="stylesheet" href="assets/dashboards.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
      
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .filter-form {
            margin: 20px 0;
            padding: 15px;
            background-color: #eef;
            border-radius: 5px;
        }
        .filter-form div {
            margin-bottom: 10px;
        }
        .filter-form label {
            display: inline-block;
            width: 100px;
        }
        .filter-form input[type="text"] {
            padding: 5px;
            width: 200px;
        }
        .filter-form input[type="submit"] {
            padding: 5px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
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
                <li class="active"><a><i class="fas fa-calendar"></i> My Bookings</a></li>
                <li><a href="findPhotographers.jsp"><i class="fas fa-camera"></i> Find Photographers</a></li>
                <li><a href="customer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li ><a><i class="fas fa-user"></i> My Profile</a></li>
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

    <h1>My Orders</h1>

        <form id="myForm" action="displayPayments" method="get">
                <input type="hidden" id="username" name="username" value="<%= user.getUsername() %>">
        </form>
    </div>
    
    <% 
    String filterType = (String)request.getAttribute("filterType");
    String filterValue = (String)request.getAttribute("filterValue");

    List<Payment> payments = (List<Payment>)request.getAttribute("payments");
    
    if (payments == null || payments.isEmpty()) { 
    %>
        <p>No payment records found.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Cardholder</th>
                    <th>Card Number</th>
                    <th>Expiry Date</th>
                    <th>Submission Date</th>
                    <th>Username</th>
                    <th>Photographer</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <% for (Payment payment : payments) { %>
                    <tr>
                        <td><%= payment.getCardholderName() %></td>
                        <td><%= payment.getMaskedCardNumber() %></td>
                        <td><%= payment.getExpiryDate() %></td>
                        <td><%= payment.getSubmissionDate() %></td>
                        <td><%= payment.getUsername() %></td>
                        <td><%= payment.getPhotographer() != null ? payment.getPhotographer() : "N/A" %></td>
                        <td><%= payment.getAmount() != null ? payment.getAmount() : "N/A" %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
 
                        
        		
   					 <% } else { %>
        			<p>No user found in session. Please <a class="refLink" href="customer-login.jsp" >login</a>.</p>
    				<% } %>
                </div>
            </div>
        </div>
    </div>
   
    
    <!--  <script src="assets/main.js"></script> -->
    <script>
    document.addEventListener("DOMContentLoaded", function() {
    	  // Check if this is a fresh page load or already a result of form submission
    	  const urlParams = new URLSearchParams(window.location.search);

    	  // Only submit the form if no form parameters exist yet
    	  if (!urlParams.has('username') && !urlParams.has('photographer')) {
    	    document.getElementById("myForm").submit();
    	  }
    	});
	</script>
    <script src="assets/dashboards.js"></script>
    </body>
</html>
