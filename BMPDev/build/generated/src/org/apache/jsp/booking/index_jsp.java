package org.apache.jsp.booking;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import data.configmysql;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write('\n');

Object strUserID = session.getAttribute("sUserID");
        Object Type = session.getAttribute("Type");
	if(strUserID == null&&Type.equals("admin")) // Check Login
	{
		out.print("<script>alert('คุณยังไม่ได้เข้าสู้ระบบ กรุณาเข้าสู่ระบบด้วย');</script>");
                response.sendRedirect("/BMPDev/index.jsp");
	}

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 request.setCharacterEncoding("UTF-8"); 
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("\n");
      out.write("    <meta charset=\"utf-8\">\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <meta name=\"description\" content=\"\">\n");
      out.write("    <meta name=\"author\" content=\"\">\n");
      out.write("\n");
      out.write("    <title>Modern Business - Start Bootstrap Template</title>\n");
      out.write("\n");
      out.write("    <!-- Bootstrap Core CSS -->\n");
      out.write("    <link href=\"../css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("    <!-- Custom max -->\n");
      out.write("    <link href=\"../css/crud.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Custom CSS -->\n");
      out.write("    <link href=\"../css/modern-business.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Custom Fonts -->\n");
      out.write("    <link href=\"../font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->\n");
      out.write("    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->\n");
      out.write("    <!--[if lt IE 9]>\n");
      out.write("        <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>\n");
      out.write("        <script src=\"https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js\"></script>\n");
      out.write("    <![endif]-->\n");
      out.write("\n");
      out.write("    <!-- MetisMenu CSS -->\n");
      out.write("    <link href=\"../vendor/metisMenu/metisMenu.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Social Buttons CSS -->\n");
      out.write("    <link href=\"../vendor/bootstrap-social/bootstrap-social.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Custom CSS -->\n");
      out.write("    <link href=\"../dist/css/sb-admin-2.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->\n");
      out.write("    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->\n");
      out.write("    <!--[if lt IE 9]>\n");
      out.write("        <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>\n");
      out.write("        <script src=\"https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js\"></script>\n");
      out.write("    <![endif]-->\n");
      out.write("\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <nav class=\"navbar navbar-inverse navbar-fixed-top\" role=\"navigation\">\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <!-- Brand and toggle get grouped for better mobile display -->\n");
      out.write("            <div class=\"navbar-header\">\n");
      out.write("                <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\"style=\"padding-left:  20px;\">\n");
      out.write("                    <span class=\"sr-only\">Toggle navigation</span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                </button>\n");
      out.write("                <a class=\"navbar-brand\" href=\"index.jsp\">ผู้ดูแลระบบ</a>\n");
      out.write("                \n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <!-- Collect the nav links, forms, and other content for toggling -->\n");
      out.write("            <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\n");
      out.write("                \n");
      out.write("                <ul class=\"nav navbar-nav navbar-right\">\n");
      out.write("                   \n");
      out.write("                    <li>\n");
      out.write("                        <a href=\"#\">เพิ่มเมนู</a>\n");
      out.write("                    </li>\n");
      out.write("                    \n");
      out.write("                </ul>\n");
      out.write("                    <form name=\"frmSearch\" method=\"get\" action=\"index.jsp\" class=\"input-group custom-search-form navbar-right\" style=\"width: 250px;padding: 1px;\">\n");
      out.write("                        <input type=\"text\" class=\"form-control\" name=\"txtKeyword\" id=\"txtKeyword\" placeholder=\"Search...\">\n");
      out.write("                        <span class=\"input-group-btn\">\n");
      out.write("                            <button class=\"btn btn-default form-control\" type=\"submit\">\n");
      out.write("                                <i class=\"fa fa-search\"></i>\n");
      out.write("                            </button>\n");
      out.write("                        </span>\n");
      out.write("                    </form>\n");

	String keyword = "";
	if(request.getParameter("txtKeyword") != null) {
		keyword = request.getParameter("txtKeyword");
	}

      out.write("\n");
      out.write("            </div>\n");
      out.write("            <!-- /.navbar-collapse -->\n");
      out.write("        </div>\n");
      out.write("        <!-- /.container -->\n");
      out.write("    </nav>\n");
      out.write("        <!-- Page Content -->\n");
      out.write("    <div class=\"container\">\n");
      out.write("\n");
      out.write("        <!-- Marketing Icons Section -->\n");
      out.write("        <div class=\"row\">\n");
      out.write("    <script type=\"text/javascript\">\n");
      out.write("\tfunction fncSubmit()\n");
      out.write("\t{\n");
      out.write("\t\tif(document.form1.txt1.value == \"\")\n");
      out.write("\t\t{\n");
      out.write("\t\t\talert('Please input Input 1');\n");
      out.write("\t\t\tdocument.form1.txt1.focus();\n");
      out.write("\t\t\treturn false;\n");
      out.write("\t\t}\t\n");
      out.write("\t\tif(document.form1.txt2.value == \"\")\n");
      out.write("\t\t{\n");
      out.write("\t\t\talert('Please input Input 2');\n");
      out.write("\t\t\tdocument.form1.txt2.focus();\t\t\n");
      out.write("\t\t\treturn false;\n");
      out.write("\t\t}\t\n");
      out.write("\t\tdocument.form1.submit();\n");
      out.write("\t}\n");
      out.write("\t</script>\n");
      out.write("        \n");
      out.write("        \n");
      out.write("    \n");
      out.write("    \n");
      out.write("    \n");
      out.write("\t");

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
		
      out.write("\n");
      out.write("                <hr>\n");
      out.write("                <div class=\"panel panel-default\">\n");
      out.write("                <h2 style=\"text-align: center\">จัดการจองรถ</h2>\n");
      out.write("                    ");

		if(keyword=="")
                {
                    sql = "SELECT * FROM  booking";
                }
		System.out.println(sql);
                rec = s.executeQuery(sql);
                              
                              
      out.write("                             \n");
      out.write("                            <div class=\"panel-body\">\n");
      out.write("                            <div class=\"table-responsive\">\n");
      out.write("                                <table class=\"table table-striped table-bordered table-hover\">\n");
      out.write("                                    <thead>\n");
      out.write("                                        <tr>\n");
      out.write("                                            <th> <div align=\"center\">BookingID </div></th>\n");
      out.write("                                            <th> <div align=\"center\">UserID </div></th>\n");
      out.write("                                            <th> <div align=\"center\">MotorCycleID </div></th>\n");
      out.write("                                            <th> <div align=\"center\">Data </div></th>\n");
      out.write("                                            <th> <div align=\"center\">ExpiredDate </div></th>\n");
      out.write("                                            <th> <div align=\"center\">View </div></th>\n");
      out.write("                                            <th> <div align=\"center\">Edit </div></th>\n");
      out.write("                                            <th> <div align=\"center\">Delete </div></th>\n");
      out.write("                                        </tr>\n");
      out.write("                                    </thead>\n");
      out.write("                                    <tbody>                                        \n");
      out.write("                                    ");
while((rec!=null) && (rec.next())) { 
      out.write("\n");
      out.write("                                        <tr>\n");
      out.write("                                            <td align=\"center\"><div align=\"center\">");
      out.print(rec.getString("BookingID"));
      out.write("</div></td>\n");
      out.write("                                            <td align=\"center\">");
      out.print(rec.getString("UserID"));
      out.write("</td>\n");
      out.write("                                            <td align=\"center\">");
      out.print(rec.getString("MotorCycleID"));
      out.write("</td>\n");
      out.write("                                            <td align=\"center\">");
      out.print(rec.getString("Data"));
      out.write("</td>\n");
      out.write("                                            <td align=\"center\">");
      out.print(rec.getString("ExpiredDate"));
      out.write("</td>\n");
      out.write("                                            <td align=\"center\"><a type=\"button\" href=\"/BMPDev/admin/booking/view.jsp?BookingID=");
      out.print(rec.getString("BookingID"));
      out.write("\" class=\"btn btn-primary btn-circle\"><i class=\"glyphicon glyphicon-info-sign\"></i></a></td>\n");
      out.write("                                            <td align=\"center\"><a type=\"button\" href=\"/BMPDev/admin/booking/edit.jsp?BookingID=");
      out.print(rec.getString("BookingID"));
      out.write("\" class=\"btn btn-info btn-circle\"><i class=\"glyphicon glyphicon-edit\"></i></a>                                                \n");
      out.write("                                            <td align=\"center\"><a type=\"button\" onclick=\"del2()\" class=\"btn btn-danger btn-circle\"><i class=\"glyphicon glyphicon-trash\"></i></a>\n");
      out.write("                                                <script>\n");
      out.write("                                                function del2() \n");
      out.write("                                                {\n");
      out.write("                                                        if (confirm(\"คุณต้องการลบ ");
      out.print(rec.getString("BookingID"));
      out.write(" ?\") == true) \n");
      out.write("                                                        {\n");
      out.write("                                                        javascript:location.href=\"/BMPDev/admin/booking/del.jsp?BookingID=");
      out.print(rec.getString("BookingID"));
      out.write("\"\n");
      out.write("                                                        } \n");
      out.write("                                                }\n");
      out.write("                                                </script>\n");
      out.write("                                        </tr>\n");
      out.write("\t       \t                    ");
}
      out.write("\n");
      out.write("                                    </tbody>\n");
      out.write("                                </table>\n");
      out.write("                            </div>\n");
      out.write("                            <!-- /.table-responsive -->\n");
      out.write("                        </div>\n");
      out.write("                        <!-- /.panel-body -->\n");
      out.write("                    </div>\n");
      out.write("        ");
	
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
	
      out.write("\n");
      out.write("        </div>\n");
      out.write("        <hr>\n");
      out.write("        <!-- Footer -->\n");
      out.write("        <footer>\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-lg-12\">\n");
      out.write("                    <p>Copyright &copy; ");
out.print(configmysql.website);
      out.write("</p>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </footer>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("    <!-- /.container -->\n");
      out.write("\n");
      out.write("    <!-- jQuery -->\n");
      out.write("    <script src=\"../js/jquery.js\"></script>\n");
      out.write("\n");
      out.write("    <!-- Bootstrap Core JavaScript -->\n");
      out.write("    <script src=\"../js/bootstrap.min.js\"></script>\n");
      out.write("\n");
      out.write("    <!-- Script to Activate the Carousel -->\n");
      out.write("    <script>\n");
      out.write("    $('.carousel').carousel({\n");
      out.write("        interval: 5000 //changes the speed\n");
      out.write("    })\n");
      out.write("    </script>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
