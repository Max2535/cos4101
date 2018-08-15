package Systems;
//Class สำหรับต่อฐานข้อมูล
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Condb {

    Connection conn = null;
    Statement statement = null;
    ResultSet rec = null;
    Data data=new Data();

    //จะมีการ return ค่ากลับ
    public ResultSet ConExecuteQuery(String sql) throws ClassNotFoundException, SQLException {
        if (data.mode.equals("dev")) {
            System.out.println("SQL->:" + sql);
        }
        try {
            Class.forName(Systems.Data.Driver).newInstance();
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("ไม่มี Driver ที่จะต่อ My Sql");
        }
        try {
            conn = DriverManager.getConnection(Data.databaseurl, Data.username, Data.password);
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("ที่อยู่ ชื่อผู้ใช้ หรือ รหัสผ่าน ฐานข้อมูลไม่ถูกต้อง");
        }
        try {
            statement = conn.createStatement();
            
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
        }
        try {
            rec = statement.executeQuery(sql);
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.println("คำสั่ง SQL ไม่ถูกต้อง");
            System.out.println("SQL->:" + sql);
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
        }
        return rec;
    }

    //จะไม่มีการ return ค่ากลับ
    public void ConExecute(String sql) {
        if (data.mode.equals("dev")) {
            System.out.println("SQL->:" + sql);
        }
        try {
            Class.forName(Systems.Data.Driver).newInstance();
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("ไม่มี Driver ที่จะต่อ My Sql");
        }
        try {
            conn = DriverManager.getConnection(Data.databaseurl, Data.username, Data.password);
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("ที่อยู่ ชื่อผู้ใช้ หรือ รหัสผ่าน ฐานข้อมูลไม่ถูกต้อง");
        }
        try {
            statement = conn.createStatement();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
             System.out.println("สร้าง Statement SQl ไม่ได้");
            
        }
        try {
            statement.execute(sql);
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("คำสั่ง SQL ไม่ถูกต้อง");
            System.out.println("SQL->:" + sql);
        }
    }

    public boolean ConExecute(String sql, String msg) {
        System.out.println(msg + " SQL->:" + sql);
        try {
            Class.forName(Systems.Data.Driver).newInstance();
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("ไม่มี Driver ที่จะต่อ My Sql");
        }
        try {
            conn = DriverManager.getConnection(Data.databaseurl, Data.username, Data.password);
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
             System.out.println("ที่อยู่ ชื่อผู้ใช้ หรือ รหัสผ่าน ฐานข้อมูลไม่ถูกต้อง");
        }
        try {
            statement = conn.createStatement();
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("สร้าง Statement SQl ไม่ได้");
        }
        try {
            statement.execute(sql);
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
            System.out.println("คำสั่ง SQL ไม่ถูกต้อง");
            System.out.println("SQL->:" + sql);
        }
        return false;
    }
}
