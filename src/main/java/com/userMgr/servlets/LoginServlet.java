package com.userMgr.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.userMgr.models.User;
import com.userMgr.services.UserDataProcessor;

//Chat
import com.chat.dao.UserDAO;
import com.chat.dao.UserStatusDAO;
import com.chat.model.Chat;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdentifier = request.getParameter("userIdentifier");
        String password = request.getParameter("password");
        
        UserDataProcessor processor = new UserDataProcessor();
        User user = processor.authenticateUser(userIdentifier, password);
        
        UserDAO userDAO = new UserDAO();
        Chat client = userDAO.getUserByUsername(userIdentifier);

        UserStatusDAO statusDAO = new UserStatusDAO();
        statusDAO.updateUserStatus(client.getId(), "online");
        
        
        if (user != null) {
            // Successful login
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("chat", client);
            
            response.sendRedirect("customer.jsp");
        } else {
            // Failed login
            request.setAttribute("error", "Invalid username/email or password");
            request.getRequestDispatcher("customer-login.jsp").forward(request, response);
        }
    }
}