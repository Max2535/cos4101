package ClassSystem;

import Systems.Condb;
import Systems.GmailClient;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Email {
//อีเมล์

    int email_id = -1;
    String subject = "";//หัวเรื่อง
    String email_name = "";//ชื่อผู้ส่ง
    String email_address = "";//email ของผู้ส่ง
    String email_sentdate = "";//วันที่ส่ง
    String file = "";//ตรวจสอบว่ามีไฟล์ไม่
    boolean is_read = false;//ทำการอ่านหรือยัง
    int email_numberfile = 0;//จำนวนไหล์
    ArrayList<Blob> email_image = null;
// gmail จะส่งแบบนี้มา suppchai kalmro <kalmro4@gmail.com> ก็เลยต้องมาแยกชื่อ กับอิเมล์
    GmailClient gmail = new GmailClient();

    public Email() {
    }
    

    public Email(String email_data) {
        int index = 0;
        while (email_data.charAt(index) != '<') {

            this.email_name += email_data.charAt(index);
            index++;
        }
        this.email_name = this.email_name.trim();
        index++;
        while (email_data.charAt(index) != '>') {
            this.email_address += email_data.charAt(index);
            index++;
        }
        this.email_address = this.email_address.trim();
    }

    public void setEmail_id(int email_id) {
        this.email_id = email_id;
    }

    public void setEmail_name(String email_name) {
        this.email_name = email_name;
    }

    public void setEmail_address(String email_address) {
        this.email_address = email_address;
    }

    public void setEmail_sentdate(String email_sentdate) {
        this.email_sentdate = email_sentdate;
    }

    public void setIs_read(boolean is_read) {
        this.is_read = is_read;
    }

    public void setEmail_numberfile(int email_numberfile) {
        this.email_numberfile = email_numberfile;
    }

    public void setEmail_image(ArrayList<Blob> email_image) {
        this.email_image = email_image;
    }

    public int getEmail_id() {
        return email_id;
    }

    public String getEmail_name() {
        return email_name;
    }

    public String getEmail_address() {
        return email_address;
    }

    public String getEmail_sentdate() {
        return email_sentdate;
    }

    public boolean isIs_read() {
        return is_read;
    }

    public int getEmail_numberfile() {
        return email_numberfile;
    }

    public ArrayList<Blob> getEmail_image() {
        return email_image;
    }

    public void setNumber(int number) {
        this.email_numberfile = number;
    }

    public int getNumber() {
        return email_numberfile;
    }

    public void setRead(boolean read) {
        this.is_read = read;
    }

    public boolean isRead() {
        return is_read;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public void setSentDate(String sentDate) {
        this.email_sentdate = sentDate;
    }

    public String getSentdate() {
        return email_sentdate;
    }

    public String getName() {
        return email_name;
    }

    public void setName(String name) {
        this.email_name = name;
    }

    public String getAddress() {
        return email_address;
    }

    public void setAddress(String address) {
        this.email_address = address;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String Subject) {
        this.subject = Subject;
    }

    public ResultSet GetEmailData() {
        ResultSet rs = null;
        return rs;
    }

    public int sendEmail(String email, String subject, String msg) {
        gmail.setAccountDetails (Systems.Data.Email, Systems.Data.PasswordEmail);//API
        return gmail.sendGmail(Systems.Data.Email, email,subject, msg);
    }
    public int ReceiverEmail() {
        try {
            gmail.setAccountDetails (Systems.Data.Email, Systems.Data.PasswordEmail);//API
            gmail.NewGmail();//รันคำสั่งตรวจสอบ Gmail
            String sql = "SELECT COUNT(*) as size FROM email WHERE is_read='N' ";
            Condb db=new Condb();
            ResultSet rs = db.ConExecuteQuery(sql);
            rs.first();            
            return Integer.parseInt(rs.getString("size"));
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Email.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Email.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
