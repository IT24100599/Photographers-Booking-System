package com.admin.servlet;

import com.admin.model.User;
import com.admin.util.FileHandler;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("list".equals(action)) {
            List<User> users = FileHandler.loadUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("users.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            String userId = request.getParameter("userId");
            String status = request.getParameter("status");
            
            List<User> users = FileHandler.loadUsers();
            for (User user : users) {
                if (user.getUserId().equals(userId)) {
                    user.setStatus(status);
                    break;
                }
            }
            
            // Save updated users
            FileHandler.saveUsers(users);
            response.sendRedirect("users.jsp");
        }
    }
} 