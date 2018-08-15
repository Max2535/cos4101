package ClassSystem;

import Systems.Condb;
import Systems.DatabaseUtil;
import java.sql.PreparedStatement;
import Systems.DateFunc;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.Part;
import java.io.InputStream;

public class Room {

    //ข้อมูลห้องพัก
    int room_id;
    int room_type_id;
    float room_price;
    String room_status;
    Blob room_image;
    String extra_bed;
    String room_code;

    public String getRoom_code() {
        return room_code;
    }

    public void setRoom_code(String room_code) {
        this.room_code = room_code;
    }
    

    public void setExtra_bed(String extra_bed) {
        this.extra_bed = extra_bed;
    }

    public String getExtra_bed() {
        return extra_bed;
    }

    public void setRoom_type_id(int room_type_id) {
        this.room_type_id = room_type_id;
    }

    public void setRoom_status(String room_status) {
        this.room_status = room_status;
    }

    public void setRoom_image(Blob room_image) {
        this.room_image = room_image;
    }

    public int getRoom_type_id() {
        return room_type_id;
    }

    public String getRoom_status() {
        return room_status;
    }

    public Blob getRoom_image() {
        return room_image;
    }

    public void setRoom_type(int room_type) {
        this.room_type_id = room_type;
    }

    public int getRoom_type() {
        return room_type_id;
    }

    public int getRoom_id() {
        return room_id;
    }

