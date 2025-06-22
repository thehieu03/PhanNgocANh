<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn nghỉ phép - Hệ thống Quản lý Nghỉ phép</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
        }
        .table th {
            border-top: none;
            background: #f8f9fa;
            font-weight: 600;
        }
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .filter-section {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
    <div class="container-fluid mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2>
                        <i class="fas fa-list me-2"></i>Danh sách đơn nghỉ phép
                    </h2>
                    <a href="Request?action=create" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Tạo đơn mới
                    </a>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <form method="GET" action="Request" class="row g-3">
                <input type="hidden" name="action" value="list">
                
                <div class="col-md-3">
                    <label for="statusFilter" class="form-label">Trạng thái</label>
                    <select class="form-select" id="statusFilter" name="status">
                        <option value="">Tất cả trạng thái</option>
                        <c:forEach var="status" items="${requestScope.statuses}">
                            <option value="${status.statusId}" 
                                    ${param.status == status.statusId ? 'selected' : ''}>
                                ${status.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="col-md-3">
                    <label for="startDateFilter" class="form-label">Từ ngày</label>
                    <input type="date" class="form-control" id="startDateFilter" 
                           name="fromDate" value="${param.fromDate}">
                </div>
                
                <div class="col-md-3">
                    <label for="endDateFilter" class="form-label">Đến ngày</label>
                    <input type="date" class="form-control" id="endDateFilter" 
                           name="toDate" value="${param.toDate}">
                </div>
                
                <div class="col-md-3">
                    <label class="form-label">&nbsp;</label>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-outline-primary">
                            <i class="fas fa-search me-2"></i>Lọc
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Requests Table -->
        <div class="card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Tiêu đề</th>
                                <th>Người tạo</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Số ngày</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty requestScope.requests}">
                                    <tr>
                                        <td colspan="9" class="text-center py-4">
                                            <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">Không có đơn nghỉ phép nào</p>
                                            <a href="Request?action=create" class="btn btn-primary">
                                                <i class="fas fa-plus me-2"></i>Tạo đơn đầu tiên
                                            </a>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="request" items="${requestScope.requests}">
                                        <tr>
                                            <td>
                                                <strong>#${request.requestId}</strong>
                                            </td>
                                            <td>
                                                <div class="fw-bold">${request.title}</div>
                                                <small class="text-muted">${request.reason}</small>
                                            </td>
                                            <td>
                                                <c:if test="${sessionScope.userRole == 'Manager' || sessionScope.userRole == 'Admin'}">
                                                    ${request.userName}
                                                </c:if>
                                                <c:if test="${sessionScope.userRole == 'Employee'}">
                                                    Bạn
                                                </c:if>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${request.startDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${request.endDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <c:set var="startDate" value="${request.startDate}"/>
                                                <c:set var="endDate" value="${request.endDate}"/>
                                                <c:set var="daysDiff" value="${(endDate.time - startDate.time) / (1000 * 60 * 60 * 24) + 1}"/>
                                                <span class="badge bg-info">${daysDiff} ngày</span>
                                            </td>
                                            <td>
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
                                                            <i class="fas fa-times me-1"></i>Từ chối
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary status-badge">
                                                            <i class="fas fa-question me-1"></i>Không xác định
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${request.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="Request?action=view&id=${request.requestId}" 
                                                       class="btn btn-sm btn-outline-primary" 
                                                       title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    
                                                    <c:if test="${request.statusId == 1 && sessionScope.userRole == 'Employee'}">
                                                        <a href="Request?action=edit&id=${request.requestId}" 
                                                           class="btn btn-sm btn-outline-warning" 
                                                           title="Chỉnh sửa">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <button type="button" 
                                                                class="btn btn-sm btn-outline-danger" 
                                                                title="Hủy đơn"
                                                                onclick="cancelRequest(${request.requestId})">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </c:if>
                                                    
                                                    <c:if test="${(sessionScope.userRole == 'Manager' || sessionScope.userRole == 'Admin') && request.statusId == 1}">
                                                        <button type="button" 
                                                                class="btn btn-sm btn-outline-success" 
                                                                title="Phê duyệt"
                                                                onclick="approveRequest(${request.requestId})">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                        <button type="button" 
                                                                class="btn btn-sm btn-outline-danger" 
                                                                title="Từ chối"
                                                                onclick="rejectRequest(${request.requestId})">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty requestScope.requests}">
            <div class="d-flex justify-content-between align-items-center mt-4">
                <div class="text-muted">
                    Hiển thị ${requestScope.startIndex + 1} - ${requestScope.endIndex} 
                    trong tổng số ${requestScope.totalRequests} đơn
                </div>
                
                <nav aria-label="Page navigation">
                    <ul class="pagination mb-0">
                        <c:if test="${requestScope.currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="Request?action=list&page=${requestScope.currentPage - 1}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="page" begin="1" end="${requestScope.totalPages}">
                            <li class="page-item ${page == requestScope.currentPage ? 'active' : ''}">
                                <a class="page-link" href="Request?action=list&page=${page}">${page}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${requestScope.currentPage < requestScope.totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="Request?action=list&page=${requestScope.currentPage + 1}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>

    <!-- Approval Modal -->
    <div class="modal fade" id="approvalModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Phê duyệt đơn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="approvalForm" method="POST" action="Approval">
                    <div class="modal-body">
                        <input type="hidden" id="requestId" name="requestId">
                        <input type="hidden" id="approvalAction" name="action">
                        
                        <div class="mb-3">
                            <label for="comment" class="form-label">Nhận xét (tùy chọn)</label>
                            <textarea class="form-control" id="comment" name="comment" rows="3" 
                                      placeholder="Nhập nhận xét..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="submitBtn">Xác nhận</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function approveRequest(requestId) {
            document.getElementById('modalTitle').textContent = 'Phê duyệt đơn';
            document.getElementById('requestId').value = requestId;
            document.getElementById('approvalAction').value = 'approve';
            document.getElementById('submitBtn').className = 'btn btn-success';
            document.getElementById('submitBtn').textContent = 'Phê duyệt';
            
            new bootstrap.Modal(document.getElementById('approvalModal')).show();
        }
        
        function rejectRequest(requestId) {
            document.getElementById('modalTitle').textContent = 'Từ chối đơn';
            document.getElementById('requestId').value = requestId;
            document.getElementById('approvalAction').value = 'reject';
            document.getElementById('submitBtn').className = 'btn btn-danger';
            document.getElementById('submitBtn').textContent = 'Từ chối';
            
            new bootstrap.Modal(document.getElementById('approvalModal')).show();
        }
        
        function cancelRequest(requestId) {
            if (confirm('Bạn có chắc chắn muốn hủy đơn này?')) {
                // Implement cancel request functionality
                alert('Chức năng hủy đơn sẽ được triển khai sau');
            }
        }
        
        // Auto-submit form when filters change
        document.getElementById('statusFilter').addEventListener('change', function() {
            this.form.submit();
        });
    </script>
</body>
</html> 