/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

/**
 *
 * @author Max
 */
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class delcountpage 
{
    public static void del() throws InterruptedException 
    {
        Connection connect1 = null;
        Statement s1 = null;
    try {
        Class.forName(configmysql.mysqljdbc);
        connect1 =  (Connection) DriverManager.getConnection(configmysql.mysqlserver);
        s1 = (Statement) connect1.createStatement();
        String sql1 = "SELECT * FROM  pageconut";
        ResultSet rec1 = s1.executeQuery(sql1);
        rec1.first();
        int tmp=rec1.getInt("count");
        tmp--;
        //UPDATE `pageconut` SET `conut` = '5' WHERE `pageconut`.`id` = 1;
        String sql = "UPDATE `pageconut` SET `count` = '"+tmp+"' WHERE `id` = 1";
        s1.execute(sql);
        //response.sendRedirect("/BMPDev/index.jsp");
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }
    }
    
}