<%@page import="Systems.DateFunc"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    
    //บันทึกข้อมูลใบสำรองห้องพัก
    request.setCharacterEncoding("UTF-8");
    session = request.getSession();
    Condb db = new Condb();
    String sql = "SELECT COUNT(*) as size FROM reservation";
    ResultSet rs = db.ConExecuteQuery(sql);
    rs.first();
    int reservertion_id = Integer.parseInt(rs.getString("size"));
    if (reservertion_id == 0) {
        reservertion_id = 1;
    } else {
        reservertion_id++;
    }
    DateFunc date = new DateFunc();
    ArrayList<Room> room_list = new ArrayList<Room>();
    if (session.getAttribute("room_list") != null) {
        room_list = (ArrayList<Room>) session.getAttribute("room_list");
    }
    Guest guest = new Guest();
    if (session.getAttribute("guest") != null) {
        guest = (Guest) session.getAttribute("guest");
    }
    Reservation reservation = new Reservation();
    if (session.getAttribute("reservation") != null) {
        reservation = (Reservation) session.getAttribute("reservation");
    }
    if (room_list != null && staff != null && guest != null && reservation != null && room_list.size() > 0) {
        out.print(reservation.saveReservation(reservertion_id+"",staff.getStaff_id()+"",reservation.getCheck_in(),reservation.getCheck_out(),reservation.getPrice_reservation()+"",reservation.getStatus_reservation(),reservation.getStatus_pay(),room_list,guest.getGuest_id()+"",reservation.getPrice_total()));
        db.ConExecute("UPDATE `reservation` SET `move_room`='true' WHERE `reservertion_id`='"+reservertion_id+"'");
        session.removeAttribute("room_list");
        session.removeAttribute("guest");
        session.removeAttribute("reservation");
    } else {
        out.print(-1);
    }
%>