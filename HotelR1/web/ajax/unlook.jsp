<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //ปลดล็อคการLogin
    session = request.getSession();
    session.invalidate();
    response.sendRedirect("../systems/login.jsp");
%>