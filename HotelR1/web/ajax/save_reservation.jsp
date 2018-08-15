<%@page import="Systems.DateFunc"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    //บันทึกข้อมูลใบสำรองห้องพัก
    request.setCharacterEncoding("UTF-8");
    session = request.getSession();
    String guest_id = request.getParameter("guest_id");
    Condb db = new Condb();
    String sql = "";
    ResultSet rs = null;
    ArrayList<Room> room_list = null;
    Reservation reservation = new Reservation();
    if (session.getAttribute("room_list") != null) {
        room_list = (ArrayList<Room>) session.getAttribute("room_list");
    }
    if (session.getAttribute("reservation") != null) {
        reservation = (Reservation) session.getAttribute("reservation");
    }
    if (room_list != null && staff != null && reservation != null && room_list.size() > 0) {

        out.print(reservation.saveReservation(reservation.getReservertion_id() + "", staff.getStaff_id() + "", reservation.getCheck_in(), reservation.getCheck_out(), reservation.getPrice_reservation() + "", reservation.getStatus_reservation(), reservation.getStatus_pay(), room_list, guest_id, reservation.getPrice_total()));

    } else {
        out.print(-1);
    }
%>