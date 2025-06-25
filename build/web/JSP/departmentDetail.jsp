<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Phòng ban - ${department.name}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .department-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .user-card {
            transition: transform 0.2s ease-in-out;
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .user-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .role-badge {
            font-size: 0.75rem;
        }
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stats-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-building me-2"></i>${department.name}
            </a>
            <div class="navbar-nav ms-auto">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">
                    <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- Department Header -->
    <div class="department-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-2">
                        <i class="fas fa-building me-3"></i>${department.name}
                    </h1>
                    <p class="mb-0 opacity-75">
                        <c:choose>
                            <c:when test="${not empty department.description}">
                                ${department.description}
                            </c:when>
                            <c:otherwise>
                                <em>Chưa có mô tả chi tiết</em>
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="col-md-4 text-md-end">
                    <a href="${pageContext.request.contextPath}/departments" class="btn btn-outline-light">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Success Message -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Department Stats -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-primary">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="text-primary mb-1">${users.size()}</h3>
                    <small class="text-muted">Tổng nhân viên</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-success">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <h3 class="text-success mb-1">
                        <c:set var="managerCount" value="0"/>
                        <c:forEach var="user" items="${users}">
                            <c:if test="${user.managerId != null}">
                                <c:set var="managerCount" value="${managerCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${managerCount}
                    </h3>
                    <small class="text-muted">Manager</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-info">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3 class="text-info mb-1">
                        <c:set var="employeeCount" value="0"/>
                        <c:forEach var="user" items="${users}">
                            <c:if test="${user.managerId == null}">
                                <c:set var="employeeCount" value="${employeeCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${employeeCount}
                    </h3>
                    <small class="text-muted">Nhân viên</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-warning">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3 class="text-warning mb-1">${department.departmentId}</h3>
                    <small class="text-muted">Mã phòng ban</small>
                </div>
            </div>
        </div>

        <!-- Users List -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="fas fa-users me-2"></i>Danh sách Nhân viên
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty users}">
                                <div class="row">
                                    <c:forEach var="user" items="${users}">
                                        <div class="col-md-6 col-lg-4 mb-3">
                                            <div class="card user-card h-100">
                                                <div class="card-body">
                                                    <div class="d-flex align-items-center mb-3">
                                                        <div class="user-avatar me-3">
                                                            ${user.fullName.charAt(0)}
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-1">${user.fullName}</h6>
                                                            <small class="text-muted">${user.username}</small>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="mb-2">
                                                        <span class="badge bg-primary role-badge me-1">
                                                            <i class="fas fa-envelope me-1"></i>${user.email}
                                                        </span>
                                                    </div>
                                                    
                                                    <div class="mb-2">
                                                        <c:choose>
                                                            <c:when test="${user.managerId != null}">
                                                                <span class="badge bg-success role-badge">
                                                                    <i class="fas fa-user-tie me-1"></i>Manager
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-info role-badge">
                                                                    <i class="fas fa-user me-1"></i>Employee
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    
                                                    <div class="text-muted small">
                                                        <i class="fas fa-id-badge me-1"></i>ID: ${user.userId}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-users fa-4x text-muted mb-3"></i>
                                    <h5 class="text-muted">Chưa có nhân viên nào</h5>
                                    <p class="text-muted">Phòng ban này chưa có nhân viên được phân công.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Department Information -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="fas fa-info-circle me-2"></i>Thông tin Phòng ban
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Tên phòng ban:</strong></td>
                                        <td>${department.name}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Mã phòng ban:</strong></td>
                                        <td>${department.departmentId}</td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Mô tả:</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty department.description}">
                                                    ${department.description}
                                                </c:when>
                                                <c:otherwise>
                                                    <em>Chưa có mô tả</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Số nhân viên:</strong></td>
                                        <td>${users.size()} người</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html> 