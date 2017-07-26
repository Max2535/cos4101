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

public final class profile_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 request.setCharacterEncoding("UTF-8"); 
      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("\t<title>ThaiCreate.Com JSP Tutorial</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\t\n");
      out.write("\t");

	Object strUserID = session.getAttribute("sUserID");
        Object Type = session.getAttribute("Type");
	if(strUserID == null&&Type==null) // Check Login
	{
		//response.sendRedirect("index.jsp");
                out.print("Error");
	}
	
	Connection connect = null;
	Statement s = null;
	
	try {
		Class.forName(configmysql.mysqljdbc);		
		connect =  DriverManager.getConnection(configmysql.mysqlserver);                
		s = connect.createStatement();
		
		String sql = "SELECT * FROM  member WHERE UserID = '" + strUserID.toString() + "' ";
		
		ResultSet rec = s.executeQuery(sql);
		if(rec.next())
		{
		
      out.write("\n");
      out.write("\t\t\n");
      out.write("\t\t\t Profile<br>\n");
      out.write("\t\t\t  <table border=\"1\" style=\"width: 300px\">\n");
      out.write("\t\t\t    <tbody>\n");
      out.write("\t\t\t      <tr>\n");
      out.write("\t\t\t        <td> &nbsp;UserID</td>\n");
      out.write("\t\t\t        <td>\n");
      out.write("\t\t\t          ");
      out.print(rec.getString("UserID") );
      out.write("\n");
      out.write("\t\t\t        </td>\n");
      out.write("\t\t\t      </tr>\n");
      out.write("\t\t\t      <tr>\n");
      out.write("\t\t\t        <td> &nbsp;Username</td>\n");
      out.write("\t\t\t        <td>\n");
      out.write("\t\t\t          ");
      out.print(rec.getString("Username") );
      out.write("\n");
      out.write("\t\t\t        </td>\n");
      out.write("\t\t\t      </tr>\n");
      out.write("\t\t\t      <tr>\n");
      out.write("\t\t\t        <td> &nbsp;Password</td>\n");
      out.write("\t\t\t        <td>\n");
      out.write("\t\t\t          ");
      out.print(rec.getString("Password") );
      out.write("\n");
      out.write("\t\t\t        </td>\n");
      out.write("\t\t\t      </tr>\n");
      out.write("\t\t\t      <tr>\n");
      out.write("\t\t\t        <td> &nbsp;Email</td>\n");
      out.write("\t\t\t        <td>\n");
      out.write("\t\t\t          ");
      out.print(rec.getString("Email") );
      out.write("\n");
      out.write("\t\t\t        </td>\n");
      out.write("\t\t\t      </tr>\t\t\n");
      out.write("\t\t\t      <tr>\n");
      out.write("\t\t\t        <td> &nbsp;Name</td>\n");
      out.write("\t\t\t        <td>\n");
      out.write("\t\t\t          ");
      out.print(rec.getString("Name") );
      out.write(":::::: ");
      out.print(Type.toString() );
      out.write("\n");
      out.write("\t\t\t        </td>\n");
      out.write("\t\t\t      </tr>\t   \n");
      out.write("\t\t\t    </tbody>\n");
      out.write("\t\t\t  </table>\n");
      out.write("\t\t\t  <br>\t\n");
      out.write("\t     ");
} 
      out.write("\n");
      out.write("\t    ");
	
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
