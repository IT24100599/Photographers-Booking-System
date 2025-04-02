package com.userMgr.servlets;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.userMgr.models.ImageModel;
import com.userMgr.services.ImageService;

@WebServlet("/image")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1 MB
    maxFileSize = 5 * 1024 * 1024,     // 5 MB
    maxRequestSize = 10 * 1024 * 1024  // 10 MB
)
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ImageService imageService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        imageService = new ImageService();
        imageService.init("");
    }
    
    // Handle file upload
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("userId");
        if (userId == null || userId.isEmpty()) {
            userId = (String) request.getSession().getAttribute("userId");
            if (userId == null) {
                userId = "anonymous";
            }
        }
        
        try {
            // Get the file part from the request
            Part filePart = request.getPart("imageFile");
            
            if (filePart != null && filePart.getSize() > 0) {
                // Get file name
                String fileName = getSubmittedFileName(filePart);
                
                // Read file content
                byte[] fileContent = new byte[(int) filePart.getSize()];
                filePart.getInputStream().read(fileContent);
                
                // Save image
                ImageModel image = imageService.saveImage(
                    "", 
                    userId, 
                    fileName, 
                    fileContent
                );
                
                // Store image info in session for display
                request.getSession().setAttribute("uploadedImage", image.getFilename());
                
                // Set success message
                request.setAttribute("message", "Image uploaded successfully!");
            } else {
                request.setAttribute("error", "Please select an image to upload.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error uploading image: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Redirect back to the JSP page
        request.getRequestDispatcher("image.jsp").forward(request, response);
    }
    
    // Get for displaying images
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fileName = request.getParameter("file");
        
        if (fileName != null && !fileName.isEmpty()) {
            // Get the file
            File file = imageService.getImageFile("", fileName);
            
            // Set content type
            String contentType = getServletContext().getMimeType(file.getName());
            if (contentType == null) {
                contentType = "application/octet-stream";
            }
            
            response.setContentType(contentType);
            response.setContentLength((int) file.length());
            
            // Copy the file to the response output stream
            Files.copy(file.toPath(), response.getOutputStream());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    // Helper method to extract file name from part
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf('=') + 2, item.length() - 1);
            }
        }
        
        return "";
    }
}