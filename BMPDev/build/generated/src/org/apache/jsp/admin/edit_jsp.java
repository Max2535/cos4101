package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import data.configmysql;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;

public final class edit_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("@@ -0,0  1,180 @@\n");
      out.write(" ");
      out.write("\n");
      out.write(" \n");
      out.write(" \n");
      out.write(" \n");
      out.write(" <!DOCTYPE html>\n");
      out.write(" \n");
      out.write(" \n");
      out.write(" \n");
      out.write(" \n");
      out.write(" \n");
      out.write(" ");
 request.setCharacterEncoding("UTF-8"); 
      out.write("\n");
      out.write(" \n");
      out.write(" <html lang=\"en\">\n");
      out.write(" \n");
      out.write(" <head>\n");
      out.write(" \n");
      out.write("     <meta charset=\"utf-8\">\n");
      out.write("     <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("     <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("     <meta name=\"description\" content=\"\">\n");
      out.write("     <meta name=\"author\" content=\"\">\n");
      out.write(" \n");
      out.write("     <title>Modern Business - Start Bootstrap Template</title>\n");
      out.write(" \n");
      out.write("     <!-- Bootstrap Core CSS -->\n");
      out.write("     <link href=\"/BMPDev/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("     <!-- Custom max -->\n");
      out.write("     <link href=\"/BMPDev/css/crud.css\" rel=\"stylesheet\">\n");
      out.write(" \n");
      out.write("     <!-- Custom CSS -->\n");
      out.write("     <link href=\"/BMPDev/css/modern-business.css\" rel=\"stylesheet\">\n");
      out.write(" \n");
      out.write("     <!-- Custom Fonts -->\n");
      out.write("     <link href=\"/BMPDev/font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write(" \n");
      out.write("     <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->\n");
      out.write("     <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->\n");
      out.write("     <!--[if lt IE 9]>\n");
      out.write("         <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>\n");
      out.write("         <script src=\"https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js\"></script>\n");
      out.write("     <![endif]-->\n");
      out.write(" \n");
      out.write("     <!-- MetisMenu CSS -->\n");
      out.write("     <link href=\"/BMPDev/vendor/metisMenu/metisMenu.min.css\" rel=\"stylesheet\">\n");
      out.write(" \n");
      out.write("     <!-- Social Buttons CSS -->\n");
      out.write("     <link href=\"/BMPDev/vendor/bootstrap-social/bootstrap-social.css\" rel=\"stylesheet\">\n");
      out.write(" \n");
      out.write("     <!-- Custom CSS -->\n");
      out.write("     <link href=\"/BMPDev/dist/css/sb-admin-2.css\" rel=\"stylesheet\">\n");
      out.write(" \n");
      out.write("     <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->\n");
      out.write("     <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->\n");
      out.write("     <!--[if lt IE 9]>\n");
      out.write("         <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>\n");
      out.write("         <script src=\"https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js\"></script>\n");
      out.write("     <![endif]-->\n");
      out.write(" \n");
      out.write(" </head>\n");
      out.write(" <body>\n");
      out.write(" \t<nav class=\"navbar navbar-inverse navbar-fixed-top\" role=\"navigation\">\n");
      out.write("         <div class=\"container\">\n");
      out.write("             <!-- Brand and toggle get grouped for better mobile display -->\n");
      out.write("             <div class=\"navbar-header\">\n");
      out.write("                 <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\"style=\"padding-left:  20px;\">\n");
      out.write("                     <span class=\"sr-only\">Toggle navigation</span>\n");
      out.write("                     <span class=\"icon-bar\"></span>\n");
      out.write("                     <span class=\"icon-bar\"></span>\n");
      out.write("                     <span class=\"icon-bar\"></span>\n");
      out.write("                 </button>\n");
      out.write("                 <a class=\"navbar-brand\" href=\"index.jsp\">แก้ไข้ข้อมูลการคืนมอเตอร์ไซค์</a>\n");
      out.write("                 \n");
      out.write("             </div>\n");
      out.write("             \n");
      out.write("             <!-- Collect the nav links, forms, and other content for toggling -->\n");
      out.write("             <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\n");
      out.write("                 \n");
      out.write("                 <ul class=\"nav navbar-nav navbar-right\">\n");
      out.write("                    \n");
      out.write("                     <li>\n");
      out.write("                         <a href=\"#\">เพิ่มเมนู</a>\n");
      out.write("                     </li>\n");
      out.write("                     \n");
      out.write("                 </ul>\n");
      out.write("             </div>\n");
      out.write("             <!-- /.navbar-collapse -->\n");
      out.write("         </div>\n");
      out.write("         <!-- /.container -->\n");
      out.write("     </nav>\n");
      out.write(" \t");

 	String StandID = "";
 	if(request.getParameter("StandID") != null) {
 		StandID = request.getParameter("StandID");
 	}
 	
 	Connection connect = null;
 	Statement s = null;
 	
 	try {
 		Class.forName(configmysql.mysqljdbc);
 		
 		connect =  DriverManager.getConnection(configmysql.mysqlserver);
 		
 		s = connect.createStatement();
 		
 		String sql = "SELECT * FROM  stand";// WHERE StandID = '"   StandID   "'  ";
 		
 		ResultSet rec = s.executeQuery(sql);
 		if(rec != null) {
 			rec.next();
 		
      out.write("\n");
      out.write("                 <div class=\"container\">\n");
      out.write("                 <div class=\"row\">\n");
      out.write("                         <div class=\"panel-body\">\n");
      out.write(" \t<form name=\"frmUpdate\" method=\"post\" action=\"/BMPDev/admin/stand/save.jsp?StandID=");
      out.print(rec.getString("StandID"));
      out.write("\">\t\n");
      out.write(" \t\t<table class=\"table table-striped table-bordered table-hover\">\n");
      out.write("                                     <tbody>                                  \n");
      out.write("                                         <tr>\n");
      out.write("                                             <td align=\"center\">StandID:<input type=\"text\" name=\"StandID\" value=\"");
      out.print(rec.getString("StandID"));
      out.write("\" disabled></td>\n");
      out.write("                                             <td align=\"center\">UserID:<input type=\"text\" name=\"UserID\" value=\"");
      out.print(rec.getString("UserID"));
      out.write("\" disabled></td>\n");
      out.write("                                             <td align=\"center\">MotorCycleID:<input type=\"text\" name=\"MotorCycleID\"  value=\"");
      out.print(rec.getString("MotorCycleID"));
      out.write("\" disabled></td>\n");
      out.write("                                             <td align=\"center\">Data:<input type=\"text\" name=\"Data\"  value=\"");
      out.print(rec.getString("Data"));
      out.write("\"></td>\n");
      out.write("                                             <td align=\"center\">ExpiredDate:<input type=\"text\" name=\"ExpiredDate\" value=\"");
      out.print(rec.getString("ExpiredDate"));
      out.write("\" disabled></td>\n");
      out.write("                                         </tr>\n");
      out.write("                                     </tbody>\n");
      out.write("                                 </table>\n");
      out.write(" \t\t<input type=\"submit\" value=\"Save\">\n");
      out.write(" \t\t</form> \n");
      out.write("                         </div>\n");
      out.write("                 </div>\n");
      out.write(" \t\t");
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
 	
      out.write("\n");
      out.write("                 <hr>\n");
      out.write("         <!-- Footer -->\n");
      out.write("         <footer>\n");
      out.write("             <div class=\"row\">\n");
      out.write("                 <div class=\"col-lg-12\">\n");
      out.write("                     <p>Copyright &copy; ");
out.print(configmysql.website);
      out.write("</p>\n");
      out.write("                 </div>\n");
      out.write("             </div>\n");
      out.write("         </footer>\n");
      out.write(" \n");
      out.write("     </div>\n");
      out.write("     <!-- /.container -->\n");
      out.write(" \n");
      out.write("     <!-- jQuery -->\n");
      out.write("     <script src=\"/BMPDev/js/jquery.js\"></script>\n");
      out.write(" \n");
      out.write("     <!-- Bootstrap Core JavaScript -->\n");
      out.write("     <script src=\"/BMPDev/js/bootstrap.min.js\"></script>\n");
      out.write(" \n");
      out.write("     <!-- Script to Activate the Carousel -->\n");
      out.write("     <script>\n");
      out.write("     $('.carousel').carousel({\n");
      out.write("         interval: 5000 //changes the speed\n");
      out.write("     })\n");
      out.write("     </script>\n");
      out.write(" </body>\n");
      out.write(" </html>");
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
