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
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		try {
         DAO db=new DAO();
         String name=db.adminLogin(id, password);
         db.closeConnection();
         HttpSession session=request.getSession();
         if(name==null) {
        	 session.setAttribute("msg", "Invalid Entries!");
        	 response.sendRedirect("index.jsp");
         }else {
        	 session.setAttribute("admin_name", name);
        	 response.sendRedirect("AdminHome.jsp");
         }
		}
		catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
			
		}
	}

}
