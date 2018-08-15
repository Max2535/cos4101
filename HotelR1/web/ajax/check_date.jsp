<%@page import="ClassSystem.Reservation"%>
<%@page import="Systems.DateFunc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    request.setCharacterEncoding("UTF-8");
    //ตรวจสอบวันย้อนหลัง
    int flag = -1;
    
    DateFunc date = new DateFunc();
    String check_in = request.getParameter("check_in");
    String check_out = request.getParameter("check_out");
    //check_in
    check_in = date.DateToMysql(check_in);
    System.out.println("--------------------------- check in = " + check_in);
    //check_out
    check_out = date.DateToMysql(check_out);
    System.out.println("--------------------------- check out = " + check_out);
    String now = date.getDate(0);
    
    now = date.DateToMysql(now);
    date.calDateDiff(check_in, now);
    
    if ((date.calDateDiff(check_in, now) >= 0 && date.calDateDiff(check_out, now) >= 0)) {
        Reservation reservation = new Reservation();
        flag = reservation.selectCheckInAndCheckOut();
    } else {
        flag = -1;
    }
    
    out.print("" + flag);
%>
