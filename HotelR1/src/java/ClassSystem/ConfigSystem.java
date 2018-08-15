package ClassSystem;

import Systems.Condb;
import Systems.DatabaseUtil;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConfigSystem {
//ตั้งค่าระบบ

    String configure_name;
    String configure_value;
    String configure_unit;
    
    public void setConfigure_name(String configure_name) {
        this.configure_name = configure_name;
    }

    public void setConfigure_value(String configure_value) {
        this.configure_value = configure_value;
    }

    public void setConfigure_unit(String configure_unit) {
        this.configure_unit = configure_unit;
    }

    public String getConfigure_name() {
        return configure_name;
    }

    public String getConfigure_value() {
        return configure_value;
    }

    public String getConfigure_unit() {
        return configure_unit;
    }
    
    public String GetConfig(int id){
          try {
            Condb db = new Condb();
            String sql = "SELECT * FROM configure WHERE configure_id=" + id;
            ResultSet rs = db.ConExecuteQuery(sql);
            rs.first();
            configure_name = rs.getString("configure_name");
            configure_value = rs.getString("configure_value");
            configure_unit = rs.getString("configure_unit");
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
        }
          return configure_value;
    }
    
    public int saveConfig(int staff_id, int configure_id, String configure_value, String configure_unit) {
        int status = 0;
        try {
            String sql = "update configure set configure_value=? where configure_id=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, configure_value);
            preparedStatement.setInt(2, configure_id);
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
            Log.SeveLog(staff_id, "แก้ไข Configuration หมายเลข " + configure_id + " ค่าถูกแก้ไขเป็น " + configure_value + " " + configure_unit, "แก้ไข Configuration");
            return status;
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}
