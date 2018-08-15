package ClassSystem;

import Systems.Condb;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Authentication {

    Condb db = new Condb();
    ResultSet rs = null;
    String password;

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public ResultSet login(String password) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM `staff` WHERE staff_code='" + password + "' and staff_status='Active'";
        rs = db.ConExecuteQuery(sql);
        return rs;
    }
    
    public boolean logout(int staff_id,String name){
        Log.SeveLog(staff_id, "Logout สำเร็จ ชื่อผู้ใช้ " + name, "Authentication (Logout)");
        Log.Logout(staff_id);
        return false;
    }
}
