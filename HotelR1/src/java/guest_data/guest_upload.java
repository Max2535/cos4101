package guest_data;
//Class สำหรับอัพโหลด หลักฐาน

import ClassSystem.Guest;
import ClassSystem.Reservation;
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

@WebServlet(urlPatterns = {"/guest_upload"})
@MultipartConfig(maxFileSize = 16177215)//16 MB
public class guest_upload extends HttpServlet {

    String sql = null;
    Connection conn = null;
    PreparedStatement statement = null;
    Data data = new Data();
    Reservation reservation = new Reservation();
    Guest guest = new Guest();
    
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
        
        HttpSession session = request.getSession();
        Staff staff = new Staff();
        if (session.getAttribute("staff") != null) {
            staff = (Staff)session.getAttribute("staff");
        }
        
        String guest_id = request.getParameter("guest_id");
        Part guest_image = request.getPart("guest_image");
        String flag = request.getParameter("flag");
        String isupload = request.getParameter("isupload");
        String reservertion_id = request.getParameter("reservertion_id");
        InputStream guest_image_input = null;
        
        if (guest_image != null) {
            guest_image_input = guest_image.getInputStream();
        } else {
            response.sendRedirect("systems/check_in.jsp?msg=image_fail");
        }
        
        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(Data.databaseurl, Data.username, Data.password);
            String msg = "";
            
            if (isupload.equals("true")) {
                //จะมีการอัพโหลดรูป
                int row = guest.uploadImage(guest_id, guest_image_input);
                if (row > 0) {
                    msg = "อัพโหลดไฟล์รูปภาพแล้ว";
                }
                if (data.mode.equals("dev")) {
                    System.out.print("SQL:->" + sql);
                }
            } else {
                msg = "มีไฟล์รูปภาพแล้ว";
            }
            //เปลื่ยนสถานะ รอลงทะเบียนเข้าพักเป็น ส่งส่งห้องพัก
            if (flag.equals("true")) {
                int row = reservation.checkInReservation(reservertion_id, staff.getStaff_id());
                if (row > 0) {
                    msg += "ลงทะเบียนเข้าพักสำเร็จ";
                }
            }
            if (data.mode.equals("dev")) {
                System.out.print("SQL:->" + sql);
                System.out.print(msg);
            }
            response.sendRedirect("systems/index2.jsp?msg=ok");
        } catch (SQLException ex) {
            if (data.mode.equals("dev")) {
                System.out.print("ทำการอัพโหลดข้อมูลไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            }
            response.sendRedirect("systems/check_in.jsp?reservertion_id=" + request.getParameter("reservertion_id") + "&msg=Error: " + ex.getMessage());
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
        return "guest_upload";
    }

}
