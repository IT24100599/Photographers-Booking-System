package com.photographerMgr.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;


@WebServlet("/displayProfilePic")
public class ProfileDisplayServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String UPLOAD_DIR = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\PhotographerProfilePics\\";
    private static final String DEFAULT_PROFILE = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\assets\\defaults\\defualt.png";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("targetName");
        
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username is required");
            request.getRequestDispatcher("/photographer.jsp").forward(request, response);
            return;
        }
        
        username = username.replaceAll("[^a-zA-Z0-9]", "_");
        
       
        String uploadPath = UPLOAD_DIR + username+"\\";
        
        File dir = new File(uploadPath);
        
        
        
        File profilePic = null;
        
        System.out.println("directory exists: " + dir.exists());
        System.out.println("directory is a directory: " + dir.isDirectory());
        
        if (dir.exists() && dir.isDirectory()) {
            for (File file : dir.listFiles()) {
            	
            	System.out.println("File name: " + file.getName());
                if (file.getName().startsWith("profile.")) {
                    profilePic = file;
                    
                    System.out.println("Found profile picture: " + file.getName());
                    break;
                }
            }
        }
        
        System.out.println("Profile picture path: " + uploadPath);
        
        if (profilePic == null) {
            profilePic = new File(DEFAULT_PROFILE);
        }
        

        String fileName = profilePic.getName();
        String contentType = "image/jpeg";
        
        if (fileName.endsWith(".png")) {
            contentType = "image/png";
        } else if (fileName.endsWith(".gif")) {
            contentType = "image/gif";
        } else if (fileName.endsWith(".bmp")) {
            contentType = "image/bmp";
        }
        
        response.setContentType(contentType);
        
        try (FileInputStream in = new FileInputStream(profilePic);
             OutputStream out = response.getOutputStream()) {
            
        	
        	
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}