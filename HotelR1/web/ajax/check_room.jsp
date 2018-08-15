<%@page import="Systems.DateFunc"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%
    session = request.getSession();
    ArrayList<Room> room_list = (ArrayList<Room>) session.getAttribute("room_list");
    if (room_list != null) {
        out.print(room_list.size());
    } else {
        out.print("0");
    }

%>