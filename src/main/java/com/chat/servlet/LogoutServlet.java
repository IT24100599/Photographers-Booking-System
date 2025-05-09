package com.chat.servlet;

import com.chat.dao.UserStatusDAO;
import com.chat.model.Chat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling user logout
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Set user status to offline
            Chat user = (Chat) session.getAttribute("chat");
            if (user != null) {
                System.out.println("Chat logging out: " + user.getUsername());
                
                UserStatusDAO statusDAO = new UserStatusDAO();
                statusDAO.updateUserStatus(user.getId(), "offline");
            }
            
            // Invalidate session
            session.invalidate();
        }
        
        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}