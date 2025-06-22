# Hệ thống Quản lý Nghỉ phép - PhanNgocAnh

## Mô tả
Hệ thống quản lý nghỉ phép hoàn chỉnh với tính năng đăng nhập và chọn ngữ cảnh (Employee/Manager) cho phép người dùng có nhiều vai trò hoạt động trong các phòng ban khác nhau.

## Tính năng chính

### 🔐 Đăng nhập & Chọn Ngữ cảnh
- **Đăng nhập**: Xác thực người dùng với username/password
- **Chọn ngữ cảnh**: Tự động hoặc thủ công chọn vai trò khi user có nhiều quyền
- **Session management**: Lưu trữ thông tin user và ngữ cảnh đã chọn

### 👥 Phân quyền theo vai trò
- **Employee**: Tạo đơn, xem đơn của mình
- **Manager**: Duyệt đơn cấp dưới, xem agenda phòng ban
- **Multi-context**: Hỗ trợ user có nhiều vai trò khác nhau

### 📋 Quản lý đơn nghỉ phép
- Tạo đơn nghỉ phép mới
- Xem danh sách đơn (cá nhân/phòng ban)
- Duyệt/từ chối đơn với comment
- Theo dõi lịch sử thay đổi trạng thái

### 📅 Agenda & Thống kê
- Xem lịch nghỉ phép theo phòng ban
- Thống kê đơn nghỉ phép theo trạng thái
- Dashboard với thông tin tổng quan

## Cấu trúc Project

```
PhanNgocAnh/
├── src/
│   └── java/
│       ├── Controller/           # Servlets
│       │   ├── Login.java
│       │   ├── SelectContextServlet.java
│       │   ├── EmployeeHomeServlet.java
│       │   ├── ManagerHomeServlet.java
│       │   ├── RequestServlet.java
│       │   ├── ApprovalServlet.java
│       │   └── AgendaServlet.java
│       ├── DAO/                  # Data Access Objects
│       │   ├── DbContext.java
│       │   ├── UserDAO.java
│       │   ├── RequestDAO.java
│       │   └── ...
│       └── Models/               # Entity classes
│           ├── User.java
│           ├── Request.java
│           ├── RoleContext.java
│           └── ...
├── web/
│   ├── JSP/                      # View pages
│   │   ├── login.jsp
│   │   ├── selectContext.jsp
│   │   ├── employeeHome.jsp
│   │   ├── managerHome.jsp
│   │   └── ...
│   ├── WEB-INF/
│   │   ├── lib/                  # JAR libraries
│   │   └── web.xml               # Servlet configuration
│   └── index.html
├── DB/
│   ├── PhanNgocAnh.sql           # Database schema
│   └── sample_data.sql           # Sample data
└── README.md
```

## Cài đặt & Chạy

### 1. Chuẩn bị môi trường
- **Java**: JDK 8 hoặc cao hơn
- **Server**: Apache Tomcat 9+ hoặc GlassFish
- **Database**: SQL Server 2016+
- **IDE**: NetBeans, Eclipse, hoặc IntelliJ IDEA

### 2. Cài đặt Database
```sql
-- Chạy script tạo database
USE master;
CREATE DATABASE PhanNgocAnh;
GO

USE PhanNgocAnh;
-- Chạy nội dung file DB/PhanNgocAnh.sql
-- Chạy nội dung file DB/sample_data.sql
```

### 3. Cấu hình Database
Tạo file `src/main/resources/db.properties`:
```properties
db.url=jdbc:sqlserver://localhost:1433;databaseName=PhanNgocAnh;encrypt=true;trustServerCertificate=true
db.username=your_username
db.password=your_password
db.driver=com.microsoft.sqlserver.jdbc.SQLServerDriver
```

### 4. Tải thư viện
Chạy script `download_libs.bat` để tải các JAR files cần thiết:
- servlet-api.jar
- jstl.jar  
- mssql-jdbc.jar
- json.jar

### 5. Build & Deploy
```bash
# Sử dụng Ant (nếu có build.xml)
ant build
ant deploy

# Hoặc sử dụng IDE để build và deploy
```

## Luồng hoạt động

### 1. Đăng nhập
```
User truy cập → index.html → redirect → login.jsp → LoginServlet
```

### 2. Chọn ngữ cảnh
```
Login thành công → Kiểm tra role contexts:
├── 1 context → Tự động chọn → Redirect theo role
└── >1 context → selectContext.jsp → SelectContextServlet
```

### 3. Routing theo vai trò
```
Employee → employee/home → employeeHome.jsp
Manager → manager/home → managerHome.jsp
```

### 4. Chức năng theo vai trò
```
Employee:
├── Tạo đơn → requests/create
└── Xem đơn → requests/list?userId=

Manager:
├── Duyệt đơn → requests/list?deptId=
└── Xem agenda → agenda?deptId=
```

## API Endpoints

### Authentication
- `GET /login` - Hiển thị form đăng nhập
- `POST /login` - Xử lý đăng nhập
- `GET /selectContext` - Hiển thị chọn ngữ cảnh
- `POST /selectContext` - Xử lý chọn ngữ cảnh
- `GET /logout` - Đăng xuất

### Employee
- `GET /employee/home` - Trang chủ nhân viên
- `GET /requests/create` - Form tạo đơn
- `POST /requests/create` - Xử lý tạo đơn
- `GET /requests/list?userId=` - Danh sách đơn cá nhân

### Manager
- `GET /manager/home` - Trang chủ quản lý
- `GET /requests/list?deptId=` - Danh sách đơn phòng ban
- `POST /requests/approve` - Duyệt đơn
- `POST /requests/reject` - Từ chối đơn
- `GET /agenda?deptId=` - Xem agenda

## Database Schema

### Bảng chính
- **Users**: Thông tin người dùng
- **Departments**: Phòng ban
- **Roles**: Vai trò (Employee, Manager, Admin)
- **User_Roles**: Phân quyền user
- **Requests**: Đơn nghỉ phép
- **Request_Status**: Trạng thái đơn
- **Request_Status_History**: Lịch sử thay đổi

### Quan hệ
```
Users (1) ←→ (N) User_Roles (N) ←→ (1) Roles
Users (N) ←→ (1) Departments
Users (N) ←→ (1) Users (Manager)
Requests (N) ←→ (1) Users
Requests (N) ←→ (1) Request_Status
```

## Bảo mật

### Session-based Authentication
- Lưu thông tin user trong session
- Kiểm tra quyền truy cập cho mỗi request
- Timeout session sau 30 phút

### Authorization
- Kiểm tra role context cho mỗi chức năng
- Employee chỉ truy cập đơn của mình
- Manager chỉ duyệt đơn trong phòng ban

### Input Validation
- Validate dữ liệu đầu vào
- SQL injection prevention
- XSS protection

## Troubleshooting

### Lỗi thường gặp

1. **Import javax.servlet không resolve**
   - Kiểm tra servlet-api.jar trong classpath
   - Đảm bảo sử dụng đúng version Java EE

2. **Database connection failed**
   - Kiểm tra thông tin kết nối trong db.properties
   - Đảm bảo SQL Server đang chạy
   - Kiểm tra firewall và port 1433

3. **JSTL tags không hoạt động**
   - Thêm jstl.jar vào WEB-INF/lib
   - Kiểm tra taglib declaration trong JSP

4. **404 Not Found**
   - Kiểm tra servlet mappings trong web.xml
   - Đảm bảo URL pattern đúng

### Debug
- Kiểm tra logs trong Tomcat/logs
- Sử dụng System.out.println() để debug
- Kiểm tra database connection

## Tài khoản mẫu

### Employee
- Username: `employee1`
- Password: `123456`
- Role: Employee tại Phòng Kỹ thuật

### Manager
- Username: `manager1`  
- Password: `123456`
- Role: Manager tại Phòng Kỹ thuật

### Multi-context User
- Username: `user1`
- Password: `123456`
- Roles: Employee tại Phòng Kỹ thuật + Manager tại Phòng Nhân sự

## Đóng góp

1. Fork project
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Tạo Pull Request

## License

MIT License - xem file LICENSE để biết thêm chi tiết.

## Liên hệ

- **Tác giả**: Phan Ngoc Anh
- **Email**: phanngocanh@example.com
- **Project**: Hệ thống Quản lý Nghỉ phép 