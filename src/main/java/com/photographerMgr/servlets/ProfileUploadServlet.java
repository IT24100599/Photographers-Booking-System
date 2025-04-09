package com.photographerMgr.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import java.nio.file.*;

@WebServlet("/uploadProfilePic")
@MultipartConfig
public class ProfileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String UPLOAD_DIR = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\PhotographerProfilePics\\";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get username parameter
        String username = request.getParameter("targetName");
        
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("message", "Username is required");
            request.getRequestDispatcher("/photographer.jsp").forward(request, response);
            return;
        }
        
        // Sanitize username to remove any characters that might cause directory traversal
        username = username.replaceAll("[^a-zA-Z0-9]", "_");
        
        // Create the directory path
        String uploadPath = UPLOAD_DIR + username+ "/";
        
        // Create directories if they don't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Get the file part
        Part filePart = request.getPart("profilePic");
        
        if (filePart != null && filePart.getSize() > 0) {
            // Get file name
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // If no file extension, default to .jpg
            if (!fileName.contains(".")) {
                fileName += ".jpg";
            }
            
            // Always save as profile.jpg (or whatever extension the file has)
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String targetFileName = "profile" + fileExtension;
            
            if(!uploadDir.exists())  {
            	for(File file : uploadDir.listFiles()) {
            		file.delete();
            	}
            }
            
            // Save the file
            filePart.write(uploadPath + targetFileName);
            
            request.setAttribute("message", "Profile picture uploaded successfully for " + username);
        } else {
            request.setAttribute("message", "No file selected or file is empty");
        }
        
        request.getRequestDispatcher("/photographer.jsp").forward(request, response);
    }
}