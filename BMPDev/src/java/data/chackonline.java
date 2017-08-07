/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Timer;
import java.util.TimerTask;

/**
 *
 * @author Max
 */
public class chackonline {
    
    private static final String SERVER_ADDRESS = "127.0.0.1";
    private static final int HTTP_SERVER_PORT = 8888;
    private static boolean connected = false;
    static Socket s;
    static int count=0;

    public static void main(String[] args) {

    Timer timer = new Timer();
    timer.schedule(task, 01, 5001); }  

static TimerTask task = new TimerTask() {

        @Override
        public void run() {
            // TODO Auto-generated method stub
            if (connected == false)
            {
            System.out.println(hostAvailabilityCheck());
            }
        }
    };
    public static boolean hostAvailabilityCheck()
    { 

        boolean available = true; 
        try {               
            if (connected == false)
            { (s = new Socket(SERVER_ADDRESS, HTTP_SERVER_PORT)).close();    
            }               
            } 
        catch (UnknownHostException e) 
            { // unknown host 
            available = false;
            s = null;
            } 
        catch (IOException e) { // io exception, service probably not running 
            available = false;
            s = null;
            } 
        catch (NullPointerException e) {
            available = false;
            s=null;
        }


        return available;   
    } 
    
}



