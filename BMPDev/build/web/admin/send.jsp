<%-- 
    Document   : send
    Created on : Aug 15, 2017, 11:51:04 AM
    Author     : Max
--%>
<%@page import="data.GmailSender"%>
<%
        Object strUserID = session.getAttribute("sUserID");
        Object Type = session.getAttribute("Type");
	if(strUserID == null&&Type==null) // Check Login
	{
            response.sendRedirect("/BMPDev/index.jsp"); 
            out.print("<script>alert('คุณยังไม่ได้เข้าสู้ระบบ กรุณาเข้าสู่ระบบด้วย');</script>");
                             
	}
        else if(!Type.equals("admin"))
                {
                  response.sendRedirect("/BMPDev/index.jsp");
                }
        %>
<%@page import="data.configmysql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
	<title></title>
</head>
<body>
	
	<%	
		
		String Email = request.getParameter("Email");
                GmailSender sender = new GmailSender();
                sender.setSender("kalmro4@gmail.com", "03042532mm");
                sender.addRecipient(Email);
                sender.setSubject("ทดสอบส่ง E-mail");
                sender.setBody("วิชา Cos4101");
                sender.send();
                session.setAttribute("Send","ส่งไปหา "+Email+" เรียบร้อยแล้ว");
                response.sendRedirect("/BMPDev/admin/index.jsp");
	%>
</body>
</html>
