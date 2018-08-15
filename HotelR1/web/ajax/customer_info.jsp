<%@page import="ClassSystem.Guest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page import="javax.json.Json"%>
<%@page import="javax.json.JsonObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    //ค้นหาข้อมูล ลูกค้าและส่งกับไปในรูปแบบ JSON
    session = request.getSession();
    Condb db = new Condb();
    Guest guest = new Guest();
    String idno = "";
    if (request.getParameter("idno") != null) {
        idno = request.getParameter("idno");
    }
    ResultSet rs = guest.GuestInfo(idno);
    JsonObject personObject;
    if (rs.first()) {
        guest.setGuest_id(rs.getInt("guest_id"));
        guest.setGuest_name(rs.getString("guest_name"));
        guest.setGuest_idno(rs.getString("guest_idno"));
        guest.setGuest_email(rs.getString("guest_email"));
        guest.setGuest_phone(rs.getString("guest_phone"));
        guest.setGuest_address(rs.getString("guest_address"));
        personObject = Json.createObjectBuilder()
                .add("guest_id", rs.getInt("guest_id"))
                .add("guest_name", rs.getString("guest_name"))
                .add("guest_idno", rs.getString("guest_idno"))
                .add("guest_email", rs.getString("guest_email"))
                .add("guest_phone", rs.getString("guest_phone"))
                .add("guest_address", rs.getString("guest_address")).build();
        out.print(personObject);
        session.setAttribute("guest", guest);
    } else {
        out.print(-1);
    }
%>
