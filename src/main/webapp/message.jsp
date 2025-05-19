<%--
  Created by IntelliJ IDEA.
  User: Malithi
  Date: 13-May-25
  Time: 7:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String photographerName = request.getParameter("name");
    if (photographerName != null) {
        photographerName = URLDecoder.decode(photographerName, "UTF-8");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Message Photographer</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">

<h3>Message to <%= photographerName != null ? photographerName : "Photographer" %></h3>

<form action="sendMessage" method="post">
    <input type="hidden" name="photographerName" value="<%= photographerName %>">

    <div class="mb-3">
        <label for="userName" class="form-label">Your Name:</label>
        <input type="text" id="userName" name="userName" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="messageContent" class="form-label">Message:</label>
        <textarea id="messageContent" name="messageContent" class="form-control" rows="5" required></textarea>
    </div>

    <button type="submit" class="btn btn-success">Send Message</button>
    <a href="photographers" class="btn btn-secondary">Back</a>
</form>

</body>
</html>

