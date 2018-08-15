package Systems;
import java.sql.*;

public class DatabaseUtil {
    
    private static Connection connection = null;
    
    public static Connection getConnection() {
        if (connection != null) {
            return connection;
        } else {
            try {
                final String DRIVER = "com.mysql.jdbc.Driver";
                final String URL = "jdbc:mysql://localhost:3306/hotel?useUnicode=true&characterEncoding=utf8&useSSL=false";
                final String USERNAME = Data.username;
                final String PASSWORD = Data.password;
                Class.forName(DRIVER);
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return connection;
        }
    }
}
