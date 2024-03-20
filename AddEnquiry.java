package com.vishal.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vishal.model.DAO;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AddEnquiry")
public class AddEnquiry extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
		try {
         DAO db=new DAO();
         db.addEnquiry(name, phone);
         db.closeConnection();
         HttpSession session=request.getSession();
        
         session.setAttribute("msg", "Thanks For Contact us.. We will contact you soon...!");
         response.sendRedirect("index.jsp");
         }
		
		catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
			
		}
	}

}
