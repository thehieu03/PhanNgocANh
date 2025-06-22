package com.phanngocanh.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Utility class for database operations
 */
public class DatabaseUtil {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseUtil.class);
    private static Properties properties;
    
    static {
        loadProperties();
    }
    
    private static void loadProperties() {
        properties = new Properties();
        try (InputStream input = DatabaseUtil.class.getClassLoader()
                .getResourceAsStream("db.properties")) {
            if (input == null) {
                logger.error("Không tìm thấy file db.properties");
                throw new RuntimeException("Không tìm thấy file db.properties");
            }
            properties.load(input);
        } catch (IOException e) {
            logger.error("Lỗi khi đọc file db.properties", e);
            throw new RuntimeException("Lỗi khi đọc file db.properties", e);
        }
    }
    
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(properties.getProperty("db.driver"));
            return DriverManager.getConnection(
                properties.getProperty("db.url"),
                properties.getProperty("db.username"),
                properties.getProperty("db.password")
            );
        } catch (ClassNotFoundException e) {
            logger.error("Không tìm thấy driver SQL Server", e);
            throw new SQLException("Không tìm thấy driver SQL Server", e);
        }
    }
    
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                logger.debug("Đã đóng kết nối database");
            } catch (SQLException e) {
                logger.warn("Lỗi khi đóng connection", e);
            }
        }
    }
    
    public static Properties getProperties() {
        return properties;
    }
} 