<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .report-header { background: linear-gradient(135deg, #0d6efd 0%, #6a11cb 100%); color: white; padding: 2rem 0 1rem 0; margin-bottom: 2rem; }
        .report-header h1 { font-weight: 700; }
        .stat-card { background: white; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.07); padding: 2rem 1rem; text-align: center; margin-bottom: 2rem; }
        .stat-icon { font-size: 2.5rem; margin-bottom: 1rem; }
        .stat-label { color: #888; font-size: 1rem; }
        .stat-value { font-size: 2.2rem; font-weight: 700; color: #0d6efd; }
        .chart-placeholder { background: #e9ecef; border-radius: 10px; height: 260px; display: flex; align-items: center; justify-content: center; color: #adb5bd; font-size: 1.3rem; margin-bottom: 2rem; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="fas fa-chart-bar me-2"></i>Báo cáo hệ thống</a>
        <div class="navbar-nav ms-auto">
            <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-outline-light me-2">
                <i class="fas fa-arrow-left me-1"></i> Quay lại admin
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">
                <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
            </a>
        </div>
    </div>
</nav>
<div class="report-header text-center">
    <div class="container">
        <h1 class="mb-2"><i class="fas fa-chart-bar me-2"></i>Báo cáo tổng quan hệ thống</h1>
        <p class="lead mb-0">Thống kê hoạt động nghỉ phép, phòng ban, người dùng và quản lý</p>
    </div>
</div>
<div class="container">
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon text-primary"><i class="fas fa-users"></i></div>
                <div class="stat-value">18</div>
                <div class="stat-label">Tổng số nhân viên</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon text-success"><i class="fas fa-building"></i></div>
                <div class="stat-value">5</div>
                <div class="stat-label">Phòng ban</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon text-warning"><i class="fas fa-calendar-check"></i></div>
                <div class="stat-value">32</div>
                <div class="stat-label">Tổng số đơn nghỉ phép</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon text-danger"><i class="fas fa-user-tie"></i></div>
                <div class="stat-value">3</div>
                <div class="stat-label">Manager</div>
            </div>
        </div>
    </div>
    <div class="row mb-4">
        <div class="col-md-6">
            <div class="chart-placeholder">
                <i class="fas fa-chart-pie fa-2x me-2"></i> Biểu đồ phân bổ đơn nghỉ phép (placeholder)
            </div>
        </div>
        <div class="col-md-6">
            <div class="chart-placeholder">
                <i class="fas fa-chart-line fa-2x me-2"></i> Biểu đồ xu hướng nghỉ phép (placeholder)
            </div>
        </div>
    </div>
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin hệ thống</h5>
                </div>
                <div class="card-body">
                    <ul class="mb-0">
                        <li>Hệ thống quản lý nghỉ phép cho doanh nghiệp.</li>
                        <li>Quản lý phòng ban, nhân viên, đơn nghỉ phép, phân quyền.</li>
                        <li>Thống kê trực quan, báo cáo tổng hợp.</li>
                        <li>Giao diện hiện đại, dễ sử dụng, responsive.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 