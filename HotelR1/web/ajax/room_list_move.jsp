<%@page import="java.util.ArrayList"%>
<%@page import="ClassSystem.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    //เพิ่มห้องในรายการห้องพัก
    request.setCharacterEncoding("UTF-8");
    session = request.getSession();
    int size_room = Integer.parseInt(request.getParameter("size"));
    ArrayList<Room> room_list = (ArrayList<Room>) session.getAttribute("room_list");
    if (session.getAttribute("room_list") != null) {
        room_list = new ArrayList<Room>();
    }
    boolean flag = true;
    int room_id = Integer.parseInt(request.getParameter("room_id"));
    String extra_bed = request.getParameter("extra_bed");
    float price = 0.0f;
    if (request.getParameter("price") != null) {
        price = Float.parseFloat(request.getParameter("price"));
    }
    int room_type = 0;
    if (request.getParameter("room_type") != null) {
        room_type = Integer.parseInt(request.getParameter("room_type"));
    }
    String action = request.getParameter("action");
    if (action.equals("add")) {
        if (room_list.size() < size_room) {
            for (int index = 0; index < room_list.size(); index++) {
                if (room_list.get(index).getRoom_id() == room_id) {
                    flag = false;
                }
            }
            if (flag) {
                Reservation reservation = new Reservation();
                Room room = new Room();
                room = reservation.selectRoom(room_id, extra_bed, room_type, price);
                room_list.add(room);
            }
        } else {
            out.print(size_room + 1);//ตรวจสอบว่าเกินจำนวนที่ตั้งค่าไว้
        }
    } else if (action.equals("del")) {
        if (room_list.size() > 0) {
            for (int index = 0; index < room_list.size(); index++) {
                if (room_list.get(index).getRoom_id() == room_id) {
                    room_list.remove(index);
                }
            }
        } else {
            out.print(-1);
        }
    }
    System.out.println(room_list);
    session.setAttribute("room_list", room_list);
%>
