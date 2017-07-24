<%-- 
    Document   : index
    Created on : Jul 16, 2017, 9:05:55 AM
    Author     : Max
--%>
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
                <a class="navbar-brand" href="index.jsp">Start Bootstrap</a>
                
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
                            <button class="btn btn-default" type="submit">
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
                    
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <div class="fill" style="background-image:url('http://placehold.it/1900x1080&text=Slide One');"></div>
                <div class="carousel-caption">
                    <h2>Caption 1</h2>
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('http://placehold.it/1900x1080&text=Slide Two');"></div>
                <div class="carousel-caption">
                    <h2>Caption 2</h2>
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('http://placehold.it/1900x1080&text=Slide Three');"></div>
                <div class="carousel-caption">
                    <h2>Caption 3</h2>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
    </header>
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
		
		String sql = "SELECT * FROM  customer WHERE Name like '%" +  keyword + "%' " +
		" ORDER BY CustomerID ASC";
		
		System.out.println(sql);
		
		ResultSet rec = s.executeQuery(sql);
		%>
                <hr>
                <div class="panel panel-default">
                    
                    <div class="panel-heading">  
                        <h1>ทดสอบCommit</h1>
                        <button type="button" class="btn btn-primary btn-lg btn-block" onclick="document.getElementById('id01').style.display='block'" style="width:auto;"><i class="glyphicon glyphicon-plus"></i>เพิ่มข้อมูล</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th width="91"> <div align="center">CustomerID </div></th>
                                            <th width="98"> <div align="center">Name </div></th>
                                            <th width="198"> <div align="center">Email </div></th>
                                            <th width="97"> <div align="center">CountryCode </div></th>
                                            <th width="59"> <div align="center">Budget </div></th>
                                            <th width="71"> <div align="center">Used </div></th>
                                            <th width="71"> <div align="center">View </div></th>
                                            <th width="71"> <div align="center">Edit </div></th>
                                            <th width="71"> <div align="center">Delete </div></th>
                                        </tr>
                                    </thead>
                                    <tbody>                                        
                                    <%while((rec!=null) && (rec.next())) { %>
                                        <tr>
                                            <td align="center"><div align="center"><%=rec.getString("CustomerID")%></div></td>
                                            <td align="center"><%=rec.getString("Name")%></td>
                                            <td align="center"><%=rec.getString("Email")%></td>
                                            <td><div align="center"><%=rec.getString("CountryCode")%></div></td>
                                            <td align="center"><%=rec.getFloat("Budget")%></td>
                                            <td align="center"><%=rec.getFloat("Used")%></td>
                                            <td align="center"><a type="button" href="view.jsp?CusID=<%=rec.getString("CustomerID")%>" class="btn btn-primary btn-circle"><i class="glyphicon glyphicon-info-sign"></i></a></td>
                                            <td align="center"><a type="button" href="edit.jsp?CusID=<%=rec.getString("CustomerID")%>" class="btn btn-info btn-circle"><i class="glyphicon glyphicon-edit"></i></a>                                                
                                            <td align="center"><a type="button" onclick="del()" class="btn btn-danger btn-circle"><i class="glyphicon glyphicon-trash"></i></a>
                                                <script>
                                                function del() 
                                                {
                                                        if (confirm("คุณต้องการลบ <%=rec.getString("Name")%> ?") == true) 
                                                        {
                                                        javascript:location.href="del.jsp?CusID=<%=rec.getString("CustomerID")%>"
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
                    <p>Copyright &copy; Your Website 2014</p>
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


<div id="id01" class="modal" onfocus="JavaScript:return null;">
   <form class="modal-content animate" name="frmAdd" method="post" action="add.jsp"  onSubmit="JavaScript:return fncSubmit();">	
        <center>
        <div class="form-group">
            <input class="form-control" name="txtCustomerID" placeholder="CustomerID" style="width: 50%">
        </div>
        </center>
        <!--
	<table width="374" border="1">	
  <tr>
	<th width="140">
    <div align="left">CustomerID </div></th>
		<td width="272"><input type="text" name="txtCustomerID" size="5"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Name </div></th>
		<td><input type="text" name="txtName" size="20"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Email </div></th>
		<td><input type="text" name="txtEmail" size="20"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">CountryCode </div></th>
		<td><input type="text" name="txtCountryCode" size="2"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Budget </div></th>
		<td><input type="text" name="txtBudget" size="5"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Used </div></th>
		<td><input type="text" name="txtUsed" size="5"></td>
	</tr>
	</table>
        <br>
        <div  style="background-color:#f1f1f1">
      <button type="submit" value="Save" >Save</button>
      <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
      <span class="psw">Forgot <a href="#">password?</a></span>
    </div>-->
	</form> 
    
</div>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

</body>
</html>
