package com.vishal.model;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;

public class DAO {
 private Connection c;
 
 public DAO() throws Exception{
	 Class.forName("oracle.jdbc.driver.OracleDriver");
	 c=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","gadgetfix","gadgetfix");
 }
 public void closeConnection() throws SQLException{
	 c.close();
 }
 
 public String adminLogin(String id,String password) throws SQLException{
	 PreparedStatement p=c.prepareStatement("select * from admin_login where id=? and password=?");
	 p.setString(1, id);
	 p.setString(2, password);
	 ResultSet rs=p.executeQuery();
	 if(rs.next()) {
		 return rs.getString("name");
	 }
	 else {
		 return null;
	 }
 }
 
 public String repairExpertLogin(String email,String password) throws SQLException{
	 PreparedStatement p=c.prepareStatement("select * from repair_experts where email=? and password=?");
	 p.setString(1, email);
	 p.setString(2, password);
	 ResultSet rs=p.executeQuery();
	 if(rs.next()) {
		 return rs.getString("name");
	 }
	 else {
		 return null;
	 }
 }
 public String userSignIn(String email,String password) throws SQLException{
	 PreparedStatement p=c.prepareStatement("select * from users where email=? and password=?");
	 p.setString(1, email);
	 p.setString(2, password);
	 ResultSet rs=p.executeQuery();
	 if(rs.next()) {
		 return rs.getString("name");
	 }
	 else {
		 return null;
	 }
 }
 
 public void addEnquiry(String name,String phone) throws SQLException{
	 PreparedStatement p=c.prepareStatement("insert into enquiries(name,phone,status,e_date) values(?,?,'Pending',CURRENT_DATE)");
	 p.setString(1, name);
	 p.setString(2, phone);
	 p.executeUpdate();
 }
 public String addUser(String email,String name,String phone,String password) throws SQLException{
	 PreparedStatement p=c.prepareStatement("insert into users(email,name,phone,password) values(?,?,?,?)");
	 p.setString(1, email);
	 p.setString(2, name);
	 p.setString(3, phone);
	 p.setString(4, password);
	 try {
		 p.executeUpdate();
		 return "success";
	 }catch(SQLIntegrityConstraintViolationException e) {
		 return "Email Already Exist...!";
	 }
 }
 
 public String addRepairExpert(String email,String name,String phone,String state,String city,String sector,InputStream photo) throws SQLException{
	 PreparedStatement p=c.prepareStatement("insert into repair_experts(email,name,phone,state,city,sector,photo,status,password) values(?,?,?,?,?,?,?,'Active','password')");
	 p.setString(1, email);
	 p.setString(2, name);
	 p.setString(3, phone);
	 p.setString(4, state);
	 p.setString(5, city);
	 p.setString(6, sector);
	 p.setBinaryStream(7, photo);
	 try {
		 p.executeUpdate();
		 return "Registration Success...!";
	 }catch(SQLIntegrityConstraintViolationException e) {
		 return "Email Already Exist...!";
	 }
	
 }
 public void addGadget(String name,String brand_name,String problem,InputStream photo) throws SQLException{
	 PreparedStatement p=c.prepareStatement("insert into gadgets(name,brand_name,problem,photo,repair_amount,status) values(?,?,?,?,0,'Pending')");
	 p.setString(1, name);
	 p.setString(2, brand_name);
	 p.setString(3, problem);
	 p.setBinaryStream(4, photo);
	
	 p.executeUpdate();	 
 }
 public void changeEnquiryStatus(String phone,String status) throws SQLException{
	 PreparedStatement p=c.prepareStatement("update enquiries set status=? where phone=? ");
	 p.setString(1, status);
	 p.setString(2, phone);
	 p.executeUpdate();
 }
 
   public ArrayList<HashMap> getAllEnquiries() throws SQLException{
	 PreparedStatement p=c.prepareStatement("select * from enquiries order by e_date DESC");
	 ResultSet rs=p.executeQuery();  
	 ArrayList<HashMap> enquiries=new ArrayList<>();
	 while(rs.next()) {
		 HashMap<String,Object> enquiry=new HashMap<>();
		 enquiry.put("name", rs.getString("name"));
		 enquiry.put("phone", rs.getString("phone"));
		 enquiry.put("status", rs.getString("status"));
		 enquiry.put("e_date", rs.getDate("e_date"));
		 enquiries.add(enquiry);
	 }
	 return enquiries;
   }
   public ArrayList<HashMap> getAllRepairExperts() throws SQLException{
		 PreparedStatement p=c.prepareStatement("select * from repair_experts order by name ASC");
		 ResultSet rs=p.executeQuery();  
		 ArrayList<HashMap> repairExperts=new ArrayList<>();
		 while(rs.next()) {
			 HashMap<String,Object> repairExpert=new HashMap<>();
			 repairExpert.put("name", rs.getString("name"));
			 repairExpert.put("phone", rs.getString("phone"));
			 repairExpert.put("email", rs.getString("email"));
			 repairExpert.put("city", rs.getString("city"));
			
			 repairExperts.add(repairExpert);
		 }
		 return repairExperts;
	   }
   
   public ArrayList<HashMap> searchRepairExperts(String state,String city,String sector) throws SQLException{
		 PreparedStatement p=c.prepareStatement("select * from repair_experts where state=? and city=? and sector like ? order by name ASC");
		 p.setString(1, state);
		 p.setString(2, city);
		 p.setString(3, "%"+sector+"%");
		 ResultSet rs=p.executeQuery();  
		 ArrayList<HashMap> repairExperts=new ArrayList<>();
		 while(rs.next()) {
			 HashMap<String,Object> repairExpert=new HashMap<>();
			 repairExpert.put("name", rs.getString("name"));
			 repairExpert.put("phone", rs.getString("phone"));
			 repairExpert.put("email", rs.getString("email"));
			 repairExpert.put("city", rs.getString("city"));
			 repairExpert.put("state", rs.getString("state"));
			 repairExpert.put("sector", rs.getString("sector"));
			
			 repairExperts.add(repairExpert);
		 }
		 return repairExperts;
	   }
   public HashMap getRepairExpertDetails(String email) throws SQLException{
		 PreparedStatement p=c.prepareStatement("select * from repair_experts where email=?");
		 p.setString(1, email);
		 ResultSet rs=p.executeQuery();  
		 if(rs.next()) {
			 HashMap<String,Object> repairExpert=new HashMap<>();
			 repairExpert.put("name", rs.getString("name"));
			 repairExpert.put("phone", rs.getString("phone"));
			 repairExpert.put("email", rs.getString("email"));
			 repairExpert.put("State", rs.getString("state"));
			 repairExpert.put("city", rs.getString("city"));
			 repairExpert.put("sector", rs.getString("sector"));
			 repairExpert.put("status", rs.getString("status"));
			
			 return repairExpert;
		 }else {
			 return null;
		 }
		 
	   }
   
   public byte[] getPhoto(String type,String email) throws SQLException{
		 PreparedStatement p=null;
		 
		 if(type.equalsIgnoreCase("repair_expert")) {
		 p=c.prepareStatement("select photo from repair_experts where email=?");
		 p.setString(1, email);
		 }
		 
		 ResultSet rs=p.executeQuery();  
		 if(rs.next()) {
			return rs.getBytes("photo");
		 }else {
			 return null;
		 }
		 
	   }
}
