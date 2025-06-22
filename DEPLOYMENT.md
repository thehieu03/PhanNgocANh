# Hướng dẫn Deploy - Hệ thống Quản lý Nghỉ phép

## Yêu cầu hệ thống

### Phần mềm cần thiết
- **Java**: JDK 8 hoặc cao hơn
- **Web Server**: Apache Tomcat 9+ hoặc GlassFish 6+
- **Database**: Microsoft SQL Server 2016+
- **IDE**: NetBeans, Eclipse, hoặc IntelliJ IDEA (khuyến nghị)

### Thư viện cần thiết
- **Servlet API**: javax.servlet-api-4.0.1.jar
- **JSTL**: jstl-1.2.jar
- **SQL Server JDBC**: mssql-jdbc-9.4.1.jre8.jar
- **JSON Processing**: jakarta.json-2.0.1.jar

## Bước 1: Chuẩn bị Database

### 1.1 Tạo Database
```sql
USE master;
CREATE DATABASE PhanNgocAnh;
GO
```

### 1.2 Chạy Script Schema
```bash
# Sử dụng sqlcmd
sqlcmd -S localhost -U sa -P your_password -i DB/PhanNgocAnh.sql

# Hoặc sử dụng SQL Server Management Studio
# Copy và paste nội dung file DB/PhanNgocAnh.sql
```

### 1.3 Thêm dữ liệu mẫu
```bash
# Chạy script sample data
sqlcmd -S localhost -U sa -P your_password -i DB/sample_data.sql
```

### 1.4 Kiểm tra Database
```sql
USE PhanNgocAnh;
SELECT * FROM Users;
SELECT * FROM Departments;
SELECT * FROM Roles;
SELECT * FROM User_Roles;
```

## Bước 2: Cấu hình Database Connection

### 2.1 Tạo file db.properties
Tạo file `src/main/resources/db.properties`:

```properties
db.url=jdbc:sqlserver://localhost:1433;databaseName=PhanNgocAnh;encrypt=true;trustServerCertificate=true
db.username=sa
db.password=your_password
db.driver=com.microsoft.sqlserver.jdbc.SQLServerDriver
```

### 2.2 Kiểm tra kết nối
```java
// Test connection
try (Connection conn = DriverManager.getConnection(url, username, password)) {
    System.out.println("Database connected successfully!");
} catch (SQLException e) {
    System.err.println("Database connection failed: " + e.getMessage());
}
```

## Bước 3: Tải thư viện

### 3.1 Tự động tải (Khuyến nghị)
```bash
# Chạy script download
./download_libs.bat

# Hoặc trên Linux/Mac
chmod +x download_libs.sh
./download_libs.sh
```

### 3.2 Tải thủ công
Nếu script không hoạt động, tải thủ công các file sau vào `web/WEB-INF/lib/`:

1. **Servlet API**: https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar
2. **JSTL**: https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar
3. **SQL Server JDBC**: https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/9.4.1.jre8/mssql-jdbc-9.4.1.jre8.jar
4. **JSON**: https://repo1.maven.org/maven2/org/glassfish/jakarta.json/2.0.1/jakarta.json-2.0.1.jar

## Bước 4: Build Project

### 4.1 Sử dụng Ant (nếu có build.xml)
```bash
# Clean project
ant clean

# Compile
ant compile

# Package WAR
ant package

# Deploy to Tomcat
ant deploy
```

### 4.2 Sử dụng IDE

#### NetBeans
1. Mở NetBeans
2. File → Open Project → Chọn thư mục PhanNgocAnh
3. Chuột phải project → Clean and Build
4. Chuột phải project → Deploy

#### Eclipse
1. File → Import → Existing Projects into Workspace
2. Chọn thư mục PhanNgocAnh
3. Project → Clean
4. Chuột phải project → Run As → Run on Server

#### IntelliJ IDEA
1. File → Open → Chọn thư mục PhanNgocAnh
2. Build → Build Project
3. Run → Edit Configurations → Add Tomcat Server
4. Deploy

## Bước 5: Cấu hình Tomcat

### 5.1 Cài đặt Tomcat
```bash
# Tải Tomcat 9
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.zip

# Giải nén
unzip apache-tomcat-9.0.85.zip
mv apache-tomcat-9.0.85 tomcat9
```

### 5.2 Cấu hình Tomcat
```bash
# Set JAVA_HOME
export JAVA_HOME=/path/to/your/jdk

# Set CATALINA_HOME
export CATALINA_HOME=/path/to/tomcat9

# Add to PATH
export PATH=$PATH:$CATALINA_HOME/bin
```

### 5.3 Deploy WAR file
```bash
# Copy WAR file
cp dist/PhanNgocAnh.war $CATALINA_HOME/webapps/

# Hoặc sử dụng Tomcat Manager
# Truy cập http://localhost:8080/manager
# Upload file WAR và deploy
```

## Bước 6: Kiểm tra và Test

### 6.1 Khởi động Tomcat
```bash
# Start Tomcat
$CATALINA_HOME/bin/startup.sh

# Kiểm tra logs
tail -f $CATALINA_HOME/logs/catalina.out
```

### 6.2 Truy cập ứng dụng
```
http://localhost:8080/PhanNgocAnh/
```