    public float getRoom_price() {
        return room_price;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public void setRoom_price(float room_price) {
        this.room_price = room_price;
    }

    public ArrayList initRoom(String check_in, String check_out) throws SQLException, ClassNotFoundException {
        Condb db = new Condb();
        DateFunc date = new DateFunc();
        ResultSet rs = null;
        String sql = "";
        rs = searchFreeRooms(check_in, check_out);
        ArrayList<Room> room_list = new ArrayList<Room>();
        while (rs != null && rs.next()) {
            Room room = new Room();
            room.setRoom_id(rs.getInt("room_id"));
            room.setRoom_type_id(rs.getInt("room_type_id"));
            room.setRoom_price(rs.getFloat("room_price"));
            room.setRoom_status(rs.getString("room_status"));
            //room.setRoom_image(rs.getBlob("room_image"));
            room_list.add(room);
        }
        return room_list;
    }

    public ResultSet searchFreeRooms(String check_in, String check_out) throws SQLException, ClassNotFoundException {
        Condb db = new Condb();
        DateFunc date = new DateFunc();
        ResultSet rs = null;
        String sql = "";
        check_in = date.DateToMysql(check_in);
        check_out = date.DateToMysql(check_out);
        /*ค้นหาข้อมูลใบสำรองห้องพักที่ไม่มีลูกค้าเข้าพัก  ยกเลิกหรือ ส่งคืน*/
        sql = "SELECT distinct t1.reservertion_id FROM reservation t1 left outer join reservation_detail t2 on t1.reservertion_id=t2.reservertion_id where t1.status_reservation='CANCEL' OR t1.status_reservation='CHECK_OUT';";
        rs = db.ConExecuteQuery(sql);
        sql = "";
        while (rs != null && rs.next()) {
            sql += " and t2.reservertion_id <>" + rs.getString("reservertion_id");
        }
        /*ค้นหาข้อมูลห้องพักที่ คาบเกียว และซ้ำกัน*/
        sql = "SELECT room_id FROM reservation t1 left outer join reservation_detail t2 on t1.reservertion_id=t2.reservertion_id"
                + " where (check_in between '" + check_in + "' and '" + check_out + "' or"
                + " check_out between '" + check_in + "' and '" + check_out + "') " + sql + ";";
        rs = db.ConExecuteQuery(sql);
        sql = "";
        while (rs != null && rs.next()) {
            sql += " and t1.room_id<>" + rs.getString("room_id");
        }
        /*ค้นหาข้อมูลห้องพักที่ คาบเกียว และซ้ำกัน*/
        /*ไม่แสดงห้องพักที่ คาบเกียวกัน*/
        rs = db.ConExecuteQuery("SELECT * FROM room t1 left outer join room_type t2 on t1.room_type_id=t2.room_type_id where 1=1" + sql + " order by t1.room_id");
        /*ไม่แสดงห้องพักที่ คาบเกียวกัน*/
        return rs;
    }

    public ResultSet searchRoomsForMove(String check_in, String check_out, String reservertion_id) throws SQLException, ClassNotFoundException {
        Condb db = new Condb();
        DateFunc date = new DateFunc();
        ResultSet rs = null;
        String sql = "";
        //จะส่งห้องว่างกับมา
        rs = searchFreeRooms(check_in, check_out);
        String listroom_free = "";
        while (rs != null && rs.next()) {
            listroom_free += rs.getString("room_id") + ",";
        }
        //เอาห้องเก่าออกมาแสดง
        String listroom_old = "";
        Reservation reservation = new Reservation();
        ResultSet temp_rs = reservation.GetReservationDetail(reservertion_id);
        while (temp_rs != null && temp_rs.next()) {
            listroom_old += temp_rs.getString("room_id") + ",";
        }
        String room_ilst = listroom_free + listroom_old + "0";
        rs = db.ConExecuteQuery("SELECT * FROM room t1 left outer join room_type t2 on t1.room_type_id=t2.room_type_id where room_id IN (" + room_ilst + ")");
        return rs;
    }

    public ResultSet GetRoomType(int room_id) throws ClassNotFoundException, SQLException {
        Condb db = new Condb();
        DateFunc date = new DateFunc();
        ResultSet rs = null;
        String sql = "";
        sql = "SELECT * FROM room_type where room_type_id=" + room_id;
        rs = db.ConExecuteQuery(sql);
        return rs;
    }
    
    public ResultSet getRoomById(int room_id) {
        ResultSet resultSet = null;
        try {
            String sql = "select * from room where room_id=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setInt(1, room_id);
            resultSet = preparedStatement.executeQuery();
            preparedStatement.close();
            return resultSet;
        } catch (Exception e) {
            System.out.println(e);
        }
        return resultSet;
    }
    //********* เพิ่มใหม่ *******************
    public static int addRoom(Room room, Part room_image, int staff_id) { //11
        int status = 0;
        try {
            InputStream inputStream = room_image.getInputStream();
            String sql = "insert into room(room_code, room_type_id, room_price, room_status, room_image) value(?, ?, ?, ?, ?);";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, room.getRoom_code());
            preparedStatement.setInt(2, room.getRoom_type_id());
            preparedStatement.setFloat(3, room.getRoom_price());
            preparedStatement.setString(4, room.getRoom_status());
            preparedStatement.setBlob(5, inputStream);
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            Log.SeveLog(staff_id, "เพิ่มข้อมูลห้องพักสำเร็จ หมายเลขห้องพักที่ : " + room.getRoom_code(), "เพิ่มข้อมูลห้องพัก");
            return status;
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static int editRoom(Room room, Part room_image, int staff_id, String flag) {
        int status = 0;
        InputStream inputStream = null;
        try {
            String sql = "";
            if (flag.equals("true")) {//ตรวจสอบว่ามีการอัพโหลดรูปใหม่ไม่
                inputStream = room_image.getInputStream();
                sql = "UPDATE `room` SET `room_type_id`=?, `room_price`=?, `room_status`=?, `room_code`=?, `room_image`=? WHERE `room_id`='?'";
                PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
                preparedStatement.setInt(1, room.getRoom_type_id());
                preparedStatement.setFloat(2, room.getRoom_price());
                preparedStatement.setString(3, room.getRoom_status());
                preparedStatement.setString(4, room.getRoom_code());
                preparedStatement.setBlob(5, inputStream);
                preparedStatement.setInt(6, room.getRoom_id());
                status = preparedStatement.executeUpdate();
                preparedStatement.close();
                Log.SeveLog(staff_id, "แก้ไขข้อมูลห้องพักสำเร็จ หมายเลขห้องพักที่ : " + room.getRoom_code(), "แก้ไขข้อมูลห้องพัก");
                return status;
            } else {
                sql = "UPDATE `room` SET `room_type_id`=?, `room_price`=?, `room_status`=?, `room_code`=? WHERE `room_id`='?'";
                PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql); 
                preparedStatement.setInt(1, room.getRoom_type_id());
                preparedStatement.setFloat(2, room.getRoom_price());
                preparedStatement.setString(3, room.getRoom_status());
                preparedStatement.setString(4, room.getRoom_code());
                preparedStatement.setInt(5, room.getRoom_id());
                status = preparedStatement.executeUpdate();
                preparedStatement.close();
                Log.SeveLog(staff_id, "แก้ไขข้อมูลห้องพักสำเร็จ หมายเลขห้องพักที่ : " + room.getRoom_code(), "แก้ไขข้อมูลห้องพัก");
                return status;
            } 
        } catch(Exception e) {
            System.out.println(e);
        }
        return status;
    }
    //************** เพิ่มใหม่ *******************
    public static boolean checkRoom_id(int room_id) { //11
        boolean flag = true;
        try {
            String sql = "select room_id from room";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next() && flag) {                
                if (Integer.parseInt(resultSet.getString("room_id")) == room_id) {
                    flag = false;
                }
            }
            return flag;
        } catch (Exception e) {
            System.out.println(e);
        }
        return flag;
    }
    public static boolean checkRoom_id_edit(String room_id) { //11
        boolean flag = false;
        try {
            String sql = "select room_id from room where room_id="+room_id;
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next() && flag) {           
                if (resultSet.getString("room_id").equals(room_id) ) {
                    flag = true;
                }
            }
            return flag;
        } catch (Exception e) {
            System.out.println(e);
        }
        return flag;
    }
}
