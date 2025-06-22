package DAO;  // sửa lại nếu bạn để DbContext ở package khác

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public abstract class DbContext {
    protected Connection connection;
    private static final Logger LOGGER = Logger.getLogger(DbContext.class.getName());
    
    public DbContext() {
        try {
            Properties props = loadDatabaseProperties();
            String driver = props.getProperty("db.driver");
            String url = props.getProperty("db.url");
            String username = props.getProperty("db.username");
            String password = props.getProperty("db.password");
            
            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);
            LOGGER.info("Kết nối thành công tới database");
        } catch (ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Không tìm thấy driver SQLServer", ex);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kết nối tới database", ex);
        } catch (IOException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đọc file cấu hình database", ex);
        }
    }
    
    private Properties loadDatabaseProperties() throws IOException {
        Properties props = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                LOGGER.warning("Không tìm thấy file db.properties, sử dụng cấu hình mặc định");
                // Fallback to default configuration
                props.setProperty("db.driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver");
                props.setProperty("db.url", "jdbc:sqlserver://localhost:1433;databaseName=PhanNgocAnhAssiment");
                props.setProperty("db.username", "sa");
                props.setProperty("db.password", "123");
            } else {
                props.load(input);
            }
        }
        return props;
    }
    
    public Connection getConnection() {
        return connection;
    }
    
    public void close() {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("Đã đóng kết nối database");
            } catch (SQLException ex) {
                LOGGER.log(Level.WARNING, "Lỗi khi đóng connection", ex);
            }
        }
    }
    
    public static void main(String[] args) {
        // Tạo instance DbContext, constructor đã tự nối đến DB
        DbContext dbContext = new DbContext() {
            // Anonymous class để test
        };
        
        // Lấy Connection ra để kiểm tra
        Connection conn = dbContext.getConnection();
        try {
            // isValid(timeoutInSeconds) sẽ trả về true nếu connection vẫn còn sống
            if (conn != null && conn.isValid(5)) {
                LOGGER.info("Kết nối tới database thành công!");
            } else {
                LOGGER.warning("Không thể kết nối tới database!");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra kết nối: " + ex.getMessage(), ex);
        } finally {
            // Đóng connection
            dbContext.close();
        }
    }
}
