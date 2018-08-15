package ClassSystem;

import Systems.Condb;
import Systems.DatabaseUtil;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Guest {

    //ข้อมูลลูกค้า
    int guest_id = -1;
    String guest_name;
    String guest_idno;
    String guest_email;
    String guest_phone;
    String guest_address;
    Blob guest_image = null;

    public void setGuest_image(Blob guest_image) {
        this.guest_image = guest_image;
    }

    public Blob getGuest_image() {
        return guest_image;
    }

    public void setGuest_id(int guest_id) {
        this.guest_id = guest_id;
    }

    public int getGuest_id() {
        return guest_id;
    }

    public void setGuest_name(String guest_name) {
        this.guest_name = guest_name;
    }

    public void setGuest_idno(String guest_idno) {
        this.guest_idno = guest_idno;
    }

    public void setGuest_email(String guest_email) {
        this.guest_email = guest_email;
    }

    public void setGuest_phone(String guest_phone) {
        this.guest_phone = guest_phone;
    }

    public void setGuest_address(String guest_address) {
        this.guest_address = guest_address;
    }

    public String getGuest_name() {
        return guest_name;
    }

    public String getGuest_idno() {
        return guest_idno;
    }

    public String getGuest_email() {
        return guest_email;
    }

    public String getGuest_phone() {
        return guest_phone;
    }

    public String getGuest_address() {
        return guest_address;
    }

    public ResultSet GetGuest(int guest_id) {
        try {
            ResultSet rs = null;
            String sql = "SELECT * FROM guest WHERE guest_id=" + guest_id;
            Condb db = new Condb();
            rs = db.ConExecuteQuery(sql);
            return rs;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Guest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet GuestInfo(String idno) {
        try {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "SELECT * FROM guest where guest_idno ='" + idno + "'";
            rs = db.ConExecuteQuery(sql);
            return rs;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Guest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int SaveGuest(int guest_id, String guest_name, String guest_address, String guest_email, String guest_phone, String guest_idno) {
        ResultSet rs = null;
        Condb db = new Condb();
        String sql = "INSERT INTO `guest` "
                + "(`guest_id`,"
                + "`guest_name`,"
                + " `guest_address`,"
                + " `guest_email`, "
                + "`guest_phone`, "
                + "`guest_idno`)"
                + " VALUES ('" + guest_id + "',"
                + "'" + guest_name + "', "
                + "'" + guest_address + "', "
                + "'" + guest_email + "', "
                + "'" + guest_phone + "', "
                + "'" + guest_idno + "')";
        db.ConExecute(sql);
        return 1;
    }

    public int UpdateGuest(int guest_id, String guest_name, String guest_address, String guest_email, String guest_phone, String guest_idno) {
            ResultSet rs = null;
            Condb db = new Condb();
            String sql = "UPDATE `guest` SET "
                    + "`guest_name`='" + guest_name + "',"
                    + " `guest_idno`='" + guest_idno + "',"
                    + " `guest_email`='" + guest_email + "', "
                    + "`guest_phone`='" + guest_phone + "', "
                    + "`guest_address`='" + guest_address + "'"
                    + " WHERE `guest_id`='" + guest_id + "';";
         db.ConExecute(sql);
        return 1;
    }

    public int uploadImage(String guest_id, InputStream guest_image_input) {
        int status = -1;
        try {
            String sql = "UPDATE `guest` SET `guest_image`=? WHERE `guest_id`=?";
            PreparedStatement preparedStatement = DatabaseUtil.getConnection().prepareStatement(sql);
            preparedStatement.setBlob(1, guest_image_input);
            preparedStatement.setInt(2, Integer.parseInt(guest_id));
            status = preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (Exception e) {
            System.out.print(e);
        }
        return status;
    }
}
