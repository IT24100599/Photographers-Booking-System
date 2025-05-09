package com.chat.filter;

import com.chat.model.Chat;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter to check if user is authenticated
 */
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get current user session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if session exists and user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("chat") != null);
        
        // Allow access to login and register pages regardless of login status
        String requestURI = httpRequest.getRequestURI();
        boolean isLoginPage = requestURI.endsWith("login.jsp") || requestURI.endsWith("/login");
        boolean isRegisterPage = requestURI.endsWith("register.jsp") || requestURI.endsWith("/register");
        boolean isPublicResource = isLoginPage || isRegisterPage || 
                                  requestURI.contains("/css/") || 
                                  requestURI.contains("/js/") || 
                                  requestURI.contains("/images/");
        
        if (isLoggedIn || isPublicResource) {
            // If user is logged in or accessing public resource, proceed with the request
            chain.doFilter(request, response);
        } else {
            // If not authenticated, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup code
    }
}