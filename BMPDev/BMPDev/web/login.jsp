<%-- 
    Document   : login
    Created on : Jul 16, 2017, 10:50:10 AM
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
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Modern Business - Start Bootstrap Template</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
        <script src="dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type="text/css" href="dist/sweetalert.css">
    <style>
        body{
            background-image:url("../BMPDev/image/bg.png");
        }
        .form-signin {
            max-width: 500px;
            padding: 30px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            box-shadow: 0 1px 2px rgba(0,0,0,.05);
            font-family:Tahoma, Geneva, sans-serif;
            color:#000000;
            font-weight:lighter;
        }
        .form-signin .form-signin-heading{
            color:#00A2D1;
        }
        .form-signin input[type="text"],
        .form-signin input[type="password"]{
            font-size: 16px;
            height: 45px;
            padding: 10px;
        }
        .signin-form, .body-container
        {
            margin-top:110px;
        }
    </style>
</head>
<body>
	<%
	if(request.getParameter("Action") != null)	
	{
		Connection connect = null;
		Statement s = null;
		
		try {
			Class.forName(configmysql.mysqljdbc);
                        connect =  DriverManager.getConnection(configmysql.mysqlserver);
			
			String username = request.getParameter("txtUsername");
			String password = request.getParameter("txtPassword");
			
			s = connect.createStatement();
			
			String sql = "SELECT * FROM  member WHERE " +
			" Username = '" + username + "' AND " + 
			" Password = '" + password + "' ";
			
			ResultSet rec = s.executeQuery(sql);
			
			if(!rec.next())
			{
				out.print("<script>sweetAlert('Oops...','กรอกชื่อผู้ใช้หรือรหัสผ่านผิด!', 'error')</script>");
			} else {
				rec.first();
				session.setAttribute("sUserID",rec.getString("UserID"));
                                //ตรวจสอบประเภทผู้ใช้ตรงนี้
				response.sendRedirect("profile.jsp");
			}
			
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
		
	}
		
	%>

<center>	
<form  class="form-signin" name="singupform" method="post" action="login.jsp?Action=Login" onsubmit="return validateForm()">
    <img src="../BMPDev/image/logo.png" alt="Mountain View" style="width:50%;height:50%;padding:5px">
    <br>
  <table border="0" style="width: 100%">
    <tbody>
      <tr>
        <td>
          <div class="form-group">
              <input name="txtUsername" type="text" id="txtUsername" class="form-control" placeholder="Username" value="<%if(request.getParameter("txtUsername")!=null){out.print(request.getParameter("txtUsername"));}%>">
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="form-group">
              <input name="txtPassword" type="password" id="txtPassword" class="form-control" placeholder="Password">
          </div>
        </td>
      </tr>
    </tbody>
  </table>
      <input type="checkbox" class="pull-left" name="checkbox">
      <span class="pull-left"><b>&nbsp;จำ Username และPassword</b></span>
  <br>
  <br>
  <button type="button" class="pull-left btn btn-primary"><i class="glyphicon glyphicon-user"></i> สมัครใช้งาน</button> <button type="submit" name="Submit" value="Login" class="pull-right btn btn-success"><i class="glyphicon glyphicon-log-in"></i> เข้าสู้ระบบ</button>
  <br>
</form>
</center>
<script>
    function validateForm() {
                var x = document.forms["singupform"]["txtUsername"].value;
                var y = document.forms["singupform"]["txtPassword"].value;
                if (x==""||y=="") {
				sweetAlert("Oops...", "กรุณากรอกข้อมูล", "error");
                return false;
                }
                }
</script>
</body>
</html>

