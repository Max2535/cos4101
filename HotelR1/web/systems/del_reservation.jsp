<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //ลบรายการห้องที่เก็บไว้ชั่วคราว
    session = request.getSession();
    session.removeAttribute("room_list");
    session.removeAttribute("reservation");
    session.removeAttribute("guest");
    response.sendRedirect("index.jsp");
%>