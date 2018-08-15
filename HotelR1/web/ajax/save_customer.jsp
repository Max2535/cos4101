<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page import="ClassSystem.Guest"%>
<%@page import="javax.json.Json"%>
<%@page import="javax.json.JsonObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    //บันทึกข้อมูลลูกค้า
    request.setCharacterEncoding("UTF-8");
    session = request.getSession();
    response.setContentType("application/json");
    Guest guest = new Guest();
    String guest_name = request.getParameter("guest_name");
    String guest_idno = request.getParameter("guest_idno");
    String guest_email = request.getParameter("guest_email");
    String guest_phone = request.getParameter("guest_phone");
    String guest_address = request.getParameter("guest_address");
    String flag = request.getParameter("flag");
    String sql = "";
    if (guest_name.length() != 0 && guest_idno.length() != 0 && guest_email.length() != 0 && guest_phone.length() != 0 && guest_address.length() != 0) {
        if (flag.equals("insert")) {
            Condb db = new Condb();
            ResultSet rs = db.ConExecuteQuery("SELECT COUNT(*) as size FROM guest");
            rs.first();
            int guest_id = rs.getInt("size");
            if (guest_id == 0) {
                guest_id = 1;
            } else {
                guest_id++;
            }
            guest.SaveGuest(guest_id, guest_name, guest_address, guest_email, guest_phone, guest_idno);
            out.print(guest_id);
        } else if (flag.equals("update")) {
            out.print(guest.UpdateGuest(Integer.parseInt(request.getParameter("guest_id")), guest_name, guest_address, guest_email, guest_phone, guest_idno));
        }
    } else {
        out.print(-1);
    }
%>
