package com.photographerMgr.servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chat.dao.UserDAO;
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
        
        if (!currentPhotographer.getUsername().equals(username)) {
            request.setAttribute("error", "Invalid user verification.");
            request.getRequestDispatcher("photographer.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        
        PhotographerDeletionManager deletionManager = new PhotographerDeletionManager();
        
        boolean userDel = deletionManager.deletePhotographerProfile(username);
        

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
        
        boolean chatDel = userDAO.deleteUserByUsername(username);
        
        boolean success = userDel && chatDel;
        
        if (success) {
            session.invalidate();
            response.sendRedirect("index.jsp");
        } else if (!userDel && chatDel) {
			request.setAttribute("error", "User deleted from chat but failed to delete user profile from database. Please try again.");
			request.getRequestDispatcher("customer.jsp").forward(request, response);
		} else if (!chatDel && userDel) {
			request.setAttribute("error", "User deleted from database but failed to delete user from chat. Please contact support.");
			request.getRequestDispatcher("customer.jsp").forward(request, response);
    	} else {
            request.setAttribute("error", "Failed to delete user profile. Try again or contact support.");
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }
    }
}