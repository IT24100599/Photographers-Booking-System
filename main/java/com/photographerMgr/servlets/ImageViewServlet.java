package com.photographerMgr.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.photographerMgr.models.Photographer;

@WebServlet(urlPatterns = {"/view"})
public class ImageViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String BASE_UPLOAD_DIRECTORY = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\photographerSamples\\";
    
    private String getUserUploadDirectory(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Photographer photographer = (Photographer)session.getAttribute("photographer");
        
        String username = "default";
        
        if (photographer != null && photographer.getUsername() != null) {
            username = photographer.getUsername();
        }
        

        return BASE_UPLOAD_DIRECTORY + username + "\\";
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fileName = request.getParameter("file");
        
        String action = request.getParameter("action");
        
        String uploadDirectory;
        
        if (fileName == null || fileName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is required");
            return;
        }
        
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid file name");
            return;
        }
        
        if("target".equals(action)) {
			String targetName = request.getParameter("targetName");
			if (targetName == null || targetName.trim().isEmpty()) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Target name is required");
				return;
			}
			
			uploadDirectory = BASE_UPLOAD_DIRECTORY + targetName + "\\";
			
		} else {
			uploadDirectory = getUserUploadDirectory(request);
		}
        
        
        String filePath = uploadDirectory + fileName;
        
        File file = new File(filePath);
        
        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }
        
        String contentType = getServletContext().getMimeType(fileName);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        
        response.setContentType(contentType);
        response.setContentLength((int) file.length());
      
        response.setHeader("Cache-Control", "public, max-age=86400");
        

        try (FileInputStream in = new FileInputStream(filePath);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}