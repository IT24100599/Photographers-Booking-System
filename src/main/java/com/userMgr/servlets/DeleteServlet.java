package com.userMgr.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.userMgr.models.User;
import com.userMgr.services.UserDeletionManager;

import com.chat.dao.UserDAO;

public class DeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("customer-login.jsp");
            return;
        }
        
        String username = request.getParameter("originalUsername");
        
        
        System.out.println("UN: "+username);
        System.out.println("CU: "+currentUser.getUsername());
     
        
        // Validate that the username from the form matches the logged-in user
        if (!currentUser.getUsername().equals(username)) {
            request.setAttribute("error", "Failed to delete user profile : Invalid user verification.");
            request.getRequestDispatcher("customer.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        
        // Delete the user profile
        UserDeletionManager deletionManager = new UserDeletionManager();
        boolean userDel = deletionManager.deleteUserProfile(username);
        boolean chatDel = userDAO.deleteUserByUsername(username);
        
        boolean success = userDel && chatDel;
        
        if (success) {
            // Invalidate session and redirect to a confirmation page
            session.invalidate();
            response.sendRedirect("index.jsp");
        } else if (!userDel && chatDel) {
			// Redirect to error page
			request.setAttribute("error", "User deleted from chat but failed to delete user profile from database. Please try again.");
			request.getRequestDispatcher("customer.jsp").forward(request, response);
		} else if (!chatDel && userDel) {
			// Redirect to error page
			request.setAttribute("error", "User deleted from database but failed to delete user from chat. Please contact support.");
			request.getRequestDispatcher("customer.jsp").forward(request, response);
    	} else {
            // Redirect to error page
            request.setAttribute("error", "Failed to delete user profile. Try again or contact support.");
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }
    }
}