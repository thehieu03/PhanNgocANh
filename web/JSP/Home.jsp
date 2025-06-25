

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ - Hệ thống Quản lý Nghỉ phép</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f5f5;
            }
            
            .header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .header h1 {
                font-size: 24px;
            }
            
            .user-info {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            
            .logout-btn {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
            
            .logout-btn:hover {
                background: rgba(255, 255, 255, 0.3);
            }
            
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            
            .welcome-section {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                text-align: center;
            }
            
            .welcome-section h2 {
                color: #333;
                margin-bottom: 10px;
            }
            
            .welcome-section p {
                color: #666;
                font-size: 16px;
            }
            
            .menu-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                margin-top: 30px;
            }
            
            .menu-item {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                transition: transform 0.2s ease;
            }
            
            .menu-item:hover {
                transform: translateY(-5px);
            }
            
            .menu-item h3 {
                color: #333;
                margin-bottom: 15px;
            }
            
            .menu-item p {
                color: #666;
                margin-bottom: 20px;
            }
            
            .menu-btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-weight: 500;
            }
            
            .menu-btn:hover {
                opacity: 0.9;
            }
            
            .sidebar {
                min-height: 100vh;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
            .sidebar .nav-link {
                color: rgba(255, 255, 255, 0.8);
                padding: 12px 20px;
                border-radius: 8px;
                margin: 2px 10px;
                transition: all 0.3s ease;
            }
            .sidebar .nav-link:hover,
            .sidebar .nav-link.active {
                color: white;
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(5px);
            }
            .main-content {
                background: #f8f9fa;
                min-height: 100vh;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                transition: transform 0.3s ease;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .stat-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
            .stat-card.success {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            }
            .stat-card.warning {
                background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
            }
            .stat-card.info {
                background: linear-gradient(135deg, #17a2b8 0%, #6f42c1 100%);
            }
            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 px-0">
                    <div class="sidebar">
                        <div class="p-4">
                            <h4 class="text-center mb-4">
                                <i class="fas fa-calendar-alt me-2"></i>
                                Leave Manager
                            </h4>
                            
                            <!-- User Info -->
                            <div class="text-center mb-4 p-3" style="background: rgba(255, 255, 255, 0.1); border-radius: 10px;">
                                <i class="fas fa-user-circle fa-3x mb-2"></i>
                                <h6 class="mb-1">${sessionScope.fullName}</h6>
                                <small class="text-muted">${sessionScope.username}</small>
                            </div>
                            
                            <!-- Navigation Menu -->
                            <nav class="nav flex-column">
                                <a class="nav-link active" href="Home">
                                    <i class="fas fa-home me-2"></i>Trang chủ
                                </a>
                                
                                <!-- Employee Menu -->
                                <c:if test="${sessionScope.userRole == 'Employee' || sessionScope.userRole == 'Manager' || sessionScope.userRole == 'Admin'}">
                                    <a class="nav-link" href="Request?action=create">
                                        <i class="fas fa-plus me-2"></i>Tạo đơn nghỉ phép
                                    </a>
                                    <a class="nav-link" href="Request?action=list">
                                        <i class="fas fa-list me-2"></i>Đơn của tôi
                                    </a>
                                </c:if>
                                
                                <!-- Manager Menu -->
                                <c:if test="${sessionScope.userRole == 'Manager' || sessionScope.userRole == 'Admin'}">
                                    <a class="nav-link" href="Request?action=list">
                                        <i class="fas fa-tasks me-2"></i>Quản lý đơn cấp dưới
                                    </a>
                                    <a class="nav-link" href="Agenda">
                                        <i class="fas fa-calendar me-2"></i>Lịch làm việc
                                    </a>
                                </c:if>
                                
                                <!-- Admin Menu -->
                                <c:if test="${sessionScope.userRole == 'Admin'}">
                                    <a class="nav-link" href="Dashboard">
                                        <i class="fas fa-chart-bar me-2"></i>Báo cáo tổng quan
                                    </a>
                                    <a class="nav-link" href="UserManagement">
                                        <i class="fas fa-users me-2"></i>Quản lý người dùng
                                    </a>
                                </c:if>
                                
                                <hr class="my-3" style="border-color: rgba(255, 255, 255, 0.2);">
                                
                                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                </a>
                            </nav>
                        </div>
                    </div>
                </div>
                
                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 px-0">
                    <div class="main-content">
                        <!-- Top Navigation -->
                        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                            <div class="container-fluid">
                                <span class="navbar-brand">
                                    <i class="fas fa-home me-2"></i>Trang chủ
                                </span>
                                <div class="navbar-nav ms-auto">
                                    <span class="navbar-text me-3">
                                        <i class="fas fa-clock me-1"></i>
                                        <span id="currentTime"></span>
                                    </span>
                                </div>
                            </div>
                        </nav>
                        
                        <!-- Content Area -->
                        <div class="p-4">
                            <!-- Welcome Message -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-body text-center py-5">
                                            <i class="fas fa-calendar-check fa-4x text-primary mb-3"></i>
                                            <h2 class="card-title">Chào mừng đến với Hệ thống Quản lý Nghỉ phép</h2>
                                            <p class="card-text text-muted">
                                                Xin chào ${sessionScope.fullName}! Hôm nay bạn muốn làm gì?
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Statistics Cards -->
                            <div class="row mb-4">
                                <div class="col-md-3 mb-3">
                                    <div class="card stat-card">
                                        <div class="card-body text-center">
                                            <i class="fas fa-file-alt fa-2x mb-2"></i>
                                            <h4 class="mb-1">${requestScope.totalRequests}</h4>
                                            <small>Tổng đơn nghỉ phép</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card stat-card success">
                                        <div class="card-body text-center">
                                            <i class="fas fa-check-circle fa-2x mb-2"></i>
                                            <h4 class="mb-1">${requestScope.approvedRequests}</h4>
                                            <small>Đơn đã duyệt</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card stat-card warning">
                                        <div class="card-body text-center">
                                            <i class="fas fa-clock fa-2x mb-2"></i>
                                            <h4 class="mb-1">${requestScope.pendingRequests}</h4>
                                            <small>Đơn chờ duyệt</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card stat-card info">
                                        <div class="card-body text-center">
                                            <i class="fas fa-calendar-day fa-2x mb-2"></i>
                                            <h4 class="mb-1">${requestScope.leaveBalance}</h4>
                                            <small>Ngày phép còn lại</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Quick Actions -->
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <div class="card h-100">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-bolt me-2"></i>Thao tác nhanh
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-grid gap-2">
                                                <a href="Request?action=create" class="btn btn-outline-primary">
                                                    <i class="fas fa-plus me-2"></i>Tạo đơn nghỉ phép mới
                                                </a>
                                                <a href="Request?action=list" class="btn btn-outline-info">
                                                    <i class="fas fa-list me-2"></i>Xem danh sách đơn
                                                </a>
                                                <c:if test="${sessionScope.userRole == 'Manager' || sessionScope.userRole == 'Admin'}">
                                                    <a href="Agenda" class="btn btn-outline-success">
                                                        <i class="fas fa-calendar me-2"></i>Xem lịch làm việc
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-4">
                                    <div class="card h-100">
                                        <div class="card-header bg-success text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-chart-line me-2"></i>Thống kê gần đây
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row text-center">
                                                <div class="col-6">
                                                    <h4 class="text-primary">${requestScope.thisMonthRequests}</h4>
                                                    <small class="text-muted">Đơn tháng này</small>
                                                </div>
                                                <div class="col-6">
                                                    <h4 class="text-success">${requestScope.thisMonthApproved}</h4>
                                                    <small class="text-muted">Đã duyệt tháng này</small>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row text-center">
                                                <div class="col-6">
                                                    <h4 class="text-warning">${requestScope.thisMonthPending}</h4>
                                                    <small class="text-muted">Chờ duyệt</small>
                                                </div>
                                                <div class="col-6">
                                                    <h4 class="text-danger">${requestScope.thisMonthRejected}</h4>
                                                    <small class="text-muted">Từ chối</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Update current time
            function updateTime() {
                const now = new Date();
                const timeString = now.toLocaleString('vi-VN');
                document.getElementById('currentTime').textContent = timeString;
            }
            
            updateTime();
            setInterval(updateTime, 1000);
            
            // Show success message if exists
            <c:if test="${not empty sessionScope.message}">
                alert('${sessionScope.message}');
                <c:remove var="message" scope="session"/>
            </c:if>
        </script>
    </body>
</html> 