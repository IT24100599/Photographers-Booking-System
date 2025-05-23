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
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/getMessages")
public class GetMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            
            if (session == null || session.getAttribute("chat") == null) {
                System.out.println("GetMessagesServlet: Chat not logged in");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("[]");
                return;
            }
            
            Chat currentUser = (Chat) session.getAttribute("chat");
            String receiverIdParam = request.getParameter("receiverId");
            
            System.out.println("GetMessagesServlet: Chat " + currentUser.getUsername() + 
                               " (ID: " + currentUser.getId() + ") requesting messages with receiverId: " + receiverIdParam);
            
            if (receiverIdParam == null || receiverIdParam.isEmpty()) {
                System.out.println("GetMessagesServlet: Missing receiverId parameter");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("[]");
                return;
            }
            
            int receiverId = Integer.parseInt(receiverIdParam);
            
            MessageDAO messageDAO = new MessageDAO();
            List<Message> messages = messageDAO.getMessagesByUsers(currentUser.getId(), receiverId);
            
            System.out.println("GetMessagesServlet: Found " + messages.size() + " messages");
            
            // Update message statuses safely
            for (Message message : messages) {
                // If the message was sent to the current user and not yet delivered
                if (message.getReceiverId() == currentUser.getId()) {
                    String currentStatus = message.getStatus();
                    // Only update if status is null, empty or 'sent'
                    if (currentStatus == null || currentStatus.isEmpty() || "sent".equals(currentStatus)) {
                        boolean updated = messageDAO.updateMessageStatus(message.getId(), "delivered");
                        if (updated) {
                            message.setStatus("delivered");
                        }
                    }
                }
            }
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");
            
            for (int i = 0; i < messages.size(); i++) {
                Message message = messages.get(i);
                jsonBuilder.append("{");
                jsonBuilder.append("\"id\":").append(message.getId()).append(",");
                jsonBuilder.append("\"senderId\":").append(message.getSenderId()).append(",");
                jsonBuilder.append("\"receiverId\":").append(message.getReceiverId()).append(",");
                jsonBuilder.append("\"content\":\"").append(escapeJson(message.getContent())).append("\",");
                jsonBuilder.append("\"sentTime\":\"").append(dateFormat.format(message.getSentTime())).append("\",");
                jsonBuilder.append("\"isRead\":").append(message.isRead()).append(",");
                
                // Handle null status gracefully
                String status = message.getStatus();
                if (status == null || status.isEmpty()) {
                    status = "sent"; // Default to sent if no status exists
                }
                jsonBuilder.append("\"status\":\"").append(status).append("\",");
                
                // Handle null usernames gracefully
                String senderUsername = message.getSenderUsername();
                if (senderUsername == null) senderUsername = "";
                
                String receiverUsername = message.getReceiverUsername();
                if (receiverUsername == null) receiverUsername = "";
                
                jsonBuilder.append("\"senderUsername\":\"").append(escapeJson(senderUsername)).append("\",");
                jsonBuilder.append("\"receiverUsername\":\"").append(escapeJson(receiverUsername)).append("\"");
                jsonBuilder.append("}");
                
                if (i < messages.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            
            jsonBuilder.append("]");
            out.print(jsonBuilder.toString());
        } catch (Exception e) {
            System.err.println("GetMessagesServlet Error: " + e.getMessage());
            e.printStackTrace();
            // Ensure we return valid JSON even on error
            out.print("[]");
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