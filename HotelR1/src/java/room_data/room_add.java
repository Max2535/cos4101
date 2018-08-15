package room_data;
//Class สำหรับเพิ่มข้อมูลห้อง

import ClassSystem.Log;
import ClassSystem.Room;
import ClassSystem.Staff;
import Systems.Data;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(urlPatterns = {"/room_add"})
@MultipartConfig(maxFileSize = 16177215)//16 MB
public class room_add extends HttpServlet {

    String sql = null;
    Connection conn = null;
    String message = null;
    Data data = new Data();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        //********************* เพิ่มใหม่ *******************************
        HttpSession session = request.getSession();
        Staff staff = new Staff();
        if (session.getAttribute("staff") != null) {
            staff = (Staff) session.getAttribute("staff");
        }
        //********************* เพิ่มใหม่ *******************************

        Room room = new Room();
        //room.setRoom_id(Integer.parseInt(request.getParameter("room_id")));
        room.setRoom_code(request.getParameter("room_code"));
        room.setRoom_type_id(Integer.parseInt(request.getParameter("room_type_id")));
        room.setRoom_price(Float.parseFloat(request.getParameter("room_price")));
        room.setRoom_status("เปิดให้เข้าพัก");
        Part room_image = request.getPart("room_image");

        //********************* เพิ่มใหม่ *******************************
        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            int row = 0;
            //if (Room.checkRoom_id(Integer.parseInt(request.getParameter("room_id")))) {
            if (true) {
                row = Room.addRoom(room, room_image, staff.getStaff_id());
                Log.SeveLog(staff.getStaff_id(), "เพิ่มข้อมูลห้องพักสำเร็จ หมายเลขห้องพักที่ : " + room.getRoom_code(), "เพิ่มข้อมูลห้องพัก");
                response.sendRedirect("systems/index4.jsp?msg=yes");
            } else {
                Log.SeveLog(staff.getStaff_id(), "เพิ่มข้อมูลห้องพักล้มเหลว เนื่องจากหมายเลขห้องซ้ำ", "เพิ่มข้อมูลห้องพัก");
                response.sendRedirect("systems/room_add.jsp?msg=no");
            }
            if (data.mode.equals("dev")) {
                System.out.print("SQL:->" + sql);
            }

        } catch (SQLException ex) {
            if (data.mode.equals("dev")) {
                System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            }
            response.sendRedirect("systems/room_add.jsp?msg=Error: " + ex.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    if (data.mode.equals("dev")) {
                        System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
                    }
                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "room_add";
    }

}
