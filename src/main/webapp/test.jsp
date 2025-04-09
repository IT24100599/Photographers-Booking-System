<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% if (request.getAttribute("errorMessage") != null) { %>
        <p><%= request.getAttribute("errorMessage") %></p>
    <% } %>
    
    <form action="test.jsp" method="get">
        <div>
            <label for="username">Username:</label>
            <input type="text" id="targetName" name="targetName" required>
        </div>
        <div>
            <input type="submit" value="Show Profile">
        </div>
    </form>
    
    <% if (request.getParameter("username") != null && !request.getParameter("username").trim().isEmpty()) { %>
        <div>
            <h3>Profile Picture for <%= request.getParameter("username") %>:</h3>
            <img src="displayProfile?username=<%= request.getParameter("username") %>" alt="Profile Picture" width="200">
        </div>
    <% } %>
</body>
</html>