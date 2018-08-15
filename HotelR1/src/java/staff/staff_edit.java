package staff;
//Class สำหรับแก้ไขข้อมูลผู้ใช้

import Systems.Condb;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "staff_edit", urlPatterns = {"/staff_edit"})
public class staff_edit extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String staff_id = request.getParameter("staff_id");
        String staff_code = request.getParameter("staff_code");
        String staff_name = request.getParameter("staff_name");
        String staff_idno = request.getParameter("staff_idno");
        String staff_email = request.getParameter("staff_email");
        String staff_tel = request.getParameter("staff_tel");
        String staff_address = request.getParameter("staff_address");
        String staff_type_id = request.getParameter("staff_type_id");
        String staff_status = request.getParameter("staff_status");
        Condb db = new Condb();
        String sql = "UPDATE `staff` SET `staff_name`='" + staff_name + "', `staff_address`='" + staff_address + "', `staff_email`='" + staff_email + "', `staff_tel`='" + staff_tel + "', `staff_code`='" + staff_code + "', `staff_type_id`='" + staff_type_id + "', `staff_idno`='" + staff_idno +"', `staff_status`='" + staff_status + "' WHERE `staff_id`='" + staff_id + "';";
        boolean flag = db.ConExecute(sql, "ตรวจสอบการรันคำสัง");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet staff_edit</title>");
            out.println("</head>");
            out.println("<body>");
            if (flag) {
                out.println("<script>\n"
                        + "    var r = confirm(\"ทำการแก้ไขข้อมูลพนักงานเรียบร้อยแล้ว!\");\n"
                        + "    if (r === true) {\n"
                        + "        location.href=\"systems/index3.jsp\";\n"
                        + "    } else {\n"
                        + "        location.href=\"systems/index3.jsp\";\n"
                        + "    }\n"
                        + "</script>");
            } else {
                out.println("<script>\n"
                        + "    var r = confirm(\"ทำการแก้ไขข้อมูลพนักงานไม่สำเร็จ!\");\n"
                        + "    if (r === true) {\n"
                        + "        location.href=\"systems/staff_edit.jsp\";\n"
                        + "    } else {\n"
                        + "        location.href=\"systems/staff_edit.jsp\";\n"
                        + "    }\n"
                        + "</script>");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "staff_edit";
    }// </editor-fold>

}
