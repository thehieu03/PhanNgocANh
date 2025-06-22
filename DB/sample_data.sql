-- Sample Data for PhanNgocAnh Leave Management System
-- Run this script after creating the database schema

USE [PhanNgocAnhAssiment]
GO

-- Insert Departments
INSERT INTO Departments (name, description) VALUES 
('IT', 'Phòng Công nghệ thông tin'),
('HR', 'Phòng Nhân sự'),
('Finance', 'Phòng Tài chính'),
('Marketing', 'Phòng Marketing'),
('Sales', 'Phòng Kinh doanh'),
('Operations', 'Phòng Vận hành'),
('Phòng Kỹ thuật', 'Technology Department'),
('Phòng Kinh doanh', 'Sales Department');

-- Insert Request Status
INSERT INTO Request_Status (name, description) VALUES 
('InProgress', 'Chờ duyệt'),
('Approved', 'Đã duyệt'),
('Rejected', 'Từ chối'),
('Cancelled', 'Đã hủy'),
('Pending', 'Request is pending approval');

-- Insert Roles
INSERT INTO Roles (name, description) VALUES 
('Employee', 'Nhân viên'),
('Manager', 'Quản lý'),
('Admin', 'Quản trị viên'),
('HR_Manager', 'Quản lý nhân sự');

-- Insert Features
INSERT INTO Features (name, description) VALUES 
('CREATE_REQUEST', 'Tạo đơn nghỉ phép'),
('VIEW_OWN_REQUESTS', 'Xem đơn của mình'),
('VIEW_ALL_REQUESTS', 'Xem tất cả đơn'),
('APPROVE_REQUESTS', 'Phê duyệt đơn'),
('MANAGE_USERS', 'Quản lý người dùng'),
('VIEW_REPORTS', 'Xem báo cáo'),
('MANAGE_DEPARTMENTS', 'Quản lý phòng ban'),
('VIEW_AGENDA', 'Xem lịch làm việc');

-- Insert Role-Feature mappings
-- Employee permissions
INSERT INTO Role_Features (role_id, feature_id) VALUES 
(1, 1), -- Employee can create requests
(1, 2); -- Employee can view own requests

-- Manager permissions
INSERT INTO Role_Features (role_id, feature_id) VALUES 
(2, 1), -- Manager can create requests
(2, 2), -- Manager can view own requests
(2, 3), -- Manager can view all requests (subordinates)
(2, 4), -- Manager can approve requests
(2, 8); -- Manager can view agenda

-- Admin permissions
INSERT INTO Role_Features (role_id, feature_id) VALUES 
(3, 1), -- Admin can create requests
(3, 2), -- Admin can view own requests
(3, 3), -- Admin can view all requests
(3, 4), -- Admin can approve requests
(3, 5), -- Admin can manage users
(3, 6), -- Admin can view reports
(3, 7), -- Admin can manage departments
(3, 8); -- Admin can view agenda

-- HR Manager permissions
INSERT INTO Role_Features (role_id, feature_id) VALUES 
(4, 1), -- HR Manager can create requests
(4, 2), -- HR Manager can view own requests
(4, 3), -- HR Manager can view all requests
(4, 4), -- HR Manager can approve requests
(4, 6), -- HR Manager can view reports
(4, 8); -- HR Manager can view agenda

-- Insert Users
-- Admin user
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES 
('admin', 'admin123', 'Administrator', 'admin@company.com', 1, NULL);

-- HR Manager
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES 
('hr_manager', 'hr123', 'Nguyễn Thị Hoa', 'hr.manager@company.com', 2, 1);

-- IT Manager
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES 
('it_manager', 'it123', 'Trần Văn Nam', 'it.manager@company.com', 1, 1);

-- Finance Manager
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES 
('finance_manager', 'finance123', 'Lê Thị Mai', 'finance.manager@company.com', 3, 1);

-- Marketing Manager
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES 
('marketing_manager', 'marketing123', 'Phạm Văn Dũng', 'marketing.manager@company.com', 4, 1);

-- Employees
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES 
-- IT Employees
('dev1', 'dev123', 'Nguyễn Văn An', 'dev1@company.com', 1, 3),
('dev2', 'dev123', 'Trần Thị Bình', 'dev2@company.com', 1, 3),
('dev3', 'dev123', 'Lê Văn Cường', 'dev3@company.com', 1, 3),
('tester1', 'test123', 'Phạm Thị Dung', 'tester1@company.com', 1, 3),

-- HR Employees
('hr1', 'hr123', 'Vũ Văn Em', 'hr1@company.com', 2, 2),
('hr2', 'hr123', 'Hoàng Thị Phương', 'hr2@company.com', 2, 2),

-- Finance Employees
('accountant1', 'acc123', 'Đỗ Văn Giang', 'accountant1@company.com', 3, 4),
('accountant2', 'acc123', 'Bùi Thị Hương', 'accountant2@company.com', 3, 4),

-- Marketing Employees
('marketer1', 'marketing123', 'Ngô Văn Khoa', 'marketer1@company.com', 4, 5),
('marketer2', 'marketing123', 'Đinh Thị Lan', 'marketer2@company.com', 4, 5),

-- Sales Employees
('sales1', 'sales123', 'Lý Văn Minh', 'sales1@company.com', 5, 1),
('sales2', 'sales123', 'Võ Thị Nga', 'sales2@company.com', 5, 1),

-- Operations Employees
('ops1', 'ops123', 'Hồ Văn Phúc', 'ops1@company.com', 6, 1),
('ops2', 'ops123', 'Nguyễn Thị Quỳnh', 'ops2@company.com', 6, 1);

