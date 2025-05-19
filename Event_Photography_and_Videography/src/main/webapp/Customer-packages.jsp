<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 18/05/2025
  Time: 12:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Our Photography Packages</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .package-card {
      transition: transform 0.3s;
      height: 100%;
    }
    .package-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .highlight-card {
      border: 2px solid #ffc107;
    }
    .card-header {
      background-color: #343a40 !important;
    }
  </style>
</head>
<body>
<div class="container py-5">
  <h1 class="text-center mb-5">Our Photography Packages</h1>

  <div class="row">
    <c:forEach items="${packages}" var="pkg">
      <div class="col-md-4 mb-4">
        <div class="card package-card ${pkg.packageName eq 'Gold' ? 'highlight-card' : ''}">
          <div class="card-header text-white">
            <h3 class="text-center">${pkg.packageName} Package</h3>
          </div>
          <div class="card-body">
            <h4 class="card-title text-center text-primary">$${pkg.price}</h4>
            <p class="card-text">${pkg.description}</p>
            <ul class="list-group list-group-flush mb-3">
              <li class="list-group-item">
                <strong>Hours Coverage:</strong> ${pkg.hoursCoverage} hours
              </li>
              <li class="list-group-item">
                <strong>Photographers:</strong> ${pkg.photographers}
              </li>
              <li class="list-group-item">
                <strong>Photo Editing:</strong>
                  ${pkg.editingEnabled ? 'Included' : 'Not included'}
              </li>
              <li class="list-group-item">
                <strong>Videography:</strong>
                  ${pkg.videoIncluded ? 'Included' : 'Not included'}
              </li>
            </ul>
          </div>
          <div class="card-footer text-center">
            <a href="#" class="btn btn-primary">Book Now</a>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
</body>
</html>