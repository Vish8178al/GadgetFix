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
@WebServlet("/UserSignUp")
public class UserSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
		String password=request.getParameter("password");
		try {
         DAO db=new DAO();
         String msg=db.addUser(email,name,phone,password);
         db.closeConnection();
         HttpSession session=request.getSession();
         if(msg.equalsIgnoreCase("success")) {
         session.setAttribute("user_name", name);
         session.setAttribute("user_email", email);
         response.sendRedirect("User.jsp"); 	 
         }else {
         session.setAttribute("msg",msg);
         response.sendRedirect("User.jsp");
         }
		}
		catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
			
		}
	}

}
