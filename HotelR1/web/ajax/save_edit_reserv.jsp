<%@page import="java.util.ArrayList"%>
<%@page import="ClassSystem.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    Reservation reservation = new Reservation();
    
    String reservation_id = request.getParameter("reservation_id");
    String[] extra_bed = request.getParameterValues("extra_bed");
    String[] clear_extra_bed = request.getParameterValues("clear_extra_bed");
    
    int status1 = reservation.setStaffEdit(staff.getStaff_id(), reservation_id);
    int status2 = reservation.clearEditRreservation(clear_extra_bed);
    int status3 = reservation.saveEditReservation(staff.getStaff_id(), reservation_id, extra_bed);
    int status4 = reservation.priceTotal(reservation_id);
    
    if (status3 == 1) {
        Log.SeveLog(staff.getStaff_id(), "แก้ไขใบสำรองห้องพักสำเร็จ ใบสำรองหมายเลขที่ : " + reservation_id + " ", " แก้ไขใบสำรอง");
    }
    
    response.sendRedirect("../systems/index2.jsp");
%>