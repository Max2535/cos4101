package ClassSystem;

import Systems.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Reservation {
//ข้อมูลใบสำรองห้องพัก

    int reservertion_id = -1;//เลขที่ใบสำรองห้องพัก
    int guest_id = -1;//ไอดีลูกค้า
    int staff_id = -1;//ไอดีพนักงาน
    String check_in;//วันลงทะเบียนเข้าพัก
    String check_out;//วันส่งคืนห้องพัก
    String creation_date;//วันเวลาสร้างใบสำรองห้องพัก
    float price_reservation;//ราคาค่าห้อง
    float price_total;//ราคาค่าห้อง+เตียงเสริม
    String status_reservation;//สถานะใบสำรองห้องพัก
    String status_pay;//สถานะการชำระเงิน
    String note;//หมายเหตุ
    String email_id;//ผูกกับอีเมล์ที่ส่งสลิปมา
    Email email = new Email();
    DateFunc date = new DateFunc();

    public float getPrice_total() {
        return price_total;
    }

    public void setPrice_total(float price_total) {
        this.price_total = price_total;
    }

    public Email getEmail() {
        return email;
    }

    public void setEmail(Email email) {
        this.email = email;
    }

    public DateFunc getDate() {
        return date;
    }

    public void setDate(DateFunc date) {
        this.date = date;
    }

    public void setReservertion_id(int reservertion_id) {
        this.reservertion_id = reservertion_id;
    }

    public void setGuest_id(int guest_id) {
        this.guest_id = guest_id;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public void setCheck_in(String check_in) {
        this.check_in = check_in;
    }

    public void setCheck_out(String check_out) {
        this.check_out = check_out;
    }

    public void setCreation_date(String creation_date) {
        this.creation_date = creation_date;
    }

    public void setPrice_reservation(float price_reservation) {
        this.price_reservation = price_reservation;
    }

    public void setStatus_reservation(String status_reservation) {
        this.status_reservation = status_reservation;
    }

    public void setStatus_pay(String status_pay) {
        this.status_pay = status_pay;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setEmail_id(String email_id) {
        this.email_id = email_id;
    }

    public int getReservertion_id() {
        return reservertion_id;
    }

    public int getGuest_id() {
        return guest_id;
    }

    public int getStaff_id() {
        return staff_id;
    }

    public String getCheck_in() {
        return check_in;
    }

    public String getCheck_out() {
        return check_out;
    }

    public String getCreation_date() {
        return creation_date;
    }

    public float getPrice_reservation() {
        return price_reservation;
    }

    public String getStatus_reservation() {
        return status_reservation;
    }

    public String getStatus_pay() {
        return status_pay;
    }

    public String getNote() {
        return note;
    }

    public String getEmail_id() {
        return email_id;
    }

    public ResultSet GetReservation(String reservertion_id) {
        try {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "SELECT * FROM reservation t1 left outer join guest t2 on t1.guest_id=t2.guest_id WHERE t1.reservertion_id=" + reservertion_id;//+ " AND status_pay<>'PAY'"
            rs = db.ConExecuteQuery(sql);
            return rs;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet GetReservationDetail(String reservertion_id) {//ใช้สำหรับแสดงข้อมูลใบสำรองห้องพักที่เลือ
        try {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "SELECT * FROM reservation_detail t1 left outer join room t2 on t1.room_id=t2.room_id left outer join room_type t3 on t2.room_type_id=t3.room_type_id WHERE t1.reservertion_id=" + reservertion_id;
            rs = db.ConExecuteQuery(sql);
            return rs;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet GetReservationEmail(String email) {
        try {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "SELECT * FROM reservation t1 left outer join guest t2 on t1.guest_id=t2.guest_id WHERE t2.guest_email='" + email + "'";
            rs = db.ConExecuteQuery(sql);
            return rs;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /*
    กำลังคิดว่าจะลบดีไม
     */
    public ResultSet SearchGuest(String reservertion_id) {
        try {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "SELECT * FROM reservation t1 left outer join guest t2 on t1.guest_id=t2.guest_id WHERE reservertion_id=" + reservertion_id;
            rs = db.ConExecuteQuery(sql);
            return rs;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int CountReservation() {
        try {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "SELECT COUNT(*) as size FROM reservation";
            rs = db.ConExecuteQuery(sql);
            rs.first();
            return Integer.parseInt(rs.getString("size"));
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public ResultSet getReservation(String reservation_id) {
        Condb condb = new Condb();
        ResultSet resultSet = null;
        try {
            String sql = "select * from reservation where reservertion_id=" + reservation_id;
            resultSet = condb.ConExecuteQuery(sql);
        } catch (Exception e) {
            System.out.println(e);
        }
        return resultSet;
    }

    public int cancelReservation(int staff_id, String reservertion_id, String note, String type) { // 6. บันทึกยกเลิกใบสำรอง
        int status = 0;
        try {
            String sql = "UPDATE `reservation` SET `status_reservation`='CANCEL',staff_cancel_id=?, cancel_time=NOW(),`note`=? WHERE `reservertion_id`=?";
            System.out.println(sql);
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setInt(1, staff_id);
            preparedStatement.setString(2, note);
            preparedStatement.setInt(3, Integer.parseInt(reservertion_id));
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            ResultSet rs = SearchGuest(reservertion_id);
            rs.first();
            //email.sendEmail(rs.getString("guest_email"), "ยกใบสำรองห้องพักเลขที่: " + reservertion_id, "ยกเลิกใบสำรองห้องพักเรียบร้อยแล้ว");
            Log.SeveLog(staff_id,"เหตุผลยกเลิก : " + note + ", " + type + "หมายเลขใบสำรองที่ : " + reservertion_id, "ยกเลิกใบสำรองห้องพัก");
            return status;
        } catch (Exception e) {
            System.out.print(e);
        }
        return status;
    }

    public String cancelReservationAutomation(int staff_id) {
        int status = 0;
        String list = "";
        try {
            String sql = "select * from reservation where status_pay='NEW' and status_reservation<>'CANCEL'";
            ResultSet resultSet = DatabaseUtil.getConnection().prepareStatement(sql).executeQuery();

            while (resultSet.next()) {
                System.out.println("NOW:"+date.getTimeNow());
                System.out.println("creation_date:"+resultSet.getString("creation_date"));
                System.out.println("dtff date ---------------------:"+date.calDateDiff2(date.getTimeNow(),resultSet.getString("creation_date")));
                if (date.calDateDiff2(date.getTimeNow(),resultSet.getString("creation_date") ) >0) {
                    list += resultSet.getString("reservertion_id") + ",";
                }
            }
            System.out.println("lis::::::::::::::::"+list);
            if (!list.equals("")) {
                sql = "update reservation set status_reservation='CANCEL', note='ไม่ได้ชำระเงินภายใน 24 ชม.' where reservertion_id in (" + list + "0)";
                status = DatabaseUtil.getConnection().prepareStatement(sql).executeUpdate();
                Log.SeveLog(staff_id, "ยกเลิกใบสำรองอัตโนมัติหมายเลขใบสำรองที่ : " + list + " เพราะไม่ได้ชำระเงินภายใน 24 ชม. นับตั้งแต่สร้างใบสำรอง", "ยกเลิกใบสำรองห้องพักอัตโนมัติ");
            }
            return list;

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
    
    public String checkOutReservationAutomation(int staff_id) {
        int status = 0;
        String list = "";
        try {
            String sql = "SELECT * FROM reservation WHERE status_reservation='CHECK_IN' or status_reservation='WAIT_CHECK_IN' AND status_pay='PAY'";
            ResultSet resultSet = DatabaseUtil.getConnection().prepareStatement(sql).executeQuery();
            while(resultSet.next()) {
                if (date.calDateDiff(resultSet.getString("check_out"), date.DateToMysql(date.getDate(0))) == 0) { //ต้องเป็นวันเดียวกันก่อน
                    if (date.TimeCheckOut() == 0) {//ถ้าหลังจากเวลา check out แล้ว จะทำ
                        list += resultSet.getString("reservertion_id") + ",";
                    }
                }
            }
            if (!list.equals("")) {
                String sql2 = "UPDATE `reservation` SET `status_reservation`='CHECK_OUT',`note`='ไม่มาลงทะเบียนเข้าพัก หรือ ไม่มาส่งคืนห้องพักที่หน้าเค้าเตอร์' WHERE `reservertion_id` IN (" + list + "0)";
                status = DatabaseUtil.getConnection().prepareStatement(sql2).executeUpdate();
                Log.SeveLog(staff_id, "ระบบทำการส่งคืนห้องพักอัตโนมัติใบสำรองหมายเลข : " + list + " เพราะไม่ได้ทำการส่งคืนห้องในวันเวลาที่กำหนดในใบสำรอง", "ส่งคืนห้องพักอัตโนมัติ");
            }
            return list;
        } catch(Exception e) {
            System.err.println(e);
        }
        return list;
    }
    
    public int checkInReservation(String reservation_id, int staff_id) { // 8. บันทึกลงทะเบียน
        int status = -1;
        try {
            String sql = "UPDATE `reservation` SET `status_reservation`='CHECK_IN' WHERE `reservertion_id`=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(reservation_id));
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            Log.SeveLog(staff_id,"ลงทะเบียนเข้าพักสำเร็จ หมายเลขใบสำรองที่ : " + reservation_id, "ลงทะเบียนเข้าพัก");
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public int checkOutReservation(int staff_id, String reservation_id, String note, String type) { // 9. ส่งคืนห้องพัก
        int status = -1;
        try {
            String sql = "UPDATE `reservation` SET `status_reservation`='CHECK_OUT' WHERE `reservertion_id`=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(reservation_id));
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            Log.SeveLog(staff_id,"ส่งคืนห้องพักสำเร็จ หมายเลขใบสำรองที่ : " + reservation_id, "ส่งคืนห้องพัก");
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public ResultSet listReservation(String display) {//ใช้สำหรับดึงรายการใบสำรองห้องพักทั้งหมด
        try {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "SELECT * FROM reservation t1 left outer join guest t2 on t1.guest_id=t2.guest_id WHERE 1=1" + display + " order by creation_date desc";
            rs = db.ConExecuteQuery(sql);
            return rs;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int saveReservation(String reservation_id, String staff_id, String check_in, String check_out, String price, String status_reservation, String status_pay, ArrayList<Room> room_list, String guest_id,float price_total) {
        ResultSet rs = null;
        Condb db = new Condb();
        String sql = "INSERT INTO `reservation` "
                + "(`reservertion_id`,"
                + "`guest_id`,"
                + "`staff_id`, "
                + "`check_in`,"
                + " `check_out`, "
                + " `price_reservation`,"
                + " `status_reservation`, "
                + "`status_pay`,"
                + "`price_total`)"
                + " VALUES ('" + reservation_id + "','"
                + guest_id + "','"
                + staff_id + "','"
                + date.DateToMysql(check_in) + " 00:00:00" + "','"
                + date.DateToMysql(check_out) + " 00:00:00" + "','"
                + price + "','"
                + status_reservation + "','"
                + status_pay + "','"
                + price_total + "')";
        db.ConExecute(sql);
        if (room_list.size() > 0) {
            sql = "";
            for (int index = 0; index < room_list.size(); index++) {
                sql = "INSERT INTO `reservation_detail` (`reservertion_id`, `room_id`, `extra_bed`) "
                        + "VALUES (" + reservation_id + "," + room_list.get(index).getRoom_id() + ""
                        + ", '" + room_list.get(index).getExtra_bed() + "');";
                db.ConExecute(sql);
            }
        }
        Log.SeveLog(Integer.parseInt(staff_id), "ทำการสำรองห้องพักสำเร็จ ใบสำรองหมายเลขที่ : " + reservation_id ,"สำรองห้องพัก");
        return 1;
    }

    public int selectCheckInAndCheckOut() {
        return 1;

    }

    public Room selectRoom(int room_id, String extra_bed, int room_type, float room_price,String room_code) {
        Room room = new Room();
        room.setRoom_id(room_id);
        room.setExtra_bed(extra_bed);
        room.setRoom_type(room_type);
        room.setRoom_price(room_price);
        room.setRoom_code(room_code);
        return room;
    }

    public int clearEditRreservation(String[] reservation_detail_id) {
        int status = 0, index = 0;
        try {
            while (index < reservation_detail_id.length) {
                String sql = "update reservation_detail set extra_bed='false' where reservation_detail_id=?";
                PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
                preparedStatement.setInt(1, Integer.parseInt(reservation_detail_id[index]));
                preparedStatement.executeUpdate();
                preparedStatement.close();
                index++;
            }
            status = 1;
            return status;
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    public double getPriceReservation(String reservation_id) {
        double price = 0.0;
        Condb condb = new Condb();
        ResultSet resultSet = null;
        try {
            String sql = "select price_reservation from reservation where reservertion_id="+reservation_id;
            resultSet = condb.ConExecuteQuery(sql);
            resultSet.first();
            price = resultSet.getDouble("price_reservation");
            return price;
        } catch (Exception e) {
            System.err.println(e);
        }
        return price;
    }
    public int saveEditReservation(int staff_id, String reservation_id, String[] reservation_detail_id) {
        int status = 0, index = 0;
        try {
            while (index < reservation_detail_id.length) {
                String sql = "update reservation_detail set extra_bed='true' where reservation_detail_id=?";
                PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
                preparedStatement.setInt(1, Integer.parseInt(reservation_detail_id[index]));
                preparedStatement.executeUpdate();
                preparedStatement.close();
                index++;
            }
            //Log.SeveLog(staff_id, "แก้ไขใบสำรองห้องพักสำเร็จ ใบสำรองหมายเลขที่ : " + reservation_id + " ", " แก้ไขใบสำรอง");
            status = 1;
            return status;
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public int priceTotal(String reservation_id) {
        int status = 0;
        double total = 0.0;
        try {
            total = getPriceReservation(reservation_id) + calExtraBed(reservation_id);
            String sql = "update reservation set price_total = ? where reservertion_id=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setDouble(1, total);
            preparedStatement.setInt(2, Integer.parseInt(reservation_id));
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            return status;
        } catch (Exception e) {
            System.err.println(e);
        }
        return status;
    }
    
    public double calExtraBed(String reservation_id) throws SQLException {
        Condb condb = new Condb();
        ResultSet resultSet = null;
        ConfigSystem con = new ConfigSystem();
        int priceExtraBed = Integer.parseInt(con.GetConfig(10));
        double result = 0;
        try {
            String sql = "SELECT count(*) as num FROM reservation_detail where reservertion_id=" + reservation_id + " and extra_bed='true'";
            resultSet = condb.ConExecuteQuery(sql);
            resultSet.first();
            result = resultSet.getFloat("num") * priceExtraBed;
            return result;
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
    
    public int setStaffEdit(int staff_id, String reservation_id) {
        int status = 0;
        try {
            String sql = "update reservation set staff_edit_id=?, edit_time=NOW() where reservertion_id=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setInt(1, staff_id);
            preparedStatement.setInt(2, Integer.parseInt(reservation_id));
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            return status;
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public String getStaffEditName(String reservation_id) {
        Condb condb = new Condb();
        ResultSet resultSet = null;
        try {
            String sql = "select * from reservation t1 left outer join staff t2 on t1.staff_edit_id=t2.staff_id where reservertion_id=" + reservation_id;
            resultSet = condb.ConExecuteQuery(sql);
            resultSet.first();
            return resultSet.getString("staff_name");
        } catch (Exception e) {
            System.out.println(e);
        }
        return "";
    }

    public String getStaffCancelName(String reservation_id) {
        Condb condb = new Condb();
        ResultSet resultSet = null;
        try {
            String sql = "select * from reservation t1 left outer join staff t2 on t1.staff_cancel_id=t2.staff_id where reservertion_id=" + reservation_id;
            resultSet = condb.ConExecuteQuery(sql);
            resultSet.first();
            return resultSet.getString("staff_name");
        } catch (Exception e) {
            System.out.println(e);
        }
        return "";
    }

    public String staffName(String reservation_id) {
        Condb condb = new Condb();
        ResultSet resultSet = null;
        try {
            String sql = "select * from reservation t1 left outer join staff t2 on t1.staff_id=t2.staff_id where reservertion_id=" + reservation_id;
            resultSet = condb.ConExecuteQuery(sql);
            resultSet.first();
            return resultSet.getString("staff_name");
        } catch (Exception e) {
            System.out.println(e);
        }
        return "";
    }
}
