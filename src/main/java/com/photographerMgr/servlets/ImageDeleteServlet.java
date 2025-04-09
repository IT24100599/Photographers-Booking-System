package com.photographerMgr.servlets;

import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.photographerMgr.models.Photographer;

@WebServlet(urlPatterns = {"/delete"})
public class ImageDeleteServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Base directory - we'll append the username dynamically
    private static final String BASE_UPLOAD_DIRECTORY = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\photographerSamples\\";
    private static final String DATA_FILE_NAME = "image-data.txt";
    
    // Method to get user-specific upload directory
    private String getUserUploadDirectory(HttpServletRequest request) {
        // Get the session and photographer object
        HttpSession session = request.getSession();
        Photographer photographer = (Photographer)session.getAttribute("photographer");
        
        // Create user-specific directory path
        String username = "default"; // Default fallback
        
        if (photographer != null && photographer.getUsername() != null) {
            username = photographer.getUsername();
        }
        
        // Create the path with the username
        return BASE_UPLOAD_DIRECTORY + username + "\\";
    }
    
    // Method to get user-specific data file path
    private String getUserDataFilePath(HttpServletRequest request) {
        return getUserUploadDirectory(request) + DATA_FILE_NAME;
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fileName = request.getParameter("file");
        
        if (fileName == null || fileName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is required");
            return;
        }
        
        // Security check - prevent directory traversal
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid file name");
            return;
        }
        
        // Get user-specific paths
        String uploadDirectory = getUserUploadDirectory(request);
        String dataFilePath = getUserDataFilePath(request);
        
        // 1. Delete the physical file
        File file = new File(uploadDirectory + fileName);
        if (file.exists()) {
            file.delete();
        }
        
        // 2. Remove the entry from the data file
        removeImageFromDataFile(fileName, dataFilePath);
        
        // Redirect back to the main page
        response.sendRedirect("portfolio.jsp");
    }
    
    private boolean removeImageFromDataFile(String fileName, String dataFilePath) {
        File dataFile = new File(dataFilePath);
        if (!dataFile.exists()) {
            return false;
        }
        
        List<String> lines = new ArrayList<>();
        
        try {
            // Read all lines except the one to delete
            try (BufferedReader reader = new BufferedReader(new FileReader(dataFilePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 2 && !parts[1].equals(fileName)) {
                        lines.add(line);
                    }
                }
            }
            
            // Write the lines back to the file
            try (PrintWriter writer = new PrintWriter(new FileWriter(dataFilePath, false))) {
                for (String line : lines) {
                    writer.println(line);
                }
            }
            
            return true;
        } catch (IOException e) {
            return false;
        }
    }
}