-- Assign roles to users
-- Admin role
INSERT INTO User_Roles (user_id, role_id) VALUES (1, 3);

-- Manager roles
INSERT INTO User_Roles (user_id, role_id) VALUES 
(2, 4), -- HR Manager
(3, 2), -- IT Manager
(4, 2), -- Finance Manager
(5, 2); -- Marketing Manager

-- Employee roles
INSERT INTO User_Roles (user_id, role_id) VALUES 
(6, 1), (7, 1), (8, 1), (9, 1), -- IT Employees
(10, 1), (11, 1), -- HR Employees
(12, 1), (13, 1), -- Finance Employees
(14, 1), (15, 1), -- Marketing Employees
(16, 1), (17, 1), -- Sales Employees
(18, 1), (19, 1); -- Operations Employees

-- Insert sample leave requests
INSERT INTO Requests (user_id, title, start_date, end_date, reason, status_id, created_at, updated_at) VALUES 
-- Approved requests
(6, 'Nghỉ phép năm 2024', '2024-01-15', '2024-01-17', 'Nghỉ phép năm để về quê thăm gia đình', 2, GETDATE(), GETDATE()),
(7, 'Nghỉ ốm', '2024-01-20', '2024-01-21', 'Bị cảm cúm, cần nghỉ để hồi phục', 2, GETDATE(), GETDATE()),
(8, 'Nghỉ việc riêng', '2024-01-25', '2024-01-25', 'Có việc riêng cần xử lý', 2, GETDATE(), GETDATE()),

-- Pending requests
(9, 'Nghỉ phép năm', '2024-02-01', '2024-02-03', 'Nghỉ phép năm để đi du lịch', 1, GETDATE(), GETDATE()),
(10, 'Nghỉ ốm', '2024-02-05', '2024-02-06', 'Bị đau đầu, cần nghỉ để khám bệnh', 1, GETDATE(), GETDATE()),
(11, 'Nghỉ việc riêng', '2024-02-10', '2024-02-10', 'Có việc gia đình cần xử lý', 1, GETDATE(), GETDATE()),

-- Rejected requests
(12, 'Nghỉ phép dài', '2024-01-10', '2024-01-20', 'Nghỉ phép dài để đi du lịch nước ngoài', 3, GETDATE(), GETDATE()),
(13, 'Nghỉ ốm', '2024-01-12', '2024-01-15', 'Bị ốm cần nghỉ dài', 3, GETDATE(), GETDATE());

-- Insert request status history
INSERT INTO Request_Status_History (request_id, from_status_id, to_status_id, changed_by, changed_at, comment) VALUES 
-- History for approved requests
(1, 1, 2, 3, GETDATE(), 'Đơn được phê duyệt'),
(2, 1, 2, 3, GETDATE(), 'Đồng ý cho nghỉ ốm'),
(3, 1, 2, 3, GETDATE(), 'Phê duyệt nghỉ việc riêng'),

-- History for rejected requests
(6, 1, 3, 4, GETDATE(), 'Từ chối do thời gian nghỉ quá dài'),
(7, 1, 3, 4, GETDATE(), 'Cần giấy tờ y tế để xác nhận');

-- Display summary
SELECT 'Sample data inserted successfully!' as Message;
SELECT 'Departments:' as Info, COUNT(*) as Count FROM Departments
UNION ALL
SELECT 'Users:', COUNT(*) FROM Users
UNION ALL
SELECT 'Roles:', COUNT(*) FROM Roles
UNION ALL
SELECT 'Features:', COUNT(*) FROM Features
UNION ALL
SELECT 'Requests:', COUNT(*) FROM Requests
UNION ALL
SELECT 'Request History:', COUNT(*) FROM Request_Status_History;

-- Show test accounts
SELECT 'Test Accounts:' as Info;
SELECT username, password_hash as password, full_name, 
       (SELECT name FROM Roles r JOIN User_Roles ur ON r.role_id = ur.role_id WHERE ur.user_id = u.user_id) as role
FROM Users u 
WHERE username IN ('admin', 'hr_manager', 'it_manager', 'dev1', 'dev2')
ORDER BY username;

-- New users and roles
INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES
('manager1', '123456', 'Nguyễn Văn A', 'managera@company.com', 1, NULL),
('manager2', '123456', 'Trần Thị B', 'managerb@company.com', 2, NULL),
('employee1', '123456', 'Lê Văn C', 'employeec@company.com', 1, 2),
('employee2', '123456', 'Phạm Thị D', 'employeed@company.com', 1, 2),
('employee3', '123456', 'Hoàng Văn E', 'employeee@company.com', 2, 3),
('user1', '123456', 'Người Dùng Đa Năng', 'user1@company.com', 1, 2);

-- User Roles
INSERT INTO User_Roles (user_id, role_id) VALUES
(2, 2), -- manager1 is Manager
(3, 2), -- manager2 is Manager
(4, 1), -- employee1 is Employee
(5, 1), -- employee2 is Employee
(6, 1), -- employee3 is Employee
(7, 1), -- user1 is Employee
(7, 2); -- user1 is also Manager

-- Sample Requests
INSERT INTO Requests (user_id, title, start_date, end_date, reason, status_id, created_at, updated_at) VALUES
(4, 'Nghỉ phép năm', '2025-07-01', '2025-07-05', 'Đi du lịch cùng gia đình.', 1, GETDATE(), GETDATE()),
(5, 'Nghỉ ốm', '2025-06-25', '2025-06-25', 'Cảm thấy không khỏe.', 2, GETDATE(), GETDATE()),
(6, 'Nghỉ việc riêng', '2025-08-10', '2025-08-11', 'Giải quyết việc gia đình.', 3, GETDATE(), GETDATE()); 