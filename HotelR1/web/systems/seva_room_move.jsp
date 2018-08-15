<%@page import="ClassSystem.Reservation"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ClassSystem.Room"%>
<%@page import="ClassSystem.ConfigSystem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    request.setCharacterEncoding("UTF-8");
    session = request.getSession();
    String check_in = request.getParameter("check_in");
    String check_out = request.getParameter("check_out");

    if (request.getParameter("check_in") != null && request.getParameter("check_out") != null && request.getParameter("reservertion_id") != null) {
        ConfigSystem cog = new ConfigSystem();
        boolean flag = true;
        int size_room = Integer.parseInt(cog.GetConfig(3));
        ArrayList<Room> room_list = new ArrayList<Room>();
        Room room = new Room();

        ResultSet rs = room.searchRoomsForMove(check_in, check_out, request.getParameter("reservertion_id")); // ค้นหาห้องที่ว่าง
        while (rs.next()) {
            String room_temp = request.getParameter("room_" + rs.getString("room_id"));
            if (room_temp != null && room_temp.equals("on")) {
                //out.println("ผู้ใช้เลือกห้องนี้::" + rs.getString("room_id"));
                //out.println("ราคา::" + rs.getString("room_price"));
                String extra_bed_temp = request.getParameter("extra_bed_" + rs.getString("room_id"));
                boolean extra_bad = false;
                if (extra_bed_temp != null && extra_bed_temp.equals("on")) {
                    //out.println("สานะเตียงเสริม::" + extra_bed_temp);
                    extra_bad = true;
                }
                //out.println("ประเภทห้องพัก::" + rs.getString("room_type_id"));
                Reservation reservation = new Reservation();
                Room room_add = new Room();
                room_add = reservation.selectRoom(Integer.parseInt(rs.getString("room_id")), extra_bad + "", Integer.parseInt(rs.getString("room_type_id")), Float.parseFloat(rs.getString("room_price")),rs.getString("room_code"));
                room_list.add(room_add);
            }
        }
        Reservation reservation = new Reservation();
        ResultSet rs1 = reservation.GetReservationDetail(request.getParameter("reservertion_id"));
        int size = 0;
        while (rs1.next()) {
            size++;
        }
        if (room_list.size() > size) {
            response.sendRedirect("room_list_for_move.jsp?check_in=" + check_in + "&check_out=" + check_out + "&size=size"+ request.getParameter("check_out") + "&reservertion_id=" + request.getParameter("reservertion_id"));
        } else {
            session.setAttribute("room_list", room_list);
            response.sendRedirect("form_move.jsp?check_in=" + request.getParameter("check_in") + "&check_out=" + request.getParameter("check_out") + "&reservertion_id=" + request.getParameter("reservertion_id"));
        }

    } else {
        //alert

        response.sendRedirect("room_list_for_move.jsp?check_in=" + check_in + "&check_out=" + check_out + "&error=no");
    }

%>
