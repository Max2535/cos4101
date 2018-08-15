<%@page import="java.util.ArrayList"%>
<%@page import="ClassSystem.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    //เพิ่มห้องในรายการห้องพัก
    request.setCharacterEncoding("UTF-8");
    
    Reservation reservation = new Reservation();
    
    String reservation_id = request.getParameter("reservation_id");
    String room_id = request.getParameter("room_id");
    String extra_bed = request.getParameter("extra_bed");
    String action = request.getParameter("action");
    
    if(action != null&&action.equals("add")){
        reservation.addRoom(reservation_id, room_id, extra_bed,staff.getStaff_id());
    }else if(action.equals("del")){
        reservation.delRoom(reservation_id, room_id, extra_bed,staff.getStaff_id());
    }

%>
