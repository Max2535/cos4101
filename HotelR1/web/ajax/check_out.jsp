<%@page import="ClassSystem.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%  
    request.setCharacterEncoding("UTF-8");
    
    String reservation_id = request.getParameter("reservertion_id");
    String note = request.getParameter("note");
    String type = request.getParameter("type");
    
    Reservation reservation = new Reservation();
    out.print(reservation.checkOutReservation(staff.getStaff_id(), reservation_id, note, type) );
%>