package com.chat.dao;

import com.chat.model.Message;
import com.chat.model.Chat;
import com.chat.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MessageDAO {
    
    /**
     * Saves a new message to the database
     * @param message the message to save
     * @return the ID of the saved message, or -1 if failed
     */
    public int saveMessage(Message message) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int generatedId = -1;
        
        try {
            conn = DBUtil.getConnection();
            
            // Include status field in the SQL insert statement
            String sql = "INSERT INTO messages (sender_id, receiver_id, content, sent_time, is_read, status) VALUES (?, ?, ?, ?, ?, ?)";
            
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, message.getSenderId());
            stmt.setInt(2, message.getReceiverId());
            stmt.setString(3, message.getContent());
            stmt.setTimestamp(4, new Timestamp(message.getSentTime().getTime()));
            stmt.setBoolean(5, message.isRead());
            
            // Handle status field - use a default if not set
            String status = message.getStatus();
            if (status == null || status.isEmpty()) {
                status = "sent";
            }
            stmt.setString(6, status);
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
            
            return generatedId;
            
        } catch (SQLException e) {
            System.err.println("Error saving message: " + e.getMessage());
            e.printStackTrace();
            return -1;
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Gets messages between two users
     * @param userId1 first user's ID
     * @param userId2 second user's ID
     * @return list of messages between the users
     */
    public List<Message> getMessagesByUsers(int userId1, int userId2) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Message> messages = new ArrayList<>();
        
        try {
            conn = DBUtil.getConnection();
            
            String sql = "SELECT m.*, " +
                        "sender.username AS sender_username, " +
                        "receiver.username AS receiver_username " +
                        "FROM messages m " +
                        "JOIN users sender ON m.sender_id = sender.id " +
                        "JOIN users receiver ON m.receiver_id = receiver.id " +
                        "WHERE (m.sender_id = ? AND m.receiver_id = ?) " +
                        "OR (m.sender_id = ? AND m.receiver_id = ?) " +
                        "ORDER BY m.sent_time ASC";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            stmt.setInt(3, userId2);
            stmt.setInt(4, userId1);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt("id"));
                message.setSenderId(rs.getInt("sender_id"));
                message.setReceiverId(rs.getInt("receiver_id"));
                message.setContent(rs.getString("content"));
                message.setSentTime(rs.getTimestamp("sent_time"));
                message.setRead(rs.getBoolean("is_read"));
                message.setStatus(rs.getString("status"));
                message.setSenderUsername(rs.getString("sender_username"));
                message.setReceiverUsername(rs.getString("receiver_username"));
                
                messages.add(message);
            }
            
            return messages;
            
        } catch (SQLException e) {
            System.err.println("Error getting messages by users: " + e.getMessage());
            e.printStackTrace();
            return messages;
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Searches for messages containing specific text
     * @param userId1 first user's ID
     * @param userId2 second user's ID
     * @param searchText text to search for
     * @return list of matching messages
     */
    public List<Message> searchMessages(int userId1, int userId2, String searchText) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Message> messages = new ArrayList<>();
        
        try {
            conn = DBUtil.getConnection();
            
            String sql = "SELECT m.*, " +
                        "sender.username AS sender_username, " +
                        "receiver.username AS receiver_username " +
                        "FROM messages m " +
                        "JOIN users sender ON m.sender_id = sender.id " +
                        "JOIN users receiver ON m.receiver_id = receiver.id " +
                        "WHERE ((m.sender_id = ? AND m.receiver_id = ?) " +
                        "OR (m.sender_id = ? AND m.receiver_id = ?)) " +
                        "AND m.content LIKE ? " +
                        "ORDER BY m.sent_time DESC";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            stmt.setInt(3, userId2);
            stmt.setInt(4, userId1);
            stmt.setString(5, "%" + searchText + "%");
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt("id"));
                message.setSenderId(rs.getInt("sender_id"));
                message.setReceiverId(rs.getInt("receiver_id"));
                message.setContent(rs.getString("content"));
                message.setSentTime(rs.getTimestamp("sent_time"));
                message.setRead(rs.getBoolean("is_read"));
                message.setStatus(rs.getString("status"));
                message.setSenderUsername(rs.getString("sender_username"));
                message.setReceiverUsername(rs.getString("receiver_username"));
                
                messages.add(message);
            }
            
            return messages;
            
        } catch (SQLException e) {
            System.err.println("Error searching messages: " + e.getMessage());
            e.printStackTrace();
            return messages;
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Updates the status of a message
     * @param messageId the ID of the message to update
     * @param status the new status (delivered, read)
     * @return true if update was successful
     */
    public boolean updateMessageStatus(int messageId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBUtil.getConnection();
            
            // Use a proper SQL statement based on the status
            String sql;
            if ("read".equals(status)) {
                sql = "UPDATE messages SET status = ?, is_read = TRUE WHERE id = ?";
            } else {
                sql = "UPDATE messages SET status = ? WHERE id = ?";
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, messageId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating message status: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Counts unread messages from a specific sender to a receiver
     * @param senderId the sender's ID
     * @param receiverId the receiver's ID
     * @return count of unread messages
     */
    public int countUnreadMessages(int senderId, int receiverId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DBUtil.getConnection();
            
            String sql = "SELECT COUNT(*) AS unread_count FROM messages " +
                        "WHERE sender_id = ? AND receiver_id = ? AND is_read = FALSE";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt("unread_count");
            }
            
            return count;
            
        } catch (SQLException e) {
            System.err.println("Error counting unread messages: " + e.getMessage());
            e.printStackTrace();
            return 0;
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
    }
    
    public Map<String, Integer> getMessageCountsBetweenUsers(int userId1, int userId2) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Map<String, Integer> counts = new HashMap<>();
        counts.put("sent", 0);
        counts.put("received", 0);
        
        try {
            conn = DBUtil.getConnection();
            
            // Count messages sent from user1 to user2
            String sqlSent = "SELECT COUNT(*) AS sent_count FROM messages WHERE sender_id = ? AND receiver_id = ?";
            stmt = conn.prepareStatement(sqlSent);
            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                counts.put("sent", rs.getInt("sent_count"));
            }
            
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            
            // Count messages received by user1 from user2
            String sqlReceived = "SELECT COUNT(*) AS received_count FROM messages WHERE sender_id = ? AND receiver_id = ?";
            stmt = conn.prepareStatement(sqlReceived);
            stmt.setInt(1, userId2);
            stmt.setInt(2, userId1);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                counts.put("received", rs.getInt("received_count"));
            }
            
            return counts;
            
        } catch (SQLException e) {
            System.err.println("Error counting messages between users: " + e.getMessage());
            e.printStackTrace();
            return counts;
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
    }
}