<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.photographerMgr.models.Photographer" %>
<%@ page import="com.paymentMgr.models.Payment" %>
<%@ page import="java.util.List" %>

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
                <li class="active" ><a><i style="margin: 0 0 0 3px;" class="fas fa-calendar"></i> Bookings</a></li>
                <li><a href="#"><i style="margin: 0 3px 0 5px;" class="fas fa-dollar-sign"></i> Earnings</a></li>
                <li><a href="photographer_chatList.jsp"><i class="fas fa-comments"></i> Messages</a></li>
                <li><a><i class="fas fa-user"></i> My Profile</a></li>
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
            	<%if(photographer!=null) { %>
                	<h1><span id="customer-name"><%= photographer.getFullName() %></span>'s Professional Profile</h1>
                <% } else {%>
                    <h1>Professional Profile</h1>
                <% } %>
                
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
                    <h1>My Orders</h1>

        <form id="myForm" action="displayPaymentsPHOTO" method="get">
                <input type="hidden" id="photographer" name="photographer" value="<%= photographer.getUsername() %>">
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
        			<h1>No user found in session. Please <a class="refLink" href="photographer-login.jsp" >login</a>.</h1>
    				<% } %>
        			

                    <!--End-->
                </div>
            </div>
        </div>
    </div>
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
    <!--  --><script src="assets/main.js"></script>
    <script src="assets/dashboards.js"></script>
</body>
</html>
