package room_data;
//Class สำหรับแก้ไขข้อมูลห้อง

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
import javax.servlet.http.Part;

@WebServlet(urlPatterns = {"/room_edit"})
@MultipartConfig(maxFileSize = 16177215)//16 MB
public class room_edit extends HttpServlet {

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
        int room_id = Integer.parseInt(request.getParameter("room_id"));
        int room_type_id = Integer.parseInt(request.getParameter("room_type_id"));
        String room_code = request.getParameter("room_code");
        String room_status = request.getParameter("room_status");
        int room_price = Integer.parseInt(request.getParameter("room_price"));
        Part room_image = request.getPart("room_image");
        String flag = request.getParameter("flag");
        InputStream inputStream = null;
        if (room_image != null) {
            inputStream = room_image.getInputStream();
        }
        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(Data.databaseurl, Data.username, Data.password);
            if (flag.equals("true")) {//ตรวจสอบว่ามีการอัพโหลดรูปใหม่ไม่
                sql = "UPDATE `room` SET `room_type_id`=?, `room_price`=?,`room_code`=?, `room_status`=?, `room_image`=? WHERE `room_id`='" + room_id + "';";
            } else {
                sql = "UPDATE `room` SET `room_type_id`=?, `room_price`=?,`room_code`=?, `room_status`=? WHERE `room_id`='" + room_id + "';";
            }
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, room_type_id);
            statement.setInt(2, room_price);
            statement.setString(3, room_code);
            statement.setString(4, room_status);
            if (flag.equals("true")) {
                statement.setBlob(5, inputStream);
            }
            if (data.mode.equals("dev")) {
                System.out.print("SQL:->" + sql);
            }
            int row = statement.executeUpdate();
            if (row > 0) {
                response.sendRedirect("systems/index4.jsp?msg=ok");
            }
        } catch (SQLException ex) {
            if (data.mode.equals("dev")) {
                System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            }
            response.sendRedirect("systems/room_edit.jsp?room_id=" + room_id + "&msg=Error: " + ex.getMessage());
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
        return "room_edit";
    }

}
