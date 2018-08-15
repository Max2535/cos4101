<%@page import="ClassSystem.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    session = request.getSession();
    Staff staff = new Staff();
    boolean flag_login ;
    
    if (session.getAttribute("flag_login") != null) {
        flag_login = (Boolean) session.getAttribute("flag_login");
        if (!flag_login) {
            response.sendRedirect("../systems/look.jsp");
        }
    }
    
    if (session.getAttribute("staff") != null) {
        staff = (Staff)session.getAttribute("staff");
    } else {
        //session.invalidate();
        response.sendRedirect("login.jsp");
    }
%>