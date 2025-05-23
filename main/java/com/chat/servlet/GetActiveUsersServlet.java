package com.chat.servlet;

import com.chat.dao.UserDAO;
import com.chat.dao.UserStatusDAO;
import com.chat.model.Chat;
import com.chat.model.UserStatus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet for getting active users and their statuses
 */
@WebServlet("/getActiveUsers")
public class GetActiveUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            System.out.println("GetActiveUsersServlet: Chat " + currentUser.getUsername() + 
                              " (ID: " + currentUser.getId() + ") retrieving active users");
            
            UserDAO userDAO = new UserDAO();
            UserStatusDAO statusDAO = new UserStatusDAO();
            
            List<Chat> users = userDAO.getAllUsers();
            List<UserStatus> allStatuses = statusDAO.getAllUserStatuses();
            
            // Create a map of user IDs to statuses
            Map<Integer, String> userStatuses = new HashMap<>();
            Map<Integer, Date> lastUpdated = new HashMap<>();
            
            for (UserStatus status : allStatuses) {
                userStatuses.put(status.getUserId(), status.getStatus());
                lastUpdated.put(status.getUserId(), status.getLastUpdated());
            }
            
            // Count online users
            int onlineCount = 0;
            for (String status : userStatuses.values()) {
                if ("online".equals(status)) {
                    onlineCount++;
                }
            }
            
            // Format for timestamps
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
            // Get current date/time for logging
            String currentDateTime = dateFormat.format(new Date());
            System.out.println("GetActiveUsersServlet: Retrieved " + users.size() + 
                              " users, " + onlineCount + " online at " + currentDateTime);
            
            // Build the JSON response
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{");
            jsonBuilder.append("\"success\": true,");
            jsonBuilder.append("\"timestamp\": \"").append(currentDateTime).append("\",");
            jsonBuilder.append("\"onlineCount\": ").append(onlineCount).append(",");
            jsonBuilder.append("\"users\": [");
            
            for (int i = 0; i < users.size(); i++) {
                Chat user = users.get(i);
                String status = userStatuses.getOrDefault(user.getId(), "offline");
                Date statusUpdated = lastUpdated.get(user.getId());
                String formattedLastUpdated = statusUpdated != null ? dateFormat.format(statusUpdated) : "";
                
                jsonBuilder.append("{");
                jsonBuilder.append("\"id\": ").append(user.getId()).append(",");
                jsonBuilder.append("\"username\": \"").append(escapeJson(user.getUsername())).append("\",");
                jsonBuilder.append("\"status\": \"").append(status).append("\",");
                jsonBuilder.append("\"lastUpdated\": \"").append(formattedLastUpdated).append("\"");
                jsonBuilder.append("}");
                
                if (i < users.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]");
            jsonBuilder.append("}");
            
            out.print(jsonBuilder.toString());
            
        } catch (Exception e) {
            System.err.println("GetActiveUsersServlet Error: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
    
    /**
     * Escapes special characters in strings for JSON output
     * @param str the string to escape
     * @return the escaped string
     */
    private String escapeJson(String str) {
        if (str == null) {
            return "";
        }
        
        return str.replace("\\", "\\\\")
                 .replace("\"", "\\\"")
                 .replace("\b", "\\b")
                 .replace("\f", "\\f")
                 .replace("\n", "\\n")
                 .replace("\r", "\\r")
                 .replace("\t", "\\t");
    }
}