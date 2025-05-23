package com.photographerMgr.servlets;

import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.photographerMgr.models.Photographer;

@WebServlet(urlPatterns = {"/delete"})
public class ImageDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String BASE_UPLOAD_DIRECTORY = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\photographerSamples\\";
    private static final String DATA_FILE_NAME = "image-data.txt";
    
    private String getUserUploadDirectory(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Photographer photographer = (Photographer)session.getAttribute("photographer");
        
        String username = "default";
        
        if (photographer != null && photographer.getUsername() != null) {
            username = photographer.getUsername();
        }
        

        return BASE_UPLOAD_DIRECTORY + username + "\\";
    }
    
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
        
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid file name");
            return;
        }
        

        String uploadDirectory = getUserUploadDirectory(request);
        String dataFilePath = getUserDataFilePath(request);
        
        File file = new File(uploadDirectory + fileName);
        if (file.exists()) {
            file.delete();
        }
        
        
        
        removeImageFromDataFile(fileName, dataFilePath);
        response.sendRedirect("portfolio.jsp");
    }
    
    private boolean removeImageFromDataFile(String fileName, String dataFilePath) {
        File dataFile = new File(dataFilePath);
        if (!dataFile.exists()) {
            return false;
        }
        
        List<String> lines = new ArrayList<>();
        
        try {
            try (BufferedReader reader = new BufferedReader(new FileReader(dataFilePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 2 && !parts[1].equals(fileName)) {
                        lines.add(line);
                    }
                }
            }
            
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