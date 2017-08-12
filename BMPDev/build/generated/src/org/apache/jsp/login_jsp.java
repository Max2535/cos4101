package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import data.configmysql;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 request.setCharacterEncoding("UTF-8"); 
      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("\t<meta charset=\"utf-8\">\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <meta name=\"description\" content=\"\">\n");
      out.write("    <meta name=\"author\" content=\"\">\n");
      out.write("\n");
      out.write("    <title>Modern Business - Start Bootstrap Template</title>\n");
      out.write("\n");
      out.write("    <!-- Bootstrap Core CSS -->\n");
      out.write("    <link href=\"css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Custom CSS -->\n");
      out.write("    <link href=\"css/modern-business.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Custom Fonts -->\n");
      out.write("    <link href=\"font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->\n");
      out.write("    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->\n");
      out.write("    <!--[if lt IE 9]>\n");
      out.write("        <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>\n");
      out.write("        <script src=\"https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js\"></script>\n");
      out.write("    <![endif]-->\n");
      out.write("    <style>\n");
      out.write("        body{\n");
      out.write("            background-image:url(\"../BMPDev/image/bg.png\");\n");
      out.write("        }\n");
      out.write("        .form-signin {\n");
      out.write("            max-width: 500px;\n");
      out.write("            padding: 30px;\n");
      out.write("            margin: 0 auto;\n");
      out.write("            background-color: #fff;\n");
      out.write("            border: 1px solid #e5e5e5;\n");
      out.write("            -webkit-border-radius: 5px;\n");
      out.write("            -moz-border-radius: 5px;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);\n");
      out.write("            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);\n");
      out.write("            box-shadow: 0 1px 2px rgba(0,0,0,.05);\n");
      out.write("            font-family:Tahoma, Geneva, sans-serif;\n");
      out.write("            color:#000000;\n");
      out.write("            font-weight:lighter;\n");
      out.write("        }\n");
      out.write("        .form-signin .form-signin-heading{\n");
      out.write("            color:#00A2D1;\n");
      out.write("        }\n");
      out.write("        .form-signin input[type=\"text\"],\n");
      out.write("        .form-signin input[type=\"password\"]{\n");
      out.write("            font-size: 16px;\n");
      out.write("            height: 45px;\n");
      out.write("            padding: 10px;\n");
      out.write("        }\n");
      out.write("        .signin-form, .body-container\n");
      out.write("        {\n");
      out.write("            margin-top:110px;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\t");

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
				out.print("<script>alert('กรอกชื่อผู้ใช้หรือรหัสผ่านผิด!')</script>");
			} else {
				rec.first();
                                session.setAttribute("sUserID",rec.getString("UserID"));
                                session.setAttribute("Type",rec.getString("Type"));
                                //ตรวจสอบประเภทผู้ใช้ตรงนี้
                                if(rec.getString("Type").equals("admin"))
                                        {
                                            response.sendRedirect("/BMPDev/admin/index.jsp");
                                        }
                                else if(rec.getInt("online")==0)
                                {
                                    String sql1 = "UPDATE member SET online = '1' WHERE UserID = "+rec.getString("UserID")+";";
                                    s.execute(sql1);
                                    response.sendRedirect("/BMPDev/user/index.jsp");
                                    
                                }else
                                {
                                    {
                                        out.print("<script>alert('มีคนเข้าระบบด้วยชื่อนี้แล้ว!')</script>");
                                        
                                    }
                                }
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
		
	
      out.write("\n");
      out.write("\n");
      out.write("<center>\t\n");
      out.write("<form  class=\"form-signin\" name=\"singupform\" method=\"post\" action=\"login.jsp?Action=Login\" onsubmit=\"return validateForm()\">\n");
      out.write("    <img src=\"../BMPDev/image/logo.png\" alt=\"Mountain View\" style=\"width:50%;height:50%;padding:5px\">\n");
      out.write("    <br>\n");
      out.write("  <table border=\"0\" style=\"width: 100%\">\n");
      out.write("    <tbody>\n");
      out.write("      <tr>\n");
      out.write("        <td>\n");
      out.write("          <div class=\"form-group\">\n");
      out.write("              <input name=\"txtUsername\" type=\"text\" id=\"txtUsername\" class=\"form-control\" placeholder=\"Username\" value=\"");
if(request.getParameter("txtUsername")!=null){out.print(request.getParameter("txtUsername"));}
      out.write("\">\n");
      out.write("          </div>\n");
      out.write("        </td>\n");
      out.write("      </tr>\n");
      out.write("      <tr>\n");
      out.write("        <td>\n");
      out.write("          <div class=\"form-group\">\n");
      out.write("              <input name=\"txtPassword\" type=\"password\" id=\"txtPassword\" class=\"form-control\" placeholder=\"Password\">\n");
      out.write("          </div>\n");
      out.write("        </td>\n");
      out.write("      </tr>\n");
      out.write("    </tbody>\n");
      out.write("  </table>\n");
      out.write("      <input type=\"checkbox\" class=\"pull-left\" name=\"checkbox\">\n");
      out.write("      <span class=\"pull-left\"><b>&nbsp;จำ Username และPassword</b></span>\n");
      out.write("  <br>\n");
      out.write("  <br>\n");
      out.write("  <button type=\"button\" class=\"pull-left btn btn-primary\"><i class=\"glyphicon glyphicon-user\"></i> สมัครใช้งาน</button> <button type=\"submit\" name=\"Submit\" value=\"Login\" class=\"pull-right btn btn-success\"><i class=\"glyphicon glyphicon-log-in\"></i> เข้าสู้ระบบ</button>\n");
      out.write("  <br>\n");
      out.write("</form>\n");
      out.write("</center>\n");
      out.write("<script>\n");
      out.write("    function validateForm() {\n");
      out.write("                var x = document.forms[\"singupform\"][\"txtUsername\"].value;\n");
      out.write("                var y = document.forms[\"singupform\"][\"txtPassword\"].value;\n");
      out.write("                if (x==\"\"||y==\"\") {\n");
      out.write("\t\t\t\talert( \"กรุณากรอกข้อมูล\");\n");
      out.write("                return false;\n");
      out.write("                }\n");
      out.write("                }\n");
      out.write("</script>\n");
      out.write("<hr>\n");
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
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
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
