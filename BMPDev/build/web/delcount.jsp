<%-- 
    Document   : delcount
    Created on : Aug 8, 2017, 12:29:57 PM
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
<%
    Connection connect1 = null;
    Statement s1 = null;
    try {
        Class.forName(configmysql.mysqljdbc);
        connect1 =  DriverManager.getConnection(configmysql.mysqlserver);
        s1 = connect1.createStatement();
        String sql1 = "SELECT * FROM  pageconut";
        ResultSet rec1 = s1.executeQuery(sql1);
        rec1.first();
        int tmp=rec1.getInt("count");
        tmp--;
        //UPDATE `pageconut` SET `conut` = '5' WHERE `pageconut`.`id` = 1;
        String sql = "UPDATE `pageconut` SET `count` = '"+tmp+"' WHERE `id` = 1";
        s1.execute(sql);
        response.sendRedirect("/BMPDev/index.jsp");
    } catch (Exception e) {
// TODO Auto-generated catch block
out.println(e.getMessage());
e.printStackTrace();
    }
    try {
        if(s1!=null){
            s1.close();
            connect1.close();
        }
    } catch (SQLException e) {
// TODO Auto-generated catch block
out.println(e.getMessage());
e.printStackTrace();
    }
	%>  
