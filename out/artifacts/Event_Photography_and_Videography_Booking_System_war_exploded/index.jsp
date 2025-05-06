<%@ page import="com.sorting.event_photography_and_videography_booking_system.Photographer" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>

    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <title>Photographers</title>
    <script>
        function sortTable(columnIndex) {
            let table = document.getElementById("photographerTable");
            let tbody = table.tBodies[0];
            let rows = Array.from(tbody.rows); // Only rows in tbody
            let sortedRows = rows.sort((rowA, rowB) => {
            let valA = parseFloat(rowA.cells[columnIndex].textContent);
            let valB = parseFloat(rowB.cells[columnIndex].textContent);
            return valB - valA; // Descending order
        });
        while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }
            sortedRows.forEach(row => tbody.appendChild(row));
        }
    </script>
</head>
<body class="container mt-4">

<h2 class="mb-3">Photographers</h2>

<!-- Sorting & Filtering Options -->
<div class="d-flex justify-content-between mb-3">
    <!-- Sorting -->
    <div>
        <button class="btn btn-secondary" onclick="sortTable(1)">Sort by Rating</button>
        <button class="btn btn-secondary" onclick="sortTable(2)">Sort by Price</button>
    </div>

    <!-- Filtering -->
    <label for="eventType">Filter by Event Type:</label>
    <select id="eventType" class="form-select" style="width: 200px;" onchange="filterByEventType()">
        <option value="" <%= (request.getParameter("eventType") == null || request.getParameter("eventType").isEmpty()) ? "selected" : "" %>>All</option>
        <option value="Wedding" <%= "Wedding".equals(request.getParameter("eventType")) ? "selected" : "" %>>Wedding</option>
        <option value="Corporate" <%= "Corporate".equals(request.getParameter("eventType")) ? "selected" : "" %>>Corporate</option>
        <option value="Portrait" <%= "Portrait".equals(request.getParameter("eventType")) ? "selected" : "" %>>Portrait</option>
    </select>

    <script>
        function filterByEventType() {
            const eventType = document.getElementById("eventType").value;
            const url = "photographers" + (eventType ? "?eventType=" + encodeURIComponent(eventType) : "");
            window.location.href = url;
        }
    </script>

</div>

<!-- Photographer Table -->
<table class="table table-striped" id="photographerTable">
    <thead>
    <tr>
        <th>Name</th>
        <th onclick="sortTable(1)" style="cursor:pointer;">Rating </th>
        <th onclick="sortTable(2)" style="cursor:pointer;">Price ($) </th>
        <th>Event Type</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Photographer> photographers = (List<Photographer>) request.getAttribute("photographers");
        if (photographers != null && !photographers.isEmpty()) {
            for (Photographer p : photographers) {
    %>
    <tr>
        <td><%= p.getName() %></td>
        <td><%= p.getRating() %></td>
        <td><%= p.getPrice() %></td>
        <td><%= p.getEventType() %></td>
    </tr>
    <%
        }
    }
    %>
    </tbody>
</table>
</body>
</html>