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
            out.print("<script>alert('คุณยังไม่ได้เข้าสู้ระบบ กรุณาเข้าสู่ระบบด้วย');</script>");
            response.sendRedirect("/BMPDev/index.jsp");            
                             
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
                    sql = "SELECT member.Name,hire.*,motorcycle.BrandMotorCycle from  hire left outer join member on hire.UserID=member.UserID left outer join motorcycle on motorcycle.MotorCycleID=hire.MotorCycleID"
                        +" ORDER BY member.UserID ASC";
                }else
                {
                    sql = "";
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
                                            <th> <div align="center">รหัสการเช่า </div></th>
                                            <th> <div align="center">ชื่อลูกค้า </div></th>
                                            <th> <div align="center">รุ่นมอเตอร์ไซค์ </div></th>                                            
                                            <th> <div align="center">จำนวนวันที่เช่า </div></th>
                                            <th> <div align="center">กำหนดส่งรถ </div></th>
                                            <th> <div align="center">View </div></th>
                                            <th> <div align="center">Edit </div></th>
                                            <th> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("HireID")%></div></td>
                                            <td align="center"><%=rec.getString("Name")%></td>
                                            <td align="center"><%=rec.getString("BrandMotorCycle")%></td>
                                            <td align="center"><%=rec.getString("Data")%></td>
                                            <td align="center"><%=rec.getString("ExpiredDate")%></td>
                                            <td align="center"><a type="button" href="view.jsp?CusID=<%=rec.getString("HireID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="edit.jsp?CusID=<%=rec.getString("HireID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del<%=rec.getString("HireID")%>()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del<%=rec.getString("HireID")%>() 
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
                    sql = "SELECT member.Name,booking.*,motorcycle.BrandMotorCycle from  booking left outer join member on booking.UserID=member.UserID left outer join motorcycle on motorcycle.MotorCycleID=booking.MotorCycleID";
                }
		System.out.println(sql);
                rec = s.executeQuery(sql);
                              
                              %>                             
                            <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th> <div align="center">รหัสการจอง </div></th>
                                            <th> <div align="center">ชื่อลูกค้า </div></th>
                                            <th> <div align="center">รุ่นมอเตอร์ไซค์ </div></th>
                                            <th> <div align="center">วันที่ใช้งาน </div></th>
                                            <th> <div align="center">เวลาในการจอง </div></th>
                                            <th> <div align="center">View </div></th>
                                            <th> <div align="center">Edit </div></th>
                                            <th> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("BookingID")%></div></td>
                                            <td align="center"><%=rec.getString("Name")%></td>
                                            <td align="center"><%=rec.getString("BrandMotorCycle")%></td>
                                            <td align="center"><%=rec.getString("Data")%></td>
                                            <td align="center"><%=rec.getString("ExpiredDate")%></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/booking/view.jsp?BookingID=<%=rec.getString("BookingID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/booking/edit.jsp?BookingID=<%=rec.getString("BookingID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del2<%=rec.getString("BookingID")%>()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del2<%=rec.getString("BookingID")%>() 
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
                    sql = "SELECT member.Name,stand.*,motorcycle.BrandMotorCycle from  stand left outer join member on stand.UserID=member.UserID left outer join motorcycle on motorcycle.MotorCycleID=stand.MotorCycleID";
                }
		System.out.println(sql);
                rec = s.executeQuery(sql);
                %>                             
                            <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th> <div align="center">รหัสการคืน </div></th>
                                            <th> <div align="center">ชื่อลูกค้า </div></th>
                                            <th> <div align="center">รุ่นมอเตอร์ไซค์ </div></th>
                                            <th> <div align="center">กำหนดวันคืนรถ </div></th>
                                            <th> <div align="center">วันที่คืนรถ </div></th>
                                            <th> <div align="center">View </div></th>
                                            <th> <div align="center">Edit </div></th>
                                            <th> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("StandID")%></div></td>
                                            <td align="center"><%=rec.getString("Name")%></td>
                                            <td align="center"><%=rec.getString("BrandMotorCycle")%></td>
                                            <td align="center"><%=rec.getString("ExpiredDate")%></td>
                                            <td align="center"><%=rec.getString("ExpiredDate")%></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/stand/view.jsp?StandID=<%=rec.getString("StandID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="/BMPDev/admin/stand/edit.jsp?StandID=<%=rec.getString("StandID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del3<%=rec.getString("StandID")%>()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del3<%=rec.getString("StandID")%>() 
                                                {
                                                        if (confirm("จัดการคืนรถ คุณต้องการลบ <%=rec.getString("StandID")%> ?") === true)
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
                                            <th width="91"> <div align="center">รหัสลูกค้า </div></th>
                                            <th width="98"> <div align="center">ชื่อผู้ใช </div></th>
                                            <th width="198"> <div align="center">สถานะ </div></th>
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
                                            <td style="width: 5%"><% int temp=rec.getInt("online");
                                                if(temp==1)
                                                {%>
                                                <button type="button" class="btn btn-success">online</button>
                                                <%}else{%>
                                                <button type="button" class="btn btn-danger">offline</button>
                                                <%}%></td>
                                            <td><div align="center"><%=rec.getString("Email")%>&nbsp;<button type="button" onclick="send<%=rec.getString("UserID")%>()" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-inbox"></i></button></div></td>
                                            <script>
                                                function send<%=rec.getString("UserID")%>() 
                                                {
                                                        if (confirm("คุณต้องการส่งไปหา <%=rec.getString("Username")%> ?")=== true) 
                                                        {
                                                        javascript:location.href="send.jsp?Email=<%=rec.getString("Email")%>"
                                                        } 
                                                }
                                                </script>
                                            <td align="center"><a type="button" href="view.jsp?UserID=<%=rec.getString("UserID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="edit.jsp?UserID=<%=rec.getString("UserID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del<%=rec.getString("UserID")%>()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del<%=rec.getString("UserID")%>() 
                                                {
                                                        if (confirm("คุณต้องการลบ <%=rec.getString("Username")%> ?")=== true) 
                                                        {
                                                        javascript:location.href="del.jsp?UserID=<%=rec.getString("UserID")%>"
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
            <br>
            <!--INSERT INTO `member` (`Username`, `Password`, `Email`, `Name`, `type`, `UserID`, `online`) VALUES ('root', 'toor', 'suppchai_kalmro@hotmail.co.th', 'suppchai_kalmro', 'amdin', NULL, '0');-->
            <input class="form-control" type="text"  name="Username" placeholder="Username" id="t1" style="width: 90%">
            <input class="form-control" type="password" name="Password" placeholder="Password" style="width: 90%">
            <input class="form-control" type="email" name="Email" placeholder="E-mail" style="width: 90%">
            <input class="form-control" type="text" name="Name" placeholder="Name" style="width: 90%">
            <input class="form-control" type="text" name="type" placeholder="type" style="width: 90%">
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
<%
    Object Send = session.getAttribute("Send");
    if(Send!=null||!Send.equals(""))
    {
        %>
        <script>
            alert("<%=Send%>")
            </script>
        <%
    }
    session.setAttribute("Send","");%>