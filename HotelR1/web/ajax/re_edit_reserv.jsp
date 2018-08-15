<%@page import="java.util.ArrayList"%>
<%@page import="ClassSystem.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
     session = request.getSession();
     String reservation_id = request.getParameter("reservation_id");
     String list = "";
     if(session.getAttribute("list")!=null){
         list = (String)session.getAttribute("list");
     }
     
     list += "0";
     
     Reservation reservation = new Reservation();
     String[] arr = list.split(",");
     int index = 0;
     reservation.clear(reservation_id);
     while (index <arr.length) {
         reservation.cancelEditReservation(reservation_id, arr[index]);
         index++;
     }
     response.sendRedirect("../systems/index2.jsp");
%>