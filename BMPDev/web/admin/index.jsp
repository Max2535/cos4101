<%-- 
    Document   : index
    Created on : Jul 16, 2017, 9:05:55 AM
    Author     : Max
--%>
 <%
        Object strUserID = session.getAttribute("sUserID");
        Object Type = session.getAttribute("Type");
	if(strUserID == null&&Type==null) // Check Login
	{
            response.sendRedirect("/BMPDev/index.jsp"); 
            out.print("<script>alert('คุณยังไม่ได้เข้าสู้ระบบ กรุณาเข้าสู่ระบบด้วย');</script>");
                             
	}
        else if(!Type.equals("admin"))
                {
                  response.sendRedirect("/BMPDev/index.jsp");
                }
        %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="data.configmysql"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Modern Business - Start Bootstrap Template</title>

    <!-- Bootstrap Core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom max -->
    <link href="../css/crud.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Social Buttons CSS -->
    <link href="../vendor/bootstrap-social/bootstrap-social.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"style="padding-left:  20px;">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">ผู้ดูแลระบบ</a>
                
            </div>
            
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                
                <ul class="nav navbar-nav navbar-right">
                   
                    <li>
                        <a href="#">เพิ่มเมนู</a>
                    </li>
                    
                </ul>
                    <form name="frmSearch" method="get" action="index.jsp" class="input-group custom-search-form navbar-right" style="width: 250px;padding: 1px;">
                        <input type="text" class="form-control" name="txtKeyword" id="txtKeyword" placeholder="Search...">
                        <span class="input-group-btn">
                            <button class="btn btn-default form-control" type="submit">
                                <i class="fa fa-search"></i>
                            </button>
                        </span>
                    </form>
<%
	String keyword = "";
	if(request.getParameter("txtKeyword") != null) {
		keyword = request.getParameter("txtKeyword");
	}
