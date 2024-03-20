package com.vishal.controllers;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.vishal.model.DAO;

/**
 * Servlet implementation class AdminLogin
 */
@MultipartConfig
@WebServlet("/AddGadget")
public class AddGadget extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {

			String name=request.getParameter("name");
			String brand_name=request.getParameter("brand_name");
			String problem=request.getParameter("problem");
			Part part=request.getPart("photo");
			InputStream photo=part.getInputStream();
			
            DAO db=new DAO();
            db.addGadget(name,brand_name,problem,photo);
            db.closeConnection();
            HttpSession session=request.getSession();
        
           session.setAttribute("msg", "Gadget Repair Request Send Successfully....!");
           response.sendRedirect("UserHome.jsp");
         }
		
		catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
			
		}
	}

}
