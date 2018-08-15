package ClassSystem;

import Systems.Condb;

public class Log {

    public static void SeveLog(int staff_id, String note, String action) {
        Condb db = new Condb();
        db.ConExecute("INSERT INTO `log` (`staff_id`, `action`, `log_type`) VALUES ('" + staff_id + "', '" + note + "', '" + action + "');");
    }

    public static void Login(int staff_id) {
        Condb db = new Condb();
        db.ConExecute("UPDATE `staff` SET `login`=NOW() WHERE `staff_id`='" + staff_id + "'");
        db.ConExecute("UPDATE `staff` SET `logout`=null WHERE `staff_id`='" + staff_id + "'");
        //db.ConExecute("UPDATE `staff` SET `logout`=NULL WHERE `staff_id`='" + staff_id + "'");
    }

    public static void Logout(int staff_id) {
        Condb db = new Condb();
        db.ConExecute("UPDATE `staff` SET `logout`=NOW() WHERE `staff_id`='" + staff_id + "'");
    }

}