%>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
        <!-- Page Content -->
    <div class="container">

        <!-- Marketing Icons Section -->
        <div class="row">
    <script type="text/javascript">
	function fncSubmit()
	{
		if(document.form1.txt1.value == "")
		{
			alert('Please input Input 1');
			document.form1.txt1.focus();
			return false;
		}	
		if(document.form1.txt2.value == "")
		{
			alert('Please input Input 2');
			document.form1.txt2.focus();		
			return false;
		}	
		document.form1.submit();
	}
	</script>
        
        
    
    
    
	<%
	Connection connect = null;
	Statement s = null;
	
	try {
		Class.forName(configmysql.mysqljdbc);
		connect =  DriverManager.getConnection(configmysql.mysqlserver);
		
		s = connect.createStatement();
		
		String sql;
		if(keyword=="")
                {
                    sql = "SELECT * FROM  hire";
                }else
                {
                    sql = "SELECT * FROM  hire WHERE HireID like '%" +  keyword + "%' " +
		" ORDER BY CustomerID ASC";
                }
		System.out.println(sql);
		
		ResultSet rec = s.executeQuery(sql);
		%>
                <hr>
                <div class="panel panel-default">
                    
                     <h2 style="text-align: center">จัดการเช่ารถ</h2>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th> <div align="center">HireID </div></th>
                                            <th> <div align="center">UserID </div></th>
                                            <th> <div align="center">MotorCycleID </div></th>                                            
                                            <th> <div align="center">Data </div></th>
                                            <th> <div align="center">ExpiredDate </div></th>
                                            <th> <div align="center">View </div></th>
                                            <th> <div align="center">Edit </div></th>
                                            <th> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("HireID")%></div></td>
                                            <td align="center"><%=rec.getString("UserID")%></td>
                                            <td align="center"><%=rec.getString("MotorCycleID")%></td>
                                            <td align="center"><%=rec.getString("Data")%></td>
                                            <td align="center"><%=rec.getString("ExpiredDate")%></td>
                                            <td align="center"><a type="button" href="view.jsp?CusID=<%=rec.getString("HireID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="edit.jsp?CusID=<%=rec.getString("HireID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del() 
                                                {
                                                        if (confirm("คุณต้องการลบ <%=rec.getString("HireID")%> ?") == true) 
                                                        {
                                                        javascript:location.href="del.jsp?CusID=<%=rec.getString("HireID")%>"
                                                        } 
                                                }
                                                </script>
                                        </tr>
	       	                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                    <h2 style="text-align: center">จัดการจองรถ</h2>
                    <%
		if(keyword=="")
                {
                    sql = "SELECT * FROM  booking";
                }
		System.out.println(sql);
                rec = s.executeQuery(sql);
                              
                              %>                             
                            <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th> <div align="center">BookingID </div></th>
                                            <th> <div align="center">UserID </div></th>
                                            <th> <div align="center">MotorCycleID </div></th>
                                            <th> <div align="center">Data </div></th>
                                            <th> <div align="center">ExpiredDate </div></th>
                                            <th> <div align="center">View </div></th>
                                            <th> <div align="center">Edit </div></th>
                                            <th> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("BookingID")%></div></td>
                                            <td align="center"><%=rec.getString("UserID")%></td>
                                            <td align="center"><%=rec.getString("MotorCycleID")%></td>
                                            <td align="center"><%=rec.getString("Data")%></td>
                                            <td align="center"><%=rec.getString("ExpiredDate")%></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/booking/view.jsp?BookingID=<%=rec.getString("BookingID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/booking/edit.jsp?BookingID=<%=rec.getString("BookingID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del2()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del2() 
                                                {
                                                        if (confirm("คุณต้องการลบ <%=rec.getString("BookingID")%> ?") == true) 
                                                        {
                                                        javascript:location.href="/BMPDev/admin/booking/del.jsp?BookingID=<%=rec.getString("BookingID")%>"
                                                        } 
                                                }
                                                </script>
                                        </tr>
	       	                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    <h2 style="text-align: center">จัดการคืนรถ</h2>
                <%
		if(keyword=="")
                {
                    sql = "SELECT * FROM  stand";
                }
		System.out.println(sql);
                rec = s.executeQuery(sql);
                %>                             
                            <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th> <div align="center">StandID </div></th>
                                            <th> <div align="center">UserID </div></th>
                                            <th> <div align="center">MotorCycleID </div></th>
                                            <th> <div align="center">Data </div></th>
                                            <th> <div align="center">ExpiredDate </div></th>
                                            <th> <div align="center">View </div></th>
                                            <th> <div align="center">Edit </div></th>
                                            <th> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("StandID")%></div></td>
                                            <td align="center"><%=rec.getString("UserID")%></td>
                                            <td align="center"><%=rec.getString("MotorCycleID")%></td>
                                            <td align="center"><%=rec.getString("Data")%></td>
                                            <td align="center"><%=rec.getString("ExpiredDate")%></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/stand/view.jsp?StandID=<%=rec.getString("StandID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/stand/edit.jsp?StandID=<%=rec.getString("StandID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del3()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del3() 
                                                {
                                                        if (confirm("จัดการคืนรถ คุณต้องการลบ <%=rec.getString("StandID")%> ?") == true)
                                                        {
                                                        javascript:location.href="/BMPDev/admin/stand/del.jsp?StandID=<%=rec.getString("StandID")%>"
                                                        } 
                                                }
                                                </script>
                                        </tr>
	       	                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                <%
		if(keyword=="")
                {
                    sql = "SELECT * FROM  member";
                }
		System.out.println(sql);
                rec = s.executeQuery(sql);
                              
                              %>
                             <h2 style="text-align: center">จัดการผู้ใช้</h2>
                             <div class="panel-heading"> 
                                 <button type="button" class="btn btn-primary btn-lg btn-block" onclick="document.getElementById('id01').style.display='block'" style="width:auto;"><i class="glyphicon glyphicon-plus"></i>เพิ่มข้อมูล</button>
                             </div>                             
                            <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th width="91"> <div align="center">UserID </div></th>
                                            <th width="98"> <div align="center">Username </div></th>
                                            <th width="198"> <div align="center">Password </div></th>
                                            <th width="59"> <div align="center">Email </div></th>
                                            <th width="71"> <div align="center">View </div></th>
                                            <th width="71"> <div align="center">Edit </div></th>
                                            <th width="71"> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("UserID")%></div></td>
                                            <td align="center"><%=rec.getString("Username")%></td>
                                            <td align="center"><%=rec.getString("Password")%></td>
                                            <td><div align="center"><%=rec.getString("Email")%></div></td>
                                            <td align="center"><a type="button" href="view.jsp?CusID=<%=rec.getString("UserID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="edit.jsp?CusID=<%=rec.getString("UserID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del() 
                                                {
                                                        if (confirm("คุณต้องการลบ <%=rec.getString("UserID")%> ?") == true) 
                                                        {
                                                        javascript:location.href="del.jsp?CusID=<%=rec.getString("UserID")%>"
                                                        } 
                                                }
                                                </script>
                                        </tr>
	       	                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
        <%	
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
        </div>
        <hr>
        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; <%out.print(configmysql.website);%></p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="../js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../js/bootstrap.min.js"></script>

    <!-- Script to Activate the Carousel -->
    <script>
    $('.carousel').carousel({
        interval: 5000 //changes the speed
    })
    </script>

<div id="id01" class="modal sweet-overlay" onfocus="JavaScript:return null;">
   <form class="modal-content animate" name="frmAdd" method="post" action="add.jsp"  onSubmit="JavaScript:return fncSubmit();">	
        <center>
        <div class="form-group">
            <input class="form-control" type="text"  name="txtCustomerID" placeholder="CustomerID" id="t1" style="width: 90%">
            <input class="form-control" type="text" name="txtName" placeholder="Name" style="width: 90%">
            <input class="form-control" type="email" name="txtEmail" placeholder=" E-mail" style="width: 90%">
            <input class="form-control" type="text" name="txtCountryCode" placeholder="CountryCode" style="width: 90%">
            <input class="form-control" type="text" name="txtBudget" placeholder="Budget" style="width: 90%">
            <input class="form-control" type="text" name="txtUsed" placeholder="Used" style="width: 90%">
            <table border="0">
                 <tbody>
                    <tr>
                        <td><button type="button" class="btn btn-danger form-control " onclick="document.getElementById('id01').style.display='none'"><i class="glyphicon glyphicon-remove"></i> ออก</button></td>
                        <td>&nbsp;</td>
                        <td><button type="submit" name="Submit" class="btn btn-success"><i class="glyphicon glyphicon-ok"></i> บันทึก</button></td>
                    </tr>
                </tbody>                
            </table>
        </div>
        </center>
	</form>     
</div>
</body>
</html>
