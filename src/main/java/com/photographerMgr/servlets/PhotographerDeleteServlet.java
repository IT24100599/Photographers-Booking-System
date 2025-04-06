package com.photographerMgr.servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photographerMgr.models.Photographer;
import com.photographerMgr.services.PhotographerDeletionManager;

public class PhotographerDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "C:\\Users\\savir\\Documents\\Java projects\\photoWeb\\src\\main\\webapp\\WEB-INF\\uploads\\photographerSamples\\";

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Photographer currentPhotographer = (Photographer) session.getAttribute("photographer");
        
        if (currentPhotographer == null) {
            response.sendRedirect("photographer-login.jsp");
            return;
        }
        
        String username = request.getParameter("originalUsername");
        
        // Validate that the username from the form matches the logged-in user
        if (!currentPhotographer.getUsername().equals(username)) {
            request.setAttribute("error", "Invalid user verification.");
            request.getRequestDispatcher("photographer.jsp").forward(request, response);
            return;
        }
        
        // Delete the user profile
        PhotographerDeletionManager deletionManager = new PhotographerDeletionManager();
        boolean success = deletionManager.deletePhotographerProfile(username);
        
        // Delete the user's upload directory
        String userUploadDirectory = UPLOAD_DIRECTORY + username;
        
        try {
			File directory = new File(userUploadDirectory);
			if (directory.exists()) {
				for (File file : directory.listFiles()) {
					file.delete();
				}
				directory.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        if (success) {
            // Invalidate session and redirect to a confirmation page
            session.invalidate();
            response.sendRedirect("photographer-login.jsp");
        } else {
            // Redirect to error page
            request.setAttribute("error", "Failed to delete user profile.");
            request.getRequestDispatcher("photographer.jsp").forward(request, response);
        }
    }
}