<%@page import="ClassSystem.*"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    String reservation_id = request.getParameter("reservation_id");
    String note = request.getParameter("note");
    String type = request.getParameter("type");
    
    Reservation reservation = new Reservation();
    int status = reservation.cancelReservation(staff.getStaff_id(), reservation_id, note, type);
    out.print(status);
   // response.sendRedirect("../systems/index2.jsp");
    //response.sendRedirect("../systems/index3.jsp?msg=yes");
    //out.print(1);
    //out.print(reservation.cancelReservation(staff.getStaff_id(), reservation_id, note, type));
    //response.sendRedirect("../systems/index2.jsp");
%>
