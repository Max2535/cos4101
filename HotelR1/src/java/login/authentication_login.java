package login;

import ClassSystem.*;
import ClassSystem.Authentication;
import ClassSystem.ConfigSystem;
import ClassSystem.Dashboard;
import ClassSystem.Log;
import ClassSystem.Staff;
import Systems.Condb;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "authentication_login", urlPatterns = {"/authentication_login"})
public class authentication_login extends HttpServlet {

    Condb db = new Condb();
    HttpSession session = null;
    ResultSet rs = null;
    boolean flag_login = false;
    Staff staff = new Staff();
    String msg = "";
    ConfigSystem cog = new ConfigSystem();
    Authentication authentication = new Authentication();

    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String staff_code = request.getParameter("staff_code");
        session = request.getSession();//ดึง session ออกมาก
        int loginnumber = 0;//จำนวนครั้งในการ login        
        if (session.getAttribute("loginnumber") != null) {
            loginnumber = (Integer) session.getAttribute("loginnumber");
        }
        if (session.getAttribute("flag_login") != null) {//ตรวจสอบว่าสามารถ login ได้ไม่
            flag_login = (Boolean) session.getAttribute("flag_login");
        }
        if (loginnumber == (Integer.parseInt(cog.GetConfig(2)) - 1)) {//ตรวจสอบจำนวนครั้งที่login ว่าเท่ากับจำนวนทีตั้งค่าไว้หรอยัง
            flag_login = false;
            loginnumber = 0;
            response.sendRedirect("systems/look.jsp");
        }
        try {
            if (staff_code.length() == (Integer.parseInt(cog.GetConfig(1)))) {//ตรวจสอบความยาว ว่าเท่ากับจำนวนทีตั้งค่าไว้หรอยัง
                rs = authentication.login(staff_code);
                if (rs.first()) {
                    staff.setStaff_code(rs.getString("staff_code"));
                    staff.setStaff_id(rs.getInt("staff_id"));
                    staff.setStaff_name(rs.getString("staff_name"));
                    staff.setStaff_type_id(rs.getInt("staff_type_id"));
                    session.setAttribute("staff", staff);
                    flag_login = true;
                    Log.SeveLog(staff.getStaff_id(), "ทำการ Login สำเร็จ", "Authentication (Login)");
                    Dashboard dashboard = new Dashboard();
                    String temp = "systems/dashboard.jsp";
                    temp = dashboard.Showmenu();
                    Log.Login(staff.getStaff_id());
                    response.sendRedirect(temp);//show dashboard()
                } else {
                    loginnumber++;
                    msg = "รหัสพนักงานผิด หรือมีสถานะเป็น Inactive";
                    Log.SeveLog(staff.getStaff_id(), "ทำการ Login ไม่สำเร็จ " + msg + ":" + staff_code + " ครั้งที่ " + loginnumber, "Authentication(Log in)");
                }
            } else {
                msg = "รหัสไม่ถูกต้อง";
                loginnumber++;
                flag_login = false;
                Log.SeveLog(staff.getStaff_id(), "ทำการ Login ไม่สำเร็จ " + msg + ":" + staff_code + " ครั้งที่ " + loginnumber, "Authentication(Log in)");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
        }
        msg += " จำนวนที่ทำการ login:";
        session.setAttribute("loginnumber", loginnumber);
        session.setAttribute("flag_login", flag_login);
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Check Login</title>");
            out.println("</head>");
            out.println("<body>");
            if (flag_login) {
                out.println("<div>กำลังเปลื่ยนเส้นทาง...</div>\n"
                        + "        <script>\n"
                        + "                document.location.href=\"systems/dashboard.jsp\";\n"
                        + "        </script>");
            } else {
                out.print("<script>    var r = confirm(\"" + msg + ":" + loginnumber + "\");\n"
                        + "    if (r == true) {\n"
                        + "        window.history.back();\n"
                        + "    } else {\n"
                        + "        window.history.back();\n"
                        + "    }</script>");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        login(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        login(request, response);
    }

    @Override
    public String getServletInfo() {
        return "login";
    }// </editor-fold>

}
