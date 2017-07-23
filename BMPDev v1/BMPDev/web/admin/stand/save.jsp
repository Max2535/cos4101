<%-- 
    Document   : save
    Created on : Jul 16, 2017, 10:41:10 AM
    Author     : Max
--%>

<%@page import="data.configmysql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<body>
	
	<%	
	Connection connect = null;
	Statement s = null;
	
	try {
		Class.forName(configmysql.mysqljdbc);
		
		connect =  DriverManager.getConnection(configmysql.mysqlserver);
		
		s = connect.createStatement();
		
		String StandID = request.getParameter("StandID");
                String Data = request.getParameter("Data");
		//UPDATE `stand` SET `Data` = 'ทดสอบxcxcxvc' WHERE `stand`.`StandID` = 1;
                String sql = "UPDATE `stand` SET `Data` = '"+Data+"' WHERE `stand`.`StandID` = "+StandID+";";
                s.execute(sql);
                response.sendRedirect("/BMPDev/admin/index.jsp");
	  		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	
		try {
			if(s!=null){
				s.close();
				connect.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	%>
</body>
</html>

