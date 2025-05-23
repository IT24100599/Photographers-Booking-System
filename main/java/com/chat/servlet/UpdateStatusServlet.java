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
import java.io.PrintWriter;

/**
 * Servlet for updating user status (online, away, offline)
 */
@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("chat") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\": false, \"error\": \"Not logged in\"}");
                return;
            }
            
            Chat currentUser = (Chat) session.getAttribute("chat");
            String status = request.getParameter("status");
            
            if (status == null || status.trim().isEmpty()) {
                status = "online"; // Default to online
            }
            
            // Validate status
            if (!status.equals("online") && !status.equals("away") && !status.equals("offline")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"error\": \"Invalid status value\"}");
                return;
            }
            
            UserStatusDAO statusDAO = new UserStatusDAO();
            boolean updated = statusDAO.updateUserStatus(currentUser.getId(), status);
            
            if (updated) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"error\": \"Failed to update status\"}");
            }
            
        } catch (Exception e) {
            System.err.println("UpdateStatusServlet Error: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}