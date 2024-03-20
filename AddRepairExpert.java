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
@WebServlet("/AddRepairExpert")
public class AddRepairExpert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String email=request.getParameter("email");
			String name=request.getParameter("name");
			String phone=request.getParameter("phone");
			String state=request.getParameter("state");
			String city=request.getParameter("city");
			String sector=request.getParameter("sector");
			Part part=request.getPart("photo");
			InputStream photo=part.getInputStream();
            DAO db=new DAO();
            String result= db.addRepairExpert(email,name,phone,state,city,sector,photo);
            db.closeConnection();
            HttpSession session=request.getSession();
        
           session.setAttribute("msg", result);
           response.sendRedirect("RepairExperts.jsp");
         }
		
		catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExpPage.jsp");
			
		}
	}

}
