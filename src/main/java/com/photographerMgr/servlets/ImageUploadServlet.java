package com.photographerMgr.servlets;

import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


import com.photographerMgr.models.Photographer;

@WebServlet(urlPatterns = {"/upload"})
@MultipartConfig(
    fileSizeThreshold = 2 * 1024 * 1024,  // 2MB
    maxFileSize = 10 * 1024 * 1024,       // 10MB
    maxRequestSize = 20 * 1024 * 1024     // 20MB
)
public class ImageUploadServlet extends HttpServlet {
    
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
        String userDirectory = BASE_UPLOAD_DIRECTORY + username + "\\";
        
        // Ensure the directory exists
        ensureDirectoryExists(userDirectory);
        
        return userDirectory;
    }
    
    // Method to get user-specific data file path
    private String getUserDataFilePath(HttpServletRequest request) {
        return getUserUploadDirectory(request) + DATA_FILE_NAME;
    }
    
    // Ensure the directory exists - create it if it doesn't
    private void ensureDirectoryExists(String directoryPath) {
        File directory = new File(directoryPath);
        if (!directory.exists()) {
            boolean created = directory.mkdirs();
            if (created) {
                getServletContext().log("Created directory: " + directoryPath);
            } else {
                getServletContext().log("Failed to create directory: " + directoryPath);
            }
        }
    }
    
    @Override
    public void init() throws ServletException {
        // Ensure base upload directory exists
        ensureDirectoryExists(BASE_UPLOAD_DIRECTORY);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            // Get user-specific data file
            String dataFilePath = getUserDataFilePath(request);
            
            // Return a list of all uploaded images as JSON
            List<ImageData> images = readImageData(dataFilePath);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            
            // Simple JSON formatting
            out.println("[");
            for (int i = 0; i < images.size(); i++) {
                ImageData image = images.get(i);
                out.println("  {");
                out.println("    \"title\": \"" + escapeJson(image.getTitle()) + "\",");
                out.println("    \"fileName\": \"" + escapeJson(image.getFileName()) + "\",");
                out.println("    \"timestamp\": " + image.getTimestamp());
                out.println("  }" + (i < images.size() - 1 ? "," : ""));
            }
            out.println("]");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get user-specific upload directory and data file
        String uploadDirectory = getUserUploadDirectory(request);
        String dataFilePath = getUserDataFilePath(request);
        
        // Log the paths for debugging
        getServletContext().log("Using upload directory: " + uploadDirectory);
        getServletContext().log("Using data file: " + dataFilePath);
        
        // Check if the request is multipart
        if (!request.getContentType().toLowerCase().startsWith("multipart/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Form must be multipart/form-data");
            return;
        }
        
        // Get form fields
        Part filePart = request.getPart("image");
        String title = request.getParameter("title");
        
        if (filePart == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No file uploaded");
            return;
        }
        
        // Extract file information
        String originalFileName = getSubmittedFileName(filePart);
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        
        // Create a unique file name to prevent overwriting
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        String filePath = uploadDirectory + uniqueFileName;
        
        // Save the file
        try (InputStream fileContent = filePart.getInputStream();
             OutputStream out = new FileOutputStream(filePath)) {
            
            byte[] buffer = new byte[1024];
            int length;
            while ((length = fileContent.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
        
        // Save metadata to text file
        saveImageData(title, uniqueFileName, dataFilePath);
        
        // Redirect back to the main page
        response.sendRedirect("portfolio.jsp");
    }
    
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown";
    }
    
    private synchronized void saveImageData(String title, String fileName, String dataFilePath) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(dataFilePath, true))) {
            writer.println(title + "|" + fileName + "|" + System.currentTimeMillis());
        } catch (IOException e) {
            getServletContext().log("Error saving image metadata", e);
        }
    }
    
    private List<ImageData> readImageData(String dataFilePath) {
        List<ImageData> images = new ArrayList<>();
        
        File dataFile = new File(dataFilePath);
        if (!dataFile.exists()) {
            return images;
        }
        
        try (BufferedReader reader = new BufferedReader(new FileReader(dataFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 3) {
                    // Format: title|fileName|timestamp
                    ImageData image = new ImageData();
                    image.setTitle(parts[0]);
                    image.setFileName(parts[1]);
                    try {
                        image.setTimestamp(Long.parseLong(parts[2]));
                    } catch (NumberFormatException e) {
                        continue;
                    }
                    images.add(image);
                }
            }
        } catch (IOException e) {
            getServletContext().log("Error reading image metadata", e);
        }
        
        // Sort by timestamp (newest first)
        Collections.sort(images, (a, b) -> Long.compare(b.getTimestamp(), a.getTimestamp()));
        
        return images;
    }
    
    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
    
    // Inner class to represent image metadata
    private static class ImageData {
        private String title;
        private String fileName;
        private long timestamp;
        
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        
        public String getFileName() { return fileName; }
        public void setFileName(String fileName) { this.fileName = fileName; }
        
        public long getTimestamp() { return timestamp; }
        public void setTimestamp(long timestamp) { this.timestamp = timestamp; }
    }
}