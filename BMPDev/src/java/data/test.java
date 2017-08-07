/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import javax.mail.MessagingException;

/**
 *
 * @author Max
 */
public class test {
    public static void main(String args[]) throws MessagingException
    {
        GmailSender sender = new GmailSender();
        sender.setSender("kalmro4@gmail.com", "03042532mm");
        sender.addRecipient("suppchai_kalmro@hotmail.co.th");
        sender.setSubject("The subject");
        sender.setBody("The body");
        //sender.addAttachment("test");
        sender.send();
    }
}
