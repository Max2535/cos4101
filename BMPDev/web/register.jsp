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
<%
	if(request.getParameter("Action") != null)	
	{
		Connection connect1 = null;
		Statement s1 = null;
		
		try {
			Class.forName(configmysql.mysqljdbc);
                        connect1 =  DriverManager.getConnection(configmysql.mysqlserver);
			
			Object strUserID = session.getAttribute("sUserID");
			s1 = connect1.createStatement();
                        String sql = "UPDATE member SET online = '0' WHERE UserID = "+strUserID+";";
                        s1.execute(sql);			
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
		
	}	
	%>  
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
    <style>
        footer{
            margin-left: 15%;
        }
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
			
			//String sql = "SELECT * FROM  member WHERE " +
			///" Username = '" + username + "' AND " + 
			//" Password = '" + password + "' ";
                        //INSERT INTO `member` (`Username`, `Password`, `Email`, `Name`, `type`, `UserID`) VALUES ('uat', '1234', 'aaaa@aaaa.com', 'test', 'user', NULL);
			String sql="INSERT INTO `member` (`Username`, `Password`, `Email`, `Name`, `type`, `UserID`) VALUES ('uat', '1234', 'aaaa@aaaa.com', 'test', 'user', NULL);";
			s.execute(sql);
			response.sendRedirect("/BMPDev/login.jsp");
			
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
    <form role="form" class="form-signin" name="singinform" onsubmit="return validateForm()">
    <table border="0" style="width: 100%">
    <tbody>
      <tr>
        <td>
          <div class="form-group input-group">
              <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
              <input type="text" name="username" class="form-control" placeholder="Username">
        </div>
        </td>
      </tr>
      <tr>
        <td>
          <div class="form-group input-group">
            <span class="input-group-addon"><i class="glyphicon glyphicon-inbox"></i></span>
            <input type="text" name="email" class="form-control" placeholder="E-mail">
        </div>
        </td>
      </tr>
      <tr>
        <td>
            <div class="form-group input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-asterisk"></i></span>
                <input type="password" name="p1" class="form-control" placeholder="Password">
            </div>
        </td>
      </tr>
      <tr>
        <td>
            <div class="form-group input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-asterisk"></i></span>
                <input type="password" name="p2" class="form-control" placeholder="Confirm Password">
            </div>
        </td>
      </tr>
      <tr>
        <td>
            <div class="form-group">
                <input type="file" name="fileUpload" class="form-control">
            </div>
        </td>
      </tr>
    </tbody>
    </table>
    <br>
    <br>
    <button type="submit" name="Submit" value="Singup" class="pull-right btn btn-success"><i class="glyphicon glyphicon-log-in"></i> สมัครใช้งาน</button>
    <br>
    </form>
</center>
<script>
    function validateForm() {
                var x = document.forms["singinform"]["p1"].value;
                var y = document.forms["singinform"]["p2"].value;
                var z = document.forms["singinform"]["username"].value;
                var w = document.forms["singinform"]["email"].value;
                if (x===""||y===""||z===""||w==="") 
                {
                    sweetAlert("Oops...", "กรุณาป้อนข้อมูลให้ครบด้วย", "error");
                    return false;
                }
                var atpos = w.indexOf("@");
                var dotpos = w.lastIndexOf(".");
                if (atpos<1 || dotpos<atpos+2 || dotpos+2>=w.length) 
                    {
                        sweetAlert("Oops...", "E-Mail ไม่ถูกต้อง", "error");
                        return false;
                    }
                if (x!==y)
                {
                    sweetAlert("Oops...", "รหัสผ่านไม่ตรงกัน", "error");
                    return false;
                }
            }     
</script>
        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; <%out.print(configmysql.website);%></p>
                </div>
            </div>
        </footer>
</body>
</html>

