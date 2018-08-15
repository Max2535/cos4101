<%@page import="Systems.DateFunc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    DateFunc date = new DateFunc();
    //คำนวนวันว่าหว่างกันกี่วัน
    String start = request.getParameter("check_in");
    String end = request.getParameter("check_out");
    
    start = date.DateToMysql(start);
    end = date.DateToMysql(end);
    out.print(date.calDateDiff(end, start));
%>
