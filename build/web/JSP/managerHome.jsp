<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ Quản lý - Hệ thống Quản lý Nghỉ phép</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header h1 {
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-name {
            font-weight: 500;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background 0.3s ease;
        }
        
        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
            text-decoration: none;
        }
        
        .main-content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .welcome-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .welcome-section h2 {
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .welcome-section p {
            color: #666;
            font-size: 1.1rem;
        }
        
        .role-badge {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 0.25rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-top: 1rem;
        }
        
        .department-info {
            background: #e8f4fd;
            color: #0c5460;
            padding: 1rem;
            border-radius: 5px;
            margin-top: 1rem;
            border-left: 4px solid #17a2b8;
        }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .menu-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            color: inherit;
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
            text-decoration: none;
            color: inherit;
        }
        
        .menu-icon {
            font-size: 3rem;
            color: #667eea;
            margin-bottom: 1rem;
        }
        
        .menu-card h3 {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.3rem;
        }
        
        .menu-card p {
            color: #666;
            line-height: 1.6;
        }
        
        .stats-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .stats-section h3 {
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.2rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        
        .stat-item {
            text-align: center;
            padding: 1rem;
            background: #f8f9ff;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .pending-alerts {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .pending-alerts h3 {
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.2rem;
        }
        
        .alert-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            margin-bottom: 0.5rem;
        }
        
        .alert-info {
            flex: 1;
        }
        
        .alert-employee {
            font-weight: 600;
            color: #333;
        }
        
        .alert-dates {
            color: #666;
            font-size: 0.9rem;
        }
        
        .alert-action {
            background: #667eea;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background 0.3s ease;
        }
        
        .alert-action:hover {
            background: #5a6fd8;
            color: white;
            text-decoration: none;
        }
        
        .context-switch {
            text-align: center;
            margin-top: 2rem;
        }
        
        .context-switch a {
            color: #667eea;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .context-switch a:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .menu-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .alert-item {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>Hệ thống Quản lý Nghỉ phép</h1>
            <div class="user-info">
                <span class="user-name">Xin chào, ${sessionScope.fullName}</span>
                <a href="logout" class="logout-btn">Đăng xuất</a>
            </div>
        </div>
    </div>
    
    <div class="main-content">
        <div class="welcome-section">
            <h2>Trang chủ Quản lý</h2>
            <p>Chào mừng bạn đến với hệ thống quản lý nghỉ phép</p>
            <div class="role-badge">Quản lý</div>
            <div class="department-info">
                <strong>Phòng ban:</strong> ${sessionScope.selectedDeptName}
            </div>
        </div>
        
        <div class="menu-grid">
            <a href="requests/list?deptId=${sessionScope.selectedDept}" class="menu-card">
                <div class="menu-icon">📋</div>
                <h3>Xem/duyệt đơn cấp dưới</h3>
                <p>Xem danh sách đơn nghỉ phép của nhân viên trong phòng ban và thực hiện duyệt/từ chối</p>
            </a>
            
            <a href="agenda?deptId=${sessionScope.selectedDept}" class="menu-card">
                <div class="menu-icon">📅</div>
                <h3>Xem agenda phòng ban</h3>
                <p>Xem lịch nghỉ phép của phòng ban theo tháng để quản lý nhân sự hiệu quả</p>
            </a>
        </div>
        
        <div class="stats-section">
            <h3>Thống kê đơn nghỉ phép phòng ban</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">${deptStats.pending}</div>
                    <div class="stat-label">Đang chờ duyệt</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${deptStats.approved}</div>
                    <div class="stat-label">Đã được duyệt</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${deptStats.rejected}</div>
                    <div class="stat-label">Bị từ chối</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${deptStats.total}</div>
                    <div class="stat-label">Tổng số đơn</div>
                </div>
            </div>
        </div>
        
        <c:if test="${not empty pendingRequests}">
            <div class="pending-alerts">
                <h3>Đơn nghỉ phép cần duyệt</h3>
                <c:forEach var="request" items="${pendingRequests}">
                    <div class="alert-item">
                        <div class="alert-info">
                            <div class="alert-employee">${request.employeeName}</div>
                            <div class="alert-dates">Từ ${request.startDate} đến ${request.endDate}</div>
                        </div>
                        <a href="requests/view?id=${request.requestId}" class="alert-action">Xem chi tiết</a>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <c:if test="${sessionScope.roleContexts.size() > 1}">
            <div class="context-switch">
                <a href="selectContext">Chuyển đổi ngữ cảnh khác</a>
            </div>
        </c:if>
    </div>
    
    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Add click animation to menu cards
            const menuCards = document.querySelectorAll('.menu-card');
            menuCards.forEach(card => {
                card.addEventListener('click', function() {
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
            
            // Add click animation to alert actions
            const alertActions = document.querySelectorAll('.alert-action');
            alertActions.forEach(action => {
                action.addEventListener('click', function() {
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
        });
    </script>
</body>
</html> 