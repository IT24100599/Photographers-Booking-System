package com.chat.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Filter to set character encoding for all requests and responses
 */
public class CharacterEncodingFilter implements Filter {
    
    private String encoding;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Get encoding from filter configuration
        encoding = filterConfig.getInitParameter("encoding");
        if (encoding == null) {
            encoding = "UTF-8"; // Default encoding
        }
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        // Set character encoding for request
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding(encoding);
        }
        
        // Set character encoding for response
        response.setCharacterEncoding(encoding);
        
        // For HTTP responses, set content type
        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            
            // Only set content type if it's not already set
            if (httpResponse.getContentType() == null) {
                if (isJsonRequest(request)) {
                    httpResponse.setContentType("application/json;charset=" + encoding);
                } else {
                    httpResponse.setContentType("text/html;charset=" + encoding);
                }
            }
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }
    
    private boolean isJsonRequest(ServletRequest request) {
        if (request instanceof HttpServletRequest) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            String uri = httpRequest.getRequestURI();
            
            // Check if the request is for a JSON endpoint
            return uri.contains("/getMessages") || 
                   uri.contains("/sendMessage") ||
                   uri.contains("/updateStatus") ||
                   uri.contains("/updateMessageStatus") ||
                   uri.contains("/getActiveUsers") ||
                   uri.contains("/searchMessages");
        }
        return false;
    }
    
    @Override
    public void destroy() {
        // Cleanup code
    }
}