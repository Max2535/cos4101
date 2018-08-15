<%@page import="java.util.ArrayList"%>
<%@page import="ClassSystem.Room"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    //เพิ่มเตียงเสริม
    session = request.getSession();
    ArrayList<Room> room_list = new ArrayList<Room>();
    if (session.getAttribute("room_list") != null) {
        room_list = (ArrayList<Room>) session.getAttribute("room_list");
        int room_id = Integer.parseInt(request.getParameter("room_id"));
        if (room_list.size() > 0) {
            for (int index = 0; index < room_list.size(); index++) {
                if (room_list.get(index).getRoom_id() == room_id) {
                    room_list.get(index).setExtra_bed("true");
                    out.print("ทำการเพิ่มเตียงเสริมเรียบร้อยแล้ว");
                }
            }
        }
        session.setAttribute("room_list", room_list);
    }
%>
