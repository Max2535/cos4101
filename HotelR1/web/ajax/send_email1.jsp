<%@page import="java.sql.ResultSet"%>
<%@page import="ClassSystem.*"%>
<%@page import="Systems.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%    
//ส่งอีเมล์หาลูกค้า
    request.setCharacterEncoding("UTF-8");
    session = request.getSession();
    DateFunc date = new DateFunc();
    String msg = null;
    Guest guest = new Guest();
    Condb db=new Condb();
    ResultSet rs=null;
    String email = request.getParameter("email");
    ArrayList<Room> room_list = new ArrayList<Room>();    
    Reservation reservation = new Reservation();
    if (session.getAttribute("room_list") != null) {//ดึงข้อมูลห้องออกมาจาก session
        room_list = (ArrayList<Room>) session.getAttribute("room_list");
    }
    if (session.getAttribute("guest") != null) {//ดึงข้อมูลูกค้าออกมาจาก session
        guest = (Guest) session.getAttribute("guest");
    }
    if (session.getAttribute("reservation") != null) {
        reservation = (Reservation) session.getAttribute("reservation");
    }
    //ทำการสร้งข้อมูลใบสำรองห้องพัก
    msg = "วันลงทะเบียนเข้าพัก:" + reservation.getCheck_in() + " - วันส่งคืนห้องพัก:" + reservation.getCheck_out();
    msg += "\n จำนวน: " + date.calDateDiff(date.DateToMysql(reservation.getCheck_out()), date.DateToMysql(reservation.getCheck_in())) + " คืน";
    msg += "\nรายการห้องพัก";
    float tempsum=0.0f;
    for (int i = 0; i < room_list.size(); i++) {
        msg += "\n" + room_list.get(i).getRoom_id() + "   :" + room_list.get(i).getRoom_price() + " บาท";
        tempsum+=room_list.get(i).getRoom_price();
    }    
    if(reservation.getPrice_total()-tempsum>0){
       msg += "\n ค่าเตียงเสริม: "+(reservation.getPrice_total()-tempsum); 
    }
    msg += "\nเงินค่าห้องพักรวม:" + reservation.getPrice_total() +" บาท";
    msg += "\nข้อมูลลูกค้า \n";
    msg += "ชื่อลูกค้า:"+guest.getGuest_name()+"\n" +" เลขประจำตัวประชาชน:"+ guest.getGuest_idno()+"\n" + " อีเมล์ลูกค้า:"+ guest.getGuest_email()+"\n" +" เบอร์โทรศัพท์ลูกค้า:"+  guest.getGuest_phone()+"\n" +" ที่อยู่ลูกค้า:"+  guest.getGuest_address();    
    rs=db.ConExecuteQuery("SELECT * FROM `condition` WHERE condition_id=1");
    rs.first();
    msg+="\n"+rs.getString("condition_value");
    msg+="\nลูกค้าที่โอนเงิน ต้องส่งสลิปโอนเงินมาทางอีเมล์ที "+Systems.Data.Email +" ภายใน 24 ชม";
    Email email_send=new Email();
    int flag = 0;
    if (email != null && msg != null&&(guest.getGuest_email().equals(email))) {//ตรวจสอบก่อนส่ง  email
    flag=email_send.sendEmail(email,"ข้อมูลใบสำรองห้องพัก เลขที่:"+reservation.getReservertion_id(), msg);
    }
    out.print(flag);
%>