package com.userMgr.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import java.nio.file.*;

@WebServlet("/uploadProfilePicUSER")
@MultipartConfig
public class ProfileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String UPLOAD_DIR = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\UserProfilePics\\";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("targetName");
        
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("message", "Username is required");
            request.getRequestDispatcher("/customer.jsp").forward(request, response);
            return;
        }
        
        username = username.replaceAll("[^a-zA-Z0-9]", "_");
        
        
        String uploadPath = UPLOAD_DIR + username+ "/";
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        Part filePart = request.getPart("profilePic");
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            if (!fileName.contains(".")) {
                fileName += ".jpg";
            }
            

            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String targetFileName = "profile" + fileExtension;
            
            if(!uploadDir.exists())  {
            	for(File file : uploadDir.listFiles()) {
            		file.delete();
            	}
            }
            
            filePart.write(uploadPath + targetFileName);
            
            request.setAttribute("message", "Profile picture uploaded successfully for " + username);
        } else {
            request.setAttribute("message", "No file selected or file is empty");
        }
        
        request.getRequestDispatcher("/customer.jsp").forward(request, response);
    }
}