<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản trị - Hệ thống Quản lý Nghỉ phép</title>
    <style>
        /* Using the same style as employeeHome/managerHome for consistency */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; min-height: 100vh; }
        .header { background: linear-gradient(135deg, #d32f2f 0%, #b71c1c 100%); color: white; padding: 1rem 2rem; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); }
        .header-content { display: flex; justify-content: space-between; align-items: center; max-width: 1200px; margin: 0 auto; }
        .header h1 { font-size: 1.5rem; font-weight: 600; }
        .user-info { display: flex; align-items: center; gap: 1rem; }
        .user-name { font-weight: 500; }
        .logout-btn { background: rgba(255, 255, 255, 0.2); color: white; border: none; padding: 0.5rem 1rem; border-radius: 5px; text-decoration: none; font-size: 0.9rem; transition: background 0.3s ease; }
        .logout-btn:hover { background: rgba(255, 255, 255, 0.3); }
        .main-content { max-width: 1200px; margin: 2rem auto; padding: 0 2rem; }
        .welcome-section { background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); margin-bottom: 2rem; text-align: center; }
        .welcome-section h2 { color: #333; margin-bottom: 0.5rem; }
        .welcome-section p { color: #666; font-size: 1.1rem; }
        .role-badge { display: inline-block; background: #c62828; color: white; padding: 0.25rem 1rem; border-radius: 20px; font-size: 0.9rem; font-weight: 600; margin-top: 1rem; }
        .menu-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; }
        .menu-card { background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); text-align: center; transition: transform 0.3s ease, box-shadow 0.3s ease; text-decoration: none; color: inherit; }
        .menu-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15); }
        .menu-icon { font-size: 3rem; color: #c62828; margin-bottom: 1rem; }
        .menu-card h3 { color: #333; margin-bottom: 1rem; font-size: 1.3rem; }
        .menu-card p { color: #666; line-height: 1.6; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>Trang Quản trị</h1>
            <div class="user-info">
                <span class="user-name">Xin chào, ${sessionScope.fullName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
            </div>
        </div>
    </div>
    
    <div class="main-content">
        <div class="welcome-section">
            <h2>Chào mừng đến trang Quản trị hệ thống</h2>
            <p>Quản lý người dùng, vai trò, và xem báo cáo tổng quan.</p>
            <div class="role-badge">Administrator</div>
        </div>
        
        <div class="menu-grid">
            <a href="${pageContext.request.contextPath}/users" class="menu-card">
                <div class="menu-icon">👥</div>
                <h3>Quản lý người dùng</h3>
                <p>Thêm, sửa, xóa và phân quyền cho người dùng trong hệ thống.</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/departments" class="menu-card">
                <div class="menu-icon">🏢</div>
                <h3>Quản lý phòng ban</h3>
                <p>Xem danh sách phòng ban và thông tin nhân viên trong từng phòng ban.</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/reports" class="menu-card">
                <div class="menu-icon">📊</div>
                <h3>Báo cáo hệ thống</h3>
                <p>Xem các báo cáo, thống kê toàn diện về hoạt động nghỉ phép.</p>
            </a>
        </div>
    </div>
</body>
</html> 