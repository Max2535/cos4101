package Systems;

import ClassSystem.ConfigSystem;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

public class DateFunc {

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
    LocalDate localDate = LocalDate.now();
    ConfigSystem con = new ConfigSystem();
    Data data = new Data();
    SimpleDateFormat format = null;

    public Date getDate() {
        try {
            ConfigSystem con = new ConfigSystem();
            String sql = "select NOW() as date";
            Condb db = new Condb();
            ResultSet rs = db.ConExecuteQuery(sql);
            String dateInString = con.GetConfig(16);//ค่าเริ่มต้น
            if (rs.first()) {
                dateInString = rs.getString("date");
            }
            SimpleDateFormat formatter = new SimpleDateFormat(con.GetConfig(15));
            Date date = formatter.parse(dateInString);
            return date;
        } catch (ParseException | ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public long calDateDiff(String end, String start) throws ParseException { //คำนวนหาว่าห่างหันกี่วัน
        
        format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (data.mode.equals("dev")) {
            System.out.println("start:" + start + " or " + "end:" + end);
        }
        Date d1 = null, d2 = null;
        long diff = -1, diffDays = -1;
        d1 = format.parse(start + " 00:00:00");
        d2 = format.parse(end + " 00:00:00");
        diff = d2.getTime() - d1.getTime();
        diffDays = diff / (24 * 60 * 60 * 1000);
        if (data.mode.equals("dev")) {
            System.out.println("start:" + d1 + " or " + "end:" + d2);
            System.out.println("diffDays:" + diffDays);
        }
        return diffDays;
    }
    
       public long calDateDiff2(String end, String start) throws ParseException { //คำนวนหาว่าห่างหันกี่วัน
        format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (data.mode.equals("dev")) {
            System.out.println("start:" + start + " or " + "end:" + end);
        }
        Date d1 = null, d2 = null;
        long diff = -1, diffDays = -1;
        d1 = format.parse(start);
        d2 = format.parse(end);
        diff = d2.getTime() - d1.getTime();
        diffDays = diff / (24 * 60 * 60 * 1000);
        if (data.mode.equals("dev")) {
            System.out.println("start:" + d1 + " or " + "end:" + d2);
            System.out.println("diffDays:" + diffDays);
        }
        return diffDays;
    }

    public String getTimeNow() throws ParseException, SQLException, ClassNotFoundException {//ดึกวันเวลาปัจจุบันมาแสดง  
        
        String sql="select NOW() as cur_date";
        Condb condb=new Condb();
        ResultSet rs=condb.ConExecuteQuery(sql);
        if(rs.first()){
            return rs.getString("cur_date");
        }else{
            return null;
        }
    }

    public String FormatDateTime(String dateinput) throws ParseException {//yyyy-MM-dd HH:mm:ss- dd/mm/yyy
        String datetemp = "";
        if (dateinput != null ){
            String[] ary = dateinput.split(" ");
            return FormatDate(ary[0]) + " " + ary[1];
        }
        return datetemp;
    }

    public String FormatDate(String date) throws ParseException {//เปลื่ยน จาก yyyy-mm-dd เป็น dd/mm/yyyy
        String temp_date[] = date.split("-");
        int ad = Integer.parseInt(temp_date[0]);
        ad += 543;
        return temp_date[2] + "/" + temp_date[1] + "/" + ad;
    }

    public String FormatDateEmail(String date) throws ParseException {//เปลื่ยน จาก 24 Mar 2018 06:52:22 GMT เป็น dd/mm/yyyy
        String temp_date[] = date.split(" ");
        int ad = Integer.parseInt(temp_date[0]);
        ad += 543;
        return temp_date[2] + "/" + temp_date[1] + "/" + ad;
    }

    public String DateToMysql(String date) {//เปลื่ยนจาก dd/mm/yyyy  เป็น yyyy-mm-dd  
        String temp_date[] = date.split("/");
        int ad = Integer.parseInt(temp_date[2]);
        ad -= 543;
        return ad + "-" + temp_date[1] + "-" + temp_date[0];
    }

    public String getDate(int i) throws ParseException {//ดึงเฉพาะวันปัจจุบัน
        format = new SimpleDateFormat("yyyy-MM-dd");
        Date dt = getDate();
        Calendar c = Calendar.getInstance();
        c.setTime(dt);
        c.add(Calendar.DATE, i);
        dt = c.getTime();
        return FormatDate(format.format(dt));
    }
    
    public String getDate2(String due_date,int i) throws ParseException { //ดึงวันเช็คอินมาด้วย
        format = new SimpleDateFormat("yyyy-MM-dd");
        Date duedate = format.parse(DateToMysql(due_date));
        Calendar c = Calendar.getInstance();
        c.setTime(duedate);
        c.add(Calendar.DATE, i);
        duedate = c.getTime();
        return FormatDate(format.format(duedate));
    }

    public long Check_error(String end, String start) throws ParseException {//ตรวจสอบว่าวันย้อนหลังไหม
        long diffdate = calDateDiff(end, start);
        if (diffdate < 1) {
            return -1;
        } else {
            return diffdate;
        }
    }

    public int TimeCheckOut() throws java.text.ParseException {//ตรวจสอบเวลา CheckOut
        format = new SimpleDateFormat("HH:mm:ss");

        Date checkOut = format.parse(con.GetConfig(6));
        Date userDate = format.parse(DateTimeFormatter.ofPattern("HH:mm:ss").format(LocalDateTime.now()));

        if (userDate.before(checkOut)) {
            if (data.mode.equals("dev")) {
                System.out.println("ก่อนเวลา CheckOut");
            }
            return 1;
        } else {
            if (data.mode.equals("dev")) {
                System.out.println("หลังเวลา CheckOut");
            }
            return 0;
        }
    }

    public int TimeCheckIn() throws java.text.ParseException {//ตรวจสอบเวลา CheckIn
        format = new SimpleDateFormat("HH:mm:ss");

        Date checkIn = format.parse(con.GetConfig(5));
        Date userDate = format.parse(DateTimeFormatter.ofPattern("HH:mm:ss").format(LocalDateTime.now()));//ดึกเวลาที่มา check in สามารถดึจากเครื่องได้

        if (userDate.before(checkIn)) {
            if (data.mode.equals("dev")) {
                System.out.println("ก่อนเวลา CheckIn");
            }
            return 0;
        } else {
            if (data.mode.equals("dev")) {
                System.out.println("หลังเวลา CheckIn");
            }
            return 1;
        }
    }

    public int checkDateCheckIn(String reservation_id) { // วันมาเเช็คอินก่อนหรือหลัง ข้อมูลในใบ
        int status = 0;
        ResultSet resultSet = null;
        Condb condb = new Condb();
        format = new SimpleDateFormat("yyyy-MM-dd");

        try {
            String sql = "select check_in from reservation where reservertion_id=" + reservation_id;
            resultSet = condb.ConExecuteQuery(sql);
            resultSet.first();

            Date userDate = format.parse(resultSet.getString("check_in"));
            Date checkInCome = format.parse(format.format(getDate())); // วันที่มาเช็ตอิน

            if (checkInCome.after(userDate) || checkInCome.equals(userDate)) {
                status = 1;
                return status;
            } else {
                status = 0;
                return status;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}