### 6.3 Test các tài khoản
```bash
# Employee
Username: employee1
Password: 123456

# Manager  
Username: manager1
Password: 123456

# Multi-context user
Username: user1
Password: 123456
```

## Bước 7: Troubleshooting

### 7.1 Lỗi thường gặp

#### Database Connection Failed
```
Error: Cannot connect to database
```
**Giải pháp:**
- Kiểm tra SQL Server đang chạy
- Kiểm tra thông tin kết nối trong db.properties
- Kiểm tra firewall và port 1433
- Test kết nối bằng sqlcmd

#### Servlet Import Error
```
Error: The import javax.servlet cannot be resolved
```
**Giải pháp:**
- Kiểm tra servlet-api.jar trong WEB-INF/lib
- Clean và rebuild project
- Kiểm tra Java EE version compatibility

#### JSTL Tags Not Working
```
Error: The taglib directive must have a uri attribute
```
**Giải pháp:**
- Kiểm tra jstl.jar trong WEB-INF/lib
- Đảm bảo web.xml có đúng version
- Kiểm tra taglib declaration trong JSP

#### 404 Not Found
```
Error: The requested resource is not available
```
**Giải pháp:**
- Kiểm tra servlet mappings trong web.xml
- Đảm bảo URL pattern đúng
- Kiểm tra context path

### 7.2 Log Files
```bash
# Tomcat logs
$CATALINA_HOME/logs/catalina.out
$CATALINA_HOME/logs/localhost.log

# Application logs
# Kiểm tra console output hoặc System.out.println()
```

### 7.3 Debug Mode
```bash
# Start Tomcat in debug mode
$CATALINA_HOME/bin/catalina.sh jpda start

# Debug port: 8000
```

## Bước 8: Production Deployment

### 8.1 Security Configuration
```xml
<!-- web.xml -->
<security-constraint>
    <web-resource-collection>
        <web-resource-name>Secure Pages</web-resource-name>
        <url-pattern>/*</url-pattern>
    </web-resource-collection>
    <user-data-constraint>
        <transport-guarantee>CONFIDENTIAL</transport-guarantee>
    </user-data-constraint>
</security-constraint>
```

### 8.2 Database Optimization
```sql
-- Create indexes
CREATE INDEX idx_requests_user_id ON Requests(user_id);
CREATE INDEX idx_requests_status_id ON Requests(status_id);
CREATE INDEX idx_requests_dates ON Requests(start_date, end_date);

-- Update statistics
UPDATE STATISTICS Users;
UPDATE STATISTICS Requests;
```

### 8.3 Performance Tuning
```bash
# Tomcat server.xml
<Connector port="8080" protocol="HTTP/1.1"
           maxThreads="200"
           minSpareThreads="10"
           maxConnections="8192"
           acceptCount="100"
           connectionTimeout="20000" />
```

### 8.4 Monitoring
```bash
# JVM monitoring
jstat -gc <pid>
jmap -heap <pid>

# Database monitoring
sp_who2
SELECT * FROM sys.dm_exec_requests
```

## Bước 9: Backup và Maintenance

### 9.1 Database Backup
```sql
-- Full backup
BACKUP DATABASE PhanNgocAnh 
TO DISK = 'C:\backup\PhanNgocAnh_full.bak'
WITH FORMAT, INIT;

-- Log backup
BACKUP LOG PhanNgocAnh 
TO DISK = 'C:\backup\PhanNgocAnh_log.trn';
```

### 9.2 Application Backup
```bash
# Backup WAR file
cp $CATALINA_HOME/webapps/PhanNgocAnh.war /backup/

# Backup configuration
cp src/main/resources/db.properties /backup/
cp web/WEB-INF/web.xml /backup/
```

### 9.3 Scheduled Maintenance
```bash
# Create maintenance script
#!/bin/bash
# backup.sh
DATE=$(date +%Y%m%d_%H%M%S)
cp $CATALINA_HOME/webapps/PhanNgocAnh.war /backup/PhanNgocAnh_$DATE.war

# Add to crontab
0 2 * * * /path/to/backup.sh
```

## Bước 10: Scaling và High Availability

### 10.1 Load Balancer
```nginx
# nginx.conf
upstream tomcat_cluster {
    server 192.168.1.10:8080;
    server 192.168.1.11:8080;
    server 192.168.1.12:8080;
}

server {
    listen 80;
    location / {
        proxy_pass http://tomcat_cluster;
    }
}
```

### 10.2 Database Clustering
```sql
-- Always On Availability Groups
-- SQL Server clustering
-- Read replicas for reporting
```

## Kết luận

Sau khi hoàn thành các bước trên, hệ thống sẽ hoạt động với:
- ✅ Database được cấu hình đúng
- ✅ Thư viện được tải đầy đủ
- ✅ Application được deploy thành công
- ✅ Các tính năng đăng nhập và chọn ngữ cảnh hoạt động
- ✅ Phân quyền theo vai trò hoạt động chính xác

### Liên hệ hỗ trợ
- **Email**: support@phanngocanh.com
- **Documentation**: [Wiki](https://github.com/phanngocanh/leave-management/wiki)
- **Issues**: [GitHub Issues](https://github.com/phanngocanh/leave-management/issues) 