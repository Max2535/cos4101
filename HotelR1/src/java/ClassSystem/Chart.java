package ClassSystem;

import Systems.Condb;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Chart {

    public int chartCancel(int m) throws ClassNotFoundException, SQLException {
        Condb condb = new Condb();
        try {
            String sql = "SELECT count(*) as c FROM log where log_time like '%2018-0" + m + "%' and log_type like  \"%ยกเลิก%\" ;";
            ResultSet rs = condb.ConExecuteQuery(sql);
            rs.first();
            return rs.getInt("c");
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    public int chartReser(int m) throws ClassNotFoundException, SQLException  {
        Condb condb = new Condb();
        String sql = "SELECT count(*) as c FROM log where log_time like '%2018-0" + m + "%' and log_type like  \"%สำรองห้องพัก%\" ;";
        ResultSet rs=condb.ConExecuteQuery(sql);
        rs.first();
        return rs.getInt("c");
    }
    public int chartPay(int m) throws ClassNotFoundException, SQLException  {
        Condb condb = new Condb();
        String sql = "SELECT count(*) as c FROM log where log_time like '%2018-0" + m + "%' and log_type like  \"%อนุมันการชำระเงิน%\" ;";
        ResultSet rs=condb.ConExecuteQuery(sql);
        rs.first();
        return rs.getInt("c");
    }
}
