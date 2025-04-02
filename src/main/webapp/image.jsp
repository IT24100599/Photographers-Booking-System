<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Image Upload and Display</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            display: flex;
            flex-direction: column;
            max-width: 800px;
            margin: 0 auto;
        }
        .upload-section, .display-section {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .upload-section {
            background-color: #f9f9f9;
        }
        .display-section {
            background-color: #f0f0f0;
        }
        .image-container {
            margin-top: 20px;
            text-align: center;
        }
        .uploaded-image {
            max-width: 100%;
            max-height: 400px;
            border: 2px solid #ccc;
            border-radius: 5px;
        }
        .message {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        input[type="file"] {
            margin: 10px 0;
        }
        input[type="submit"] {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Image Upload and Display</h1>
        
        <!-- Upload Section -->
        <div class="upload-section">
            <h2>Upload New Image</h2>
            
            <% if (request.getAttribute("message") != null) { %>
                <p class="message"><%= request.getAttribute("message") %></p>
            <% } %>
            
            <% if (request.getAttribute("error") != null) { %>
                <p class="error"><%= request.getAttribute("error") %></p>
            <% } %>
            
            <form action="<%= request.getContextPath() %>/image" method="post" enctype="multipart/form-data">
                <input type="hidden" name="userId" value="<%= session.getAttribute("userId") != null ? session.getAttribute("userId") : "Saviru" %>">
                <label for="imageFile">Select Image:</label><br>
                <input type="file" name="imageFile" id="imageFile" accept="image/*" required><br>
                <input type="submit" value="Upload Image">
            </form>
        </div>
        
        <!-- Display Section -->
        <div class="display-section">
            <h2>Current Image</h2>
            
            <div class="image-container">
                <%
                    String uploadedImage = (String) session.getAttribute("uploadedImage");
                    String imageSrc;
                    
                    if (uploadedImage != null) {
                        imageSrc = request.getContextPath() + "/image?file=" + uploadedImage;
                    } else {
                        // Default image if none uploaded
                        imageSrc = request.getContextPath() + "/image?file=default.png";
                    }
                %>
                <img src="<%= imageSrc %>" alt="Uploaded Image" class="uploaded-image"
                     onerror="this.src='<%= request.getContextPath() %>/image?file=default.png'">
                
                <% if (uploadedImage != null) { %>
                    <p>Uploaded image: <%= uploadedImage %></p>
                <% } else { %>
                    <p>No image uploaded yet. Default image is displayed.</p>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>