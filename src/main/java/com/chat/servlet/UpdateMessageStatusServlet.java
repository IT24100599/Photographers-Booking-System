package com.chat.servlet;

import com.chat.dao.MessageDAO;
import com.chat.model.Chat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/updateMessageStatus")
public class UpdateMessageStatusServlet extends HttpServlet {
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
            String messageIdParam = request.getParameter("messageId");
            String status = request.getParameter("status");
            
            if (messageIdParam == null || status == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"error\": \"Missing required parameters\"}");
                return;
            }
            
            int messageId = Integer.parseInt(messageIdParam);
            
            // Validate status value
            if (!status.equals("delivered") && !status.equals("read")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"error\": \"Invalid status value\"}");
                return;
            }
            
            MessageDAO messageDAO = new MessageDAO();
            boolean updated = messageDAO.updateMessageStatus(messageId, status);
            
            if (updated) {
                out.print("{\"success\": true}");
                System.out.println("Message status updated: ID=" + messageId + ", status=" + status + 
                                  ", by user=" + currentUser.getUsername());
            } else {
                out.print("{\"success\": false, \"error\": \"Failed to update message status\"}");
            }
            
        } catch (Exception e) {
            System.err.println("UpdateMessageStatusServlet Error: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
    
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