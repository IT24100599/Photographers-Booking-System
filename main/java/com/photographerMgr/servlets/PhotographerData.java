package com.photographerMgr.servlets;

import com.photographerMgr.models.Photographer;
import com.photographerMgr.services.PhotographerDataProcessor;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PhotographerData")
public class PhotographerData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String username = request.getParameter("targetName");
			
			 if (username == null || username.trim().isEmpty()) {
				 		            System.out.println("Username is required");
		            request.setAttribute("errorMessage", "Username is required");
		            request.getRequestDispatcher("findPhotographers.jsp").forward(request, response);
		            return;
		     }
			 
			 PhotographerDataProcessor processor = new PhotographerDataProcessor();
			 
			 Photographer photographer = processor.getPhotographerByUsername(username);
			 
			 
			 if (photographer != null) {
				 System.out.println("Photographer found: " + photographer.getUsername());
				 request.setAttribute("selectedPhotographer", photographer);
				 request.getRequestDispatcher("photographerDetails.jsp").forward(request, response);
			 } else {
				 System.out.println("Photographer not found");
				 request.setAttribute("errorMessage", "Photographer not found");
				 request.getRequestDispatcher("findPhotographers.jsp").forward(request, response);
			 }
			 
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error occurred while retrieving photographer data: " + e.getMessage());
			request.setAttribute("errorMessage", "An error occurred while processing the request.");
			request.getRequestDispatcher("findPhotographers.jsp").forward(request, response);
		}
		 
	}

}
