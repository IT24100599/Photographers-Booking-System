package com.photographerMgr.servlets;

import com.photographerMgr.models.Photographer;
import com.photographerMgr.services.ShowPhotographers;

import java.util.List;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import java.io.BufferedReader;
import com.google.gson.JsonObject;

@WebServlet(urlPatterns = {"/showPhotographers"})
public class ShowPhotographersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException , IOException {
		try {
			BufferedReader reader = request.getReader();
	        StringBuilder buffer = new StringBuilder();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            buffer.append(line);
	        }
	        
	        // Parse JSON using Gson (you already have this imported)
	        Gson gson = new Gson();
	        JsonObject jsonObject = gson.fromJson(buffer.toString(), JsonObject.class);
	        
	        // Get the rating parameter directly as string
	        String rating = "default"; // Default value
	        if (jsonObject.has("rating")) {
	            rating = jsonObject.get("rating").getAsString();
	        }
			
			// Get the photographer list from the request
			// Assuming you have a method to fetch the photographer list
			List<Photographer> photographerList = ShowPhotographers.getPhotographerList(rating);
			
			// Set the photographer list as an attribute in the request
			response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");

	        // Convert to JSON and write directly to response
	        String json = gson.toJson(photographerList);
	        response.getWriter().write(json);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("{\"error\": \"Failed to fetch photographers\"}");
		}
	}	

}
