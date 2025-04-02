package com.photographerMgr.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photographerMgr.models.Photographer;
import com.photographerMgr.services.PhotographerDataProcessor;

public class PhotographerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdentifier = request.getParameter("userIdentifier");
        String password = request.getParameter("password");
        
        PhotographerDataProcessor processor = new PhotographerDataProcessor();
        Photographer photographer = processor.authenticateUser(userIdentifier, password);
        
        if (photographer != null) {
            // Successful login
            HttpSession session = request.getSession();
            session.setAttribute("photographer", photographer);
            session.setAttribute("loginTime", new java.util.Date());
            
            response.sendRedirect("photographer.jsp");
        } else {
            // Failed login
            request.setAttribute("error", "Invalid username/email or password");
            request.getRequestDispatcher("photographer-login.jsp").forward(request, response);
        }
    }
}