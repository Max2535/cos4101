<%@page import="Systems.DateFunc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    //บอกวันตามจำนวนที่ตามการ
    int i = Integer.parseInt(request.getParameter("date"));
    String due_date = request.getParameter("due_date");
    DateFunc date = new DateFunc();
    out.print(date.getDate2(due_date, i));
%>