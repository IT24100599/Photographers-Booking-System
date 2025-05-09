package com.chat.servlet;

import com.chat.dao.MessageDAO;
import com.chat.dao.UserDAO;
import com.chat.model.Chat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/getUnreadCounts")
public class GetUnreadCountsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("chat") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{}");
                return;
            }
            
            Chat currentUser = (Chat) session.getAttribute("chat");
            UserDAO userDAO = new UserDAO();
            MessageDAO messageDAO = new MessageDAO();
            List<Chat> users = userDAO.getAllUsers();
            
            // Build response
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{");
            
            boolean firstUser = true;
            for (Chat user : users) {
                if (user.getId() != currentUser.getId()) {
                    if (!firstUser) {
                        jsonBuilder.append(",");
                    }
                    
                    int unreadCount = messageDAO.countUnreadMessages(user.getId(), currentUser.getId());
                    jsonBuilder.append("\"").append(user.getId()).append("\":").append(unreadCount);
                    
                    firstUser = false;
                }
            }
            
            jsonBuilder.append("}");
            out.print(jsonBuilder.toString());
            
        } catch (Exception e) {
            System.err.println("Error in GetUnreadCountsServlet: " + e.getMessage());
            e.printStackTrace();
            out.print("{}");
        } finally {
            out.flush();
            out.close();
        }
    }
}