package ClassSystem;

import Systems.Condb;
import Systems.DatabaseUtil;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Staff {
//ข้อมูลพนักงาน
    Email email = new Email();
    int staff_id=-1;//ไอดี
    String staff_name;//ชื่อ
    String staff_address;//ที่อยู่
    String staff_code;//รหัสผ่าน
    int staff_type_id;//ประเภทพนักงาน
    String staff_idno;//หมายเลขประจำตัวประชาชน
    String staff_tel;//เบอร์โทร
    String staff_email;//อีเมล์
    String staff_status;
    
    public Staff() {
    }
    
    public void setStaff_address(String staff_address) {
        this.staff_address = staff_address;
    }

    public void setStaff_idno(String staff_idno) {
        this.staff_idno = staff_idno;
    }

    public void setStaff_tel(String staff_tel) {
        this.staff_tel = staff_tel;
    }

    public void setStaff_email(String staff_email) {
        this.staff_email = staff_email;
    }

    public String getStaff_address() {
        return staff_address;
    }

    public String getStaff_idno() {
        return staff_idno;
    }

    public String getStaff_tel() {
        return staff_tel;
    }

    public String getStaff_email() {
        return staff_email;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public void setStaff_name(String staff_name) {
        this.staff_name = staff_name;
    }

    public void setStaff_code(String staff_code) {
        this.staff_code = staff_code;
    }

    public void setStaff_type_id(int staff_type_id) {
        this.staff_type_id = staff_type_id;
    }

    public int getStaff_id() {
        return staff_id;
    }

    public String getStaff_name() {
        return staff_name;
    }

    public String getStaff_code() {
        return staff_code;
    }

    public int getStaff_type_id() {
        return staff_type_id;
    }
    
    public String getStaff_status() {
        return staff_status;
    }

    public void setStaff_status(String staff_status) {
        this.staff_status = staff_status;
    }
    
    public void AddStaff() {
        
    }

    public void EditStaff() {

    }
    
    public static boolean checkStaffPassword(int password) { //10
        boolean flag = true;
        try {
            String sql = "select staff_code from staff";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next() && flag) {                
                if (Integer.parseInt(resultSet.getString("staff_code")) == password) {
                    flag = false;
                }
            }
            return flag;
        } catch (Exception e) {
            System.out.println(e);
        }
        return flag;
    }
    
    public static boolean checkStaffIdNoStaff(String id_no_staff) { //10
        boolean flag = true;
        try {
            String sql = "select staff_idno from staff";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next() && flag) {                
                if (resultSet.getString("staff_idno").equals(id_no_staff)) {
                    flag = false;
                }
            }
            return flag;
        } catch (Exception e) {
            System.out.println(e);
        }
        return flag;
    }
    
    public static ResultSet getStaffData(int staff_id) {
        ResultSet resultSet = null;
        Condb condb = new Condb();
        try {
            String sql = "select * from staff where staff_id="+staff_id;
            resultSet = condb.ConExecuteQuery(sql);
            return resultSet;
        } catch (Exception e) {
            System.out.println(e);
        }
        return resultSet;
    }
    
    public int registerStaff(Staff staff, int staff_id) {
        int status = 0 ;
        try {
            String sql = "insert into staff(`staff_name`, `staff_address`, `staff_email`, `staff_tel`, "
                    + "`staff_code`, `staff_type_id`, `staff_idno`, `staff_status`) "
                    + "value(?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, staff.getStaff_name()); // ชื่อ
            preparedStatement.setString(2, staff.getStaff_address()); // ที่อยู่
            preparedStatement.setString(3, staff.getStaff_email()); // อีเมล์
            preparedStatement.setString(4, staff.getStaff_tel()); //เบอร์
            preparedStatement.setString(5, staff.getStaff_code()); // รหัสผ่าน
            preparedStatement.setInt(6, staff.getStaff_type_id()); // รหัสประเภท
            preparedStatement.setString(7, staff.getStaff_idno()); // รหัสบัตรประชาชน
            preparedStatement.setString(8, "Active"); // สถานะ
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            Log.SeveLog(staff_id, "ลงทะเบียนผู้ใช้สำเร็จ ชื่อ : " + staff.getStaff_name() +" หมายเลขประชาชน " + staff.getStaff_idno(), "ลงทะเบียนผู้ใช้");
            email.sendEmail(staff.getStaff_email(), "รหัสลงทะเบียนผู้ใช้ของ " + staff.getStaff_name(), "ลงทะเบียผู้ใช้สำเร็จ รหัสผ่านของคุณคือ " +staff.getStaff_code());
            return status;
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static int editStaff(Staff staff, int staff_id) {
        int status = 0;
        try{
            String sql = "update staff set staff_name=?, staff_address=?, staff_email=?, staff_tel=?,"
                    + "staff_type_id=?, staff_idno=?, staff_status=? where staff_id=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, staff.getStaff_name()); // ชื่อ
            preparedStatement.setString(2, staff.getStaff_address()); // ที่อยู่
            preparedStatement.setString(3, staff.getStaff_email()); // อีเมล์
            preparedStatement.setString(4, staff.getStaff_tel()); //เบอร์
            preparedStatement.setInt(5, staff.getStaff_type_id()); // รหัสประเภท
            preparedStatement.setString(6, staff.getStaff_idno()); // รหัสบัตรประชาชน
            preparedStatement.setString(7, "Active"); // สถานะ
            preparedStatement.setInt(8, staff.getStaff_id());
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            Log.SeveLog(staff_id, "แก้ไขข้อมูลผู้ใช้สำเร็จ ชื่อ : " + staff.getStaff_name() +" หมายเลขประชาชน " + staff.getStaff_idno(), "แก้ไขผู้ใช้");
            return status;
        } catch(Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static Staff getStaffById(int staff_id) {
        Staff staff = null;
        try {
            String sql = "select * from staff where staff_id=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setInt(1, staff_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                staff = new Staff();
                staff.setStaff_code(resultSet.getString("staff_code"));
                staff.setStaff_name(resultSet.getString("staff_name"));
                staff.setStaff_idno(resultSet.getString("staff_idno"));
                staff.setStaff_email(resultSet.getString("staff_email"));
                staff.setStaff_tel(resultSet.getString("staff_tel"));
                staff.setStaff_status(resultSet.getString("staff_status"));
                staff.setStaff_address(resultSet.getString("staff_address"));
                staff.setStaff_type_id(resultSet.getInt("staff_type_id")); 
            }
            return staff;
        } catch (Exception e) {
            System.out.println(e);
        }
        return staff;
    }
}
