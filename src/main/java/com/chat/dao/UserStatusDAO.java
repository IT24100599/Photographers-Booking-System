package com.chat.dao;

import com.chat.model.UserStatus;
import com.chat.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserStatusDAO {
    
    /**
     * Gets the status of a user
     * @param userId the user ID
     * @return the user's status or null if not found
     */
    public UserStatus getUserStatus(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            
            String sql = "SELECT * FROM user_statuses WHERE user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                UserStatus userStatus = new UserStatus();
                userStatus.setId(rs.getInt("id"));
                userStatus.setUserId(rs.getInt("user_id"));
                userStatus.setStatus(rs.getString("status"));
                userStatus.setLastUpdated(rs.getTimestamp("last_updated"));
                
                return userStatus;
            }
            
            return null;
            
        } catch (SQLException e) {
            System.err.println("Error getting user status: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Updates a user's status
     * @param userId the user ID
     * @param status the new status
     * @return true if update was successful
     */
    public boolean updateUserStatus(int userId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            
            // Check if status exists
            String checkSql = "SELECT id FROM user_statuses WHERE user_id = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            boolean exists = rs.next();
            DBUtil.closeResources(null, stmt, rs);
            
            if (exists) {
                // Update existing status
                String updateSql = "UPDATE user_statuses SET status = ?, last_updated = ? WHERE user_id = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, status);
                stmt.setTimestamp(2, new Timestamp(new Date().getTime()));
                stmt.setInt(3, userId);
                
                return stmt.executeUpdate() > 0;
            } else {
                // Insert new status
                String insertSql = "INSERT INTO user_statuses (user_id, status, last_updated) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setInt(1, userId);
                stmt.setString(2, status);
                stmt.setTimestamp(3, new Timestamp(new Date().getTime()));
                
                return stmt.executeUpdate() > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error updating user status: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Gets all user statuses
     * @return list of all user statuses
     */
    public List<UserStatus> getAllUserStatuses() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<UserStatus> userStatuses = new ArrayList<>();
        
        try {
            conn = DBUtil.getConnection();
            
            String sql = "SELECT * FROM user_statuses";
            stmt = conn.prepareStatement(sql);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                UserStatus userStatus = new UserStatus();
                userStatus.setId(rs.getInt("id"));
                userStatus.setUserId(rs.getInt("user_id"));
                userStatus.setStatus(rs.getString("status"));
                userStatus.setLastUpdated(rs.getTimestamp("last_updated"));
                
                userStatuses.add(userStatus);
            }
            
            return userStatuses;
            
        } catch (SQLException e) {
            System.err.println("Error getting all user statuses: " + e.getMessage());
            e.printStackTrace();
            return userStatuses;
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
    }
}