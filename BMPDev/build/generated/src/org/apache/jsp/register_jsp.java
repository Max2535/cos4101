package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import data.delcountpage;
import data.configmysql;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;

public final class register_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 request.setCharacterEncoding("UTF-8"); 
      out.write('\n');

    Object Page = session.getAttribute("Page");
    if(Page == null)
    {
    
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
                        if(tmp>5){
                             response.sendRedirect("/BMPDev/full.jsp");
                        }
                        tmp++;
                        //UPDATE `pageconut` SET `conut` = '5' WHERE `pageconut`.`id` = 1;
                        String sql = "UPDATE `pageconut` SET `count` = '"+tmp+"' WHERE `id` = 1";
                        s1.execute(sql);
                        session.setAttribute("Page","Y");
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
	
      out.write("  \n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"utf-8\">\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <meta name=\"description\" content=\"\">\n");
      out.write("    <meta name=\"author\" content=\"\">\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jquery.js\"></script>\n");
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
      out.write("       <!-- This is what you need -->\n");
      out.write("        <script src=\"http://numnim.96.lt/dist/sweetalert-dev.js\"></script>\n");
      out.write("        <link rel=\"stylesheet\" href=\"http://numnim.96.lt/dist/sweetalert.css\">\n");
      out.write("    <style>\n");
      out.write("        footer{\n");
      out.write("            margin-left: 15%;\n");
      out.write("        }\n");
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
      out.write("        #time {\n");
      out.write("\tborder: 3px solid #73AD21;\n");
      out.write("        position: center;\n");
      out.write("        padding: 5px;\n");
      out.write("        top: 10px;\n");
      out.write("        margin-bottom: 20px;\n");
      out.write("        width: 300px;\n");
      out.write("        text-align: center;\n");
      out.write("        color: #000000;\n");
      out.write("        font-size: 15px;\n");
      out.write("        font-family: \"Calibri\", \"Trebuchet MS\", sans-serif;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("    <script type='text/javascript'>//<![CDATA[\n");
      out.write("jQuery(function ($) {\n");
      out.write("    var fiveMinutes = 60 * 5,\n");
      out.write("        display = $('#time');\n");
      out.write("    startTimer(fiveMinutes, display);\n");
      out.write("});\n");
      out.write("function startTimer(duration, display) {\n");
      out.write("    var timer = duration, minutes, seconds;\n");
      out.write("    setInterval(function () {\n");
      out.write("        minutes = parseInt(timer / 60, 10)\n");
      out.write("        seconds = parseInt(timer % 60, 10);\n");
      out.write("\n");
      out.write("        minutes = minutes < 10 ? \"0\" + minutes : minutes;\n");
      out.write("        seconds = seconds < 10 ? \"0\" + seconds : seconds;\n");
      out.write("\n");
      out.write("        display.text(\"เวลาคงเหลือ \"+minutes + \":\" + seconds);\n");
      out.write("\n");
      out.write("        if (--timer < 0) {\n");
      out.write("            timer = duration;\n");
      out.write("        }\n");
      out.write("\t\tif(timer==0)\n");
      out.write("\t\t{\n");
      out.write("\t\tswal({\n");
      out.write("  title: \"เวลาหมด\",\n");
      out.write("  text: \"ต้องการสมัครต่อหรือไม่\",\n");
      out.write("  type: \"warning\",\n");
      out.write("  showCancelButton: true,\n");
      out.write("  confirmButtonColor: \"#DD6B55\",\n");
      out.write("  confirmButtonText: \"สมัครต่อ\",\n");
      out.write("  cancelButtonText: \"กลับหน้าเว็บไซต์\",\n");
      out.write("  closeOnConfirm: false,\n");
      out.write("  closeOnCancel: false\n");
      out.write("},\n");
      out.write("function(isConfirm){\n");
      out.write("  if (isConfirm) {\n");
      out.write("    window.location.href = 'http://localhost:8888/BMPDev/register.jsp';\n");
      out.write("  } else {\n");
      out.write("    //window.location.href = 'http://localhost:8888/BMPDev/delcount.jsp';\n");
      out.write("    ");

    out.print("del");
    //delcountpage.del();
      out.write("\n");
      out.write("  }\n");
      out.write("});\n");
      out.write("\t\t}\n");
      out.write("    }, 1000);\n");
      out.write("}\n");
      out.write("//]]> \n");
      out.write("\n");
      out.write("</script>\n");
      out.write("\n");
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
		

      out.write("\n");
      out.write("<center>\n");
      out.write("    <span id=\"time\"></span>\n");
      out.write("    <br>\n");
      out.write("    <br>\n");
      out.write("    <form role=\"form\" class=\"form-signin\" name=\"singinform\" onsubmit=\"return validateForm()\">\n");
      out.write("    <table border=\"0\" style=\"width: 100%\">\n");
      out.write("    <tbody>\n");
      out.write("      <tr>\n");
      out.write("        <td>\n");
      out.write("          <div class=\"form-group input-group\">\n");
      out.write("              <span class=\"input-group-addon\"><i class=\"glyphicon glyphicon-user\"></i></span>\n");
      out.write("              <input type=\"text\" name=\"username\" class=\"form-control\" placeholder=\"Username\" autofocus>\n");
      out.write("        </div>\n");
      out.write("        </td>\n");
      out.write("      </tr>\n");
      out.write("      <tr>\n");
      out.write("        <td>\n");
      out.write("          <div class=\"form-group input-group\">\n");
      out.write("            <span class=\"input-group-addon\"><i class=\"glyphicon glyphicon-inbox\"></i></span>\n");
      out.write("            <input type=\"text\" name=\"email\" class=\"form-control\" placeholder=\"E-mail\">\n");
      out.write("        </div>\n");
      out.write("        </td>\n");
      out.write("      </tr>\n");
      out.write("      <tr>\n");
      out.write("        <td>\n");
      out.write("            <div class=\"form-group input-group\">\n");
      out.write("                <span class=\"input-group-addon\"><i class=\"glyphicon glyphicon-asterisk\"></i></span>\n");
      out.write("                <input type=\"password\" name=\"p1\" class=\"form-control\" placeholder=\"Password\">\n");
      out.write("            </div>\n");
      out.write("        </td>\n");
      out.write("      </tr>\n");
      out.write("      <tr>\n");
      out.write("        <td>\n");
      out.write("            <div class=\"form-group input-group\">\n");
      out.write("                <span class=\"input-group-addon\"><i class=\"glyphicon glyphicon-asterisk\"></i></span>\n");
      out.write("                <input type=\"password\" name=\"p2\" class=\"form-control\" placeholder=\"Confirm Password\">\n");
      out.write("            </div>\n");
      out.write("        </td>\n");
      out.write("      </tr>\n");
      out.write("      <tr>\n");
      out.write("        <td>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <input type=\"file\" name=\"fileUpload\" class=\"form-control\">\n");
      out.write("            </div>\n");
      out.write("        </td>\n");
      out.write("      </tr>\n");
      out.write("    </tbody>\n");
      out.write("    </table>\n");
      out.write("    <br>\n");
      out.write("    <br>\n");
      out.write("    <button type=\"submit\" name=\"Submit\" value=\"Singup\" class=\"pull-right btn btn-success\"><i class=\"glyphicon glyphicon-log-in\"></i> สมัครใช้งาน</button>\n");
      out.write("    <br>\n");
      out.write("    </form>\n");
      out.write("</center>\n");
      out.write("<script>\n");
      out.write("    function validateForm() {\n");
      out.write("                var x = document.forms[\"singinform\"][\"p1\"].value;\n");
      out.write("                var y = document.forms[\"singinform\"][\"p2\"].value;\n");
      out.write("                var z = document.forms[\"singinform\"][\"username\"].value;\n");
      out.write("                var w = document.forms[\"singinform\"][\"email\"].value;\n");
      out.write("                if (x===\"\"||y===\"\"||z===\"\"||w===\"\") \n");
      out.write("                {\n");
      out.write("                    sweetAlert(\"Oops...\", \"กรุณาป้อนข้อมูลให้ครบด้วย\", \"error\");\n");
      out.write("                    return false;\n");
      out.write("                }\n");
      out.write("                var atpos = w.indexOf(\"@\");\n");
      out.write("                var dotpos = w.lastIndexOf(\".\");\n");
      out.write("                if (atpos<1 || dotpos<atpos+2 || dotpos+2>=w.length) \n");
      out.write("                    {\n");
      out.write("                        sweetAlert(\"Oops...\", \"E-Mail ไม่ถูกต้อง\", \"error\");\n");
      out.write("                        return false;\n");
      out.write("                    }\n");
      out.write("                if (x!==y)\n");
      out.write("                {\n");
      out.write("                    sweetAlert(\"Oops...\", \"รหัสผ่านไม่ตรงกัน\", \"error\");\n");
      out.write("                    return false;\n");
      out.write("                }\n");
      out.write("            }     \n");
      out.write("</script>\n");
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
