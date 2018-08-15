package Systems;

import ClassSystem.Email;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;
import javax.mail.Address;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;

public class GmailClient {

    private String userName;
    private String password;
    private String sendingHost;
    private int sendingPort;
    private String from;
    private String to;
    private String subject;
    private String text;
    private String receivingHost;
    Data data = new Data();

    public void setAccountDetails(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    public int sendGmail(String from, String to, String subject, String text) {
        this.from = from;
        this.to = to;
        this.subject = subject;
        this.text = text;
        this.sendingHost = "smtp.gmail.com";
        this.sendingPort = 465;
        Properties props = new Properties();
        props.put("mail.smtp.host", this.sendingHost);
        props.put("mail.smtp.port", String.valueOf(this.sendingPort));
        props.put("mail.smtp.user", this.userName);
        props.put("mail.smtp.password", this.password);
        props.put("mail.smtp.auth", "true");
        Session session1 = Session.getDefaultInstance(props);
        Message simpleMessage = new MimeMessage(session1);
        InternetAddress fromAddress = null;
        InternetAddress toAddress = null;
        try {
            fromAddress = new InternetAddress(this.from);
            toAddress = new InternetAddress(this.to);
        } catch (AddressException e) {
            if (data.mode.equals("dev")) {
                e.printStackTrace();
                System.out.println("Sending email to: " + to + " failed !!! Falied to Send!!!");

            }
            return -1;
        }
        try {
            simpleMessage.setFrom(fromAddress);
            simpleMessage.setRecipient(RecipientType.TO, toAddress);
            simpleMessage.setSubject(this.subject);
            simpleMessage.setText(this.text);
            Transport transport = session1.getTransport("smtps");
            transport.connect(this.sendingHost, sendingPort, this.userName, this.password);
            simpleMessage.setContent(text, "text/html; charset=UTF-8");
            transport.sendMessage(simpleMessage, simpleMessage.getAllRecipients());
            transport.close();
            if (data.mode.equals("dev")) {
                System.out.println("Mail sent successfully ...Mail sent");
            }
            return 1;
        } catch (MessagingException e) {
            if (data.mode.equals("dev")) {
                e.printStackTrace();
                System.out.println("Sending email to: " + to + " failed !!! Falied to Send!!!");
            }
            return -1;
        }
    }

    public void readGmail() {
        this.receivingHost = "imap.gmail.com";
        Properties props2 = System.getProperties();
        props2.setProperty("mail.store.protocol", "imaps");
        Session session2 = Session.getDefaultInstance(props2, null);
        try {
            Store store = session2.getStore("imaps");
            store.connect(this.receivingHost, this.userName, this.password);
            Folder folder = store.getFolder("INBOX");
            folder.open(Folder.READ_WRITE);
            Message messages[] = folder.getMessages();
            for (int i = 0; i < messages.length; i++) {
                Message message = messages[i];
                Address[] fromAddress = message.getFrom();
                String from = fromAddress[0].toString();
                String subject = message.getSubject();
                String sentDate = message.getSentDate().toLocaleString();
                String contentType = message.getContentType();
                Email email = new Email(from);
                int number_file = 1;
                System.out.println(from);
                if (contentType.contains("multipart")) {
                    Multipart multiPart = (Multipart) message.getContent();
                    int numberOfParts = multiPart.getCount();
                    for (int partCount = 0; partCount < numberOfParts; partCount++) {
                        MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
                        if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
                            try {
                                DriverManager.registerDriver(new com.mysql.jdbc.Driver());
                                Connection conn = DriverManager.getConnection(Data.databaseurl, Data.username, Data.password);
                                //ทำการดึงรูปจากอีเมล์(ไฟล์แนบ มีกี่ไฟล์ก็ดึงมาหมด)
                                //อีเมล์จะเก็บแค่ 24 ชม. หรือหลังจากอนุมัตการชำระเงินแล้ว
                                //ถ้าการชำระเงินไม่ถูกอนุมัติจะส่งอีเมล์กับแล้วนับเวลาใหม่
                                //ต้องมีการเก้บเวลาการส่งอีเมล์
                                String sql = "INSERT INTO `email` (`email_subject`, `email_name`, `email_address`, `email_sentdate`, `email_numberfile`, `email_image`) "
                                        + "VALUES ('" + subject + "', '" + email.getName() + "', '" + email.getAddress() + "', '" + sentDate + "', '" + number_file + "', ?);";
                                PreparedStatement statement = conn.prepareStatement(sql);
                                if (data.mode.equals("dev")) {
                                    System.out.println("SQL:->" + sql);
                                }
                                statement.setBlob(1, part.getInputStream());
                                int row = statement.executeUpdate();
                                if (row > 0) {
                                    if (data.mode.equals("dev")) {
                                        System.out.print("ทำการบันทึกข้อมูลสำเร็จ");
                                    }
                                    number_file++;
                                }
                            } catch (SQLException ex) {
                                if (data.mode.equals("dev")) {
                                    System.out.print("ไม่สำเร็จเนื่องจาก:" + ex.getMessage());
                                }
                            }
                        }
                    }
                }
                message.setFlag(Flags.Flag.DELETED, true);
                //จะมีการลบอีเมล์ทันที่มีดึงมาแล้ว
                if (data.mode.equals("dev")) {
                    System.out.println("Marked DELETE for message: " + subject);
                }
            }
            folder.close(true);
            store.close();
        } catch (IOException | MessagingException e) {
            e.printStackTrace();
        }
    }

    public int NewGmail() {
        //จะมีการแจ้งเตือนหากมีอีเมล์ใหม่หรืออีเมล์ที่ยังไม่ได้อ่าน
        this.receivingHost = "imap.gmail.com";
        Properties props2 = System.getProperties();
        props2.setProperty("mail.store.protocol", "imaps");
        Session session2 = Session.getDefaultInstance(props2, null);
        int count = -1;
        try {
            Store store = session2.getStore("imaps");
            store.connect(this.receivingHost, this.userName, this.password);
            Folder folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);
            count = folder.getUnreadMessageCount();
            if (count > 0) {
                readGmail();
            }
            folder.close(true);
            store.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
