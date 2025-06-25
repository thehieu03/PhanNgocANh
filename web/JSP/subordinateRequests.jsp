<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn cấp dưới - Hệ thống Quản lý Nghỉ phép</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .request-card {
            transition: transform 0.2s ease-in-out;
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .request-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .status-badge {
            font-size: 0.8rem;
        }
        .navbar-brand {
            font-weight: bold;
        }
        .filter-section {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
            margin-bottom: 1rem;
        }
        .stats-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        .date-range {
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-tasks me-2"></i>Quản lý Đơn cấp dưới
            </a>
            <div class="navbar-nav ms-auto">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">
                    <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1">
                            <i class="fas fa-tasks me-2 text-primary"></i>Quản lý Đơn cấp dưới
                        </h2>
                        <p class="text-muted mb-0">Duyệt và quản lý đơn xin nghỉ phép của nhân viên cấp dưới</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/manager/home" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại
                    </a>
                </div>
            </div>
        </div>

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

        <!-- Statistics -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-primary">
                        <i class="fas fa-list"></i>
                    </div>
                    <h3 class="text-primary mb-1">${requests.size()}</h3>
                    <small class="text-muted">Tổng đơn</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-warning">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3 class="text-warning mb-1">
                        <c:set var="pendingCount" value="0"/>
                        <c:forEach var="req" items="${requests}">
                            <c:if test="${req.statusId == 1}">
                                <c:set var="pendingCount" value="${pendingCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${pendingCount}
                    </h3>
                    <small class="text-muted">Chờ duyệt</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-success">
                        <i class="fas fa-check"></i>
                    </div>
                    <h3 class="text-success mb-1">
                        <c:set var="approvedCount" value="0"/>
                        <c:forEach var="req" items="${requests}">
                            <c:if test="${req.statusId == 2}">
                                <c:set var="approvedCount" value="${approvedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${approvedCount}
                    </h3>
                    <small class="text-muted">Đã duyệt</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-icon text-danger">
                        <i class="fas fa-times"></i>
                    </div>
                    <h3 class="text-danger mb-1">
                        <c:set var="rejectedCount" value="0"/>
                        <c:forEach var="req" items="${requests}">
                            <c:if test="${req.statusId == 3}">
                                <c:set var="rejectedCount" value="${rejectedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${rejectedCount}
                    </h3>
                    <small class="text-muted">Đã từ chối</small>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <label for="statusFilter" class="form-label">Lọc theo trạng thái:</label>
                    <select class="form-select" id="statusFilter">
                        <option value="">Tất cả</option>
                        <option value="1">Chờ duyệt</option>
                        <option value="2">Đã duyệt</option>
                        <option value="3">Đã từ chối</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="dateFilter" class="form-label">Lọc theo tháng:</label>
                    <input type="month" class="form-control" id="dateFilter">
                </div>
                <div class="col-md-4">
                    <label class="form-label">&nbsp;</label>
                    <div>
                        <button class="btn btn-primary" onclick="applyFilters()">
                            <i class="fas fa-filter me-1"></i>Áp dụng
                        </button>
                        <button class="btn btn-outline-secondary" onclick="clearFilters()">
                            <i class="fas fa-times me-1"></i>Xóa bộ lọc
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Requests List -->
        <div class="row">
            <c:forEach var="req" items="${requests}">
                <div class="col-md-6 col-lg-4 mb-4 request-item" 
                     data-status="${req.statusId}" 
                     data-month="${req.startDate.monthValue}">
                    <div class="card request-card h-100">
                        <div class="card-header bg-light">
                            <div class="d-flex justify-content-between align-items-center">
                                <h6 class="mb-0">${req.title}</h6>
                                <c:choose>
                                    <c:when test="${req.statusId == 1}">
                                        <span class="badge bg-warning status-badge">
                                            <i class="fas fa-clock me-1"></i>Chờ duyệt
                                        </span>
                                    </c:when>
                                    <c:when test="${req.statusId == 2}">
                                        <span class="badge bg-success status-badge">
                                            <i class="fas fa-check me-1"></i>Đã duyệt
                                        </span>
                                    </c:when>
                                    <c:when test="${req.statusId == 3}">
                                        <span class="badge bg-danger status-badge">
                                            <i class="fas fa-times me-1"></i>Đã từ chối
                                        </span>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <strong>Người yêu cầu:</strong>
                                <div class="d-flex align-items-center mt-1">
                                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" 
                                         style="width: 30px; height: 30px; font-size: 0.8rem;">
                                        ${req.user.fullName.charAt(0)}
                                    </div>
                                    <span>${req.user.fullName}</span>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <strong>Thời gian:</strong>
                                <div class="date-range mt-1">
                                    <i class="fas fa-calendar me-1"></i>
                                    <span>
                                        <c:choose>
                                            <c:when test="${not empty req.startDate}">
                                                <fmt:formatDate value="${req.startDate}" pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span> - </span>
                                    <span>
                                        <c:choose>
                                            <c:when test="${not empty req.endDate}">
                                                <fmt:formatDate value="${req.endDate}" pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <strong>Lý do:</strong>
                                <p class="text-muted small mt-1 mb-0">${req.reason}</p>
                            </div>
                            
                            <div class="mb-3">
                                <strong>Ngày tạo:</strong>
                                <div class="text-muted small mt-1">
                                    <fmt:formatDate value="${req.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/subordinate-requests?action=view&id=${req.requestId}" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                                </a>
                                
                                <c:if test="${req.statusId == 1}">
                                    <button class="btn btn-success btn-sm" 
                                            onclick="approveRequest(${req.requestId})">
                                        <i class="fas fa-check me-1"></i>Duyệt
                                    </button>
                                    <button class="btn btn-danger btn-sm" 
                                            onclick="rejectRequest(${req.requestId})">
                                        <i class="fas fa-times me-1"></i>Từ chối
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Empty State -->
        <c:if test="${empty requests}">
            <div class="text-center py-5">
                <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                <h4 class="text-muted">Chưa có đơn nào</h4>
                <p class="text-muted">Hiện tại không có đơn xin nghỉ phép nào từ cấp dưới.</p>
            </div>
        </c:if>
    </div>

    <!-- Approve Modal -->
    <div class="modal fade" id="approveModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-check text-success me-2"></i>Duyệt đơn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="approveForm" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="approve">
                        <input type="hidden" name="id" id="approveRequestId">
                        <div class="mb-3">
                            <label for="approveComment" class="form-label">Ghi chú (tùy chọn):</label>
                            <textarea class="form-control" id="approveComment" name="comment" rows="3" 
                                      placeholder="Nhập ghi chú cho việc duyệt đơn..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check me-1"></i>Duyệt đơn
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Reject Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-times text-danger me-2"></i>Từ chối đơn
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="rejectForm" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="reject">
                        <input type="hidden" name="id" id="rejectRequestId">
                        <div class="mb-3">
                            <label for="rejectComment" class="form-label">Lý do từ chối:</label>
                            <textarea class="form-control" id="rejectComment" name="comment" rows="3" 
                                      placeholder="Nhập lý do từ chối đơn..." required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-times me-1"></i>Từ chối đơn
                        </button>
                    </div>
                </form>
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

        // Approve request
        function approveRequest(requestId) {
            document.getElementById('approveRequestId').value = requestId;
            var modal = new bootstrap.Modal(document.getElementById('approveModal'));
            modal.show();
        }

        // Reject request
        function rejectRequest(requestId) {
            document.getElementById('rejectRequestId').value = requestId;
            var modal = new bootstrap.Modal(document.getElementById('rejectModal'));
            modal.show();
        }

        // Apply filters
        function applyFilters() {
            var statusFilter = document.getElementById('statusFilter').value;
            var dateFilter = document.getElementById('dateFilter').value;
            var month = dateFilter ? new Date(dateFilter).getMonth() + 1 : null;
            
            var items = document.querySelectorAll('.request-item');
            items.forEach(function(item) {
                var show = true;
                
                if (statusFilter && item.dataset.status !== statusFilter) {
                    show = false;
                }
                
                if (month && parseInt(item.dataset.month) !== month) {
                    show = false;
                }
                
                item.style.display = show ? 'block' : 'none';
            });
        }

        // Clear filters
        function clearFilters() {
            document.getElementById('statusFilter').value = '';
            document.getElementById('dateFilter').value = '';
            
            var items = document.querySelectorAll('.request-item');
            items.forEach(function(item) {
                item.style.display = 'block';
            });
        }
    </script>
</body>
</html> 