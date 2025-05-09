package com.chat.servlet;

import com.chat.dao.MessageDAO;
import com.chat.model.Message;
import com.chat.model.Chat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {
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
            
            Chat sender = (Chat) session.getAttribute("chat");
            String receiverIdParam = request.getParameter("receiverId");
            String content = request.getParameter("content");
            
            if (receiverIdParam == null || receiverIdParam.isEmpty() || content == null || content.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"error\": \"Missing required parameters\"}");
                return;
            }
            
            int receiverId = Integer.parseInt(receiverIdParam);
            
            // Create a new message with proper status
            Message message = new Message();
            message.setSenderId(sender.getId());
            message.setReceiverId(receiverId);
            message.setContent(content);
            message.setSentTime(new Date());
            message.setRead(false);
            message.setStatus("sent"); // Status is explicitly set to "sent"
            
            MessageDAO messageDAO = new MessageDAO();
            int messageId = messageDAO.saveMessage(message);
            
            if (messageId > 0) {
                // Return success response with message ID
                out.print("{\"success\": true, \"messageId\": " + messageId + "}");
                
                System.out.println("Message sent: ID=" + messageId + 
                                  ", from=" + sender.getUsername() + " (ID: " + sender.getId() + ")" + 
                                  ", to=" + receiverId + 
                                  ", content='" + content + "'");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false, \"error\": \"Failed to save message\"}");
            }
            
        } catch (Exception e) {
            System.err.println("SendMessageServlet Error: " + e.getMessage());
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