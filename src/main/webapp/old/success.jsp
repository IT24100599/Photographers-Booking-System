<!-- Demo  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Successful</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
    <h2>Successful</h2>
    <p>Your registration was completed successfully. {This is a demo redirection.}</p>
    <p>Date: <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()) %></p>
    <a href="index.jsp">Back to Home</a>
</body>
</html>