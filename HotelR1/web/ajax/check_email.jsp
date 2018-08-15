<%@page import="ClassSystem.Email"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    
    request.setCharacterEncoding("UTF-8");
    //ตรวจสอบว่ามีอีเมล์ที่ยังไม่ได้อ่านหรือไม่
    Email email =new Email();
    out.print(email.ReceiverEmail());
%>
