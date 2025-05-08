<!-- Not finished -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ page import="com.chat.model.Chat" %>
 <%@ page import="com.chat.dao.UserStatusDAO" %>

<%

    Chat user = (Chat) session.getAttribute("chat");

	UserStatusDAO statusDAO = new UserStatusDAO();
	statusDAO.updateUserStatus(user.getId(), "offline");
	
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
	<link rel="stylesheet" href="assets/style.css">   
</head>
<body>
    <p>Logging out as a Photographer...</p>
</body>
</html>