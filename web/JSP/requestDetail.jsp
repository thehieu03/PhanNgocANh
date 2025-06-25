<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Đơn - ${request.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .request-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .info-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }
        .status-badge {
            font-size: 1rem;
            padding: 0.5rem 1rem;
        }
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .requester-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-file-alt me-2"></i>Chi tiết Đơn
            </a>
            <div class="navbar-nav ms-auto">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">
                    <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- Request Header -->
    <div class="request-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-2">
                        <i class="fas fa-file-alt me-3"></i>${request.title}
                    </h1>
                    <p class="mb-0 opacity-75">Đơn xin nghỉ phép từ nhân viên cấp dưới</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <a href="${pageContext.request.contextPath}/subordinate-requests" class="btn btn-outline-light">
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

        <div class="row">
            <!-- Request Information -->
            <div class="col-md-8">
                <div class="info-card">
                    <h4 class="mb-3">
                        <i class="fas fa-info-circle me-2 text-primary"></i>Thông tin Đơn
                    </h4>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <strong>Tiêu đề:</strong>
                            <p class="text-muted">${request.title}</p>
                        </div>
                        <div class="col-md-6">
                            <strong>Trạng thái:</strong>
                            <div class="mt-1">
                                <c:choose>
                                    <c:when test="${request.statusId == 1}">
                                        <span class="badge bg-warning status-badge">
                                            <i class="fas fa-clock me-1"></i>Chờ duyệt
                                        </span>
                                    </c:when>
                                    <c:when test="${request.statusId == 2}">
                                        <span class="badge bg-success status-badge">
                                            <i class="fas fa-check me-1"></i>Đã duyệt
                                        </span>
                                    </c:when>
                                    <c:when test="${request.statusId == 3}">
                                        <span class="badge bg-danger status-badge">
                                            <i class="fas fa-times me-1"></i>Đã từ chối
                                        </span>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <strong>Ngày bắt đầu:</strong>
                            <p class="text-muted">
                                <i class="fas fa-calendar me-1"></i>
                                <fmt:formatDate value="${request.startDate}" pattern="dd/MM/yyyy"/>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <strong>Ngày kết thúc:</strong>
                            <p class="text-muted">
                                <i class="fas fa-calendar me-1"></i>
                                <fmt:formatDate value="${request.endDate}" pattern="dd/MM/yyyy"/>
                            </p>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <strong>Lý do:</strong>
                        <div class="mt-2 p-3 bg-light rounded">
                            ${request.reason}
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <strong>Ngày tạo:</strong>
                            <p class="text-muted">
                                <i class="fas fa-clock me-1"></i>
                                <fmt:formatDate value="${request.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <strong>Cập nhật lần cuối:</strong>
                            <p class="text-muted">
                                <i class="fas fa-edit me-1"></i>
                                <fmt:formatDate value="${request.updatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Requester Information -->
            <div class="col-md-4">
                <div class="info-card">
                    <h4 class="mb-3">
                        <i class="fas fa-user me-2 text-primary"></i>Người yêu cầu
                    </h4>
                    
                    <div class="text-center mb-3">
                        <div class="requester-avatar mx-auto mb-3">
                            ${requester.fullName.charAt(0)}
                        </div>
                        <h5>${requester.fullName}</h5>
                        <p class="text-muted">${requester.username}</p>
                    </div>
                    
                    <div class="mb-3">
                        <strong>Email:</strong>
                        <p class="text-muted">${requester.email}</p>
                    </div>
                    
                    <div class="mb-3">
                        <strong>ID nhân viên:</strong>
                        <p class="text-muted">${requester.userId}</p>
                    </div>
                </div>

                <!-- Action Buttons -->
                <c:if test="${request.statusId == 1}">
                    <div class="info-card">
                        <h4 class="mb-3">
                            <i class="fas fa-tasks me-2 text-primary"></i>Thao tác
                        </h4>
                        
                        <div class="action-buttons">
                            <button class="btn btn-success btn-lg w-100 mb-2" onclick="approveRequest()">
                                <i class="fas fa-check me-2"></i>Duyệt đơn
                            </button>
                            <button class="btn btn-danger btn-lg w-100" onclick="rejectRequest()">
                                <i class="fas fa-times me-2"></i>Từ chối đơn
                            </button>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
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
                <form action="${pageContext.request.contextPath}/subordinate-requests" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="approve">
                        <input type="hidden" name="id" value="${request.requestId}">
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
                <form action="${pageContext.request.contextPath}/subordinate-requests" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="reject">
                        <input type="hidden" name="id" value="${request.requestId}">
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
        function approveRequest() {
            var modal = new bootstrap.Modal(document.getElementById('approveModal'));
            modal.show();
        }

        // Reject request
        function rejectRequest() {
            var modal = new bootstrap.Modal(document.getElementById('rejectModal'));
            modal.show();
        }
    </script>
</body>
</html> 