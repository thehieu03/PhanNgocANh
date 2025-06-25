<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Phòng ban</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .department-card { transition: transform 0.2s; border: none; box-shadow: 0 2px 4px rgba(0,0,0,0.08); position: relative; }
        .department-card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.13); }
        .department-icon { font-size: 2.5rem; color: #007bff; }
        .stats-badge { font-size: 0.8rem; }
        .card-actions { position: absolute; top: 0.5rem; right: 0.5rem; z-index: 2; }
        .card-actions button { border: none; background: none; color: #495057; margin-left: 0.3rem; font-size: 1.1rem; }
        .card-actions button:hover { color: #0d6efd; }
        .add-btn { font-weight: 500; letter-spacing: 0.5px; }
        .modal-header { background: #0d6efd; color: white; }
        .modal-title { font-weight: 600; }
        .form-label { font-weight: 500; }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-building me-2"></i>Quản lý Phòng ban
            </a>
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

    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1">
                            <i class="fas fa-building me-2 text-primary"></i>Danh sách Phòng ban
                        </h2>
                        <p class="text-muted mb-0">Quản lý và xem thông tin các phòng ban trong công ty</p>
                    </div>
                    <button class="btn btn-primary add-btn" data-bs-toggle="modal" data-bs-target="#addDeptModal">
                        <i class="fas fa-plus me-1"></i> Thêm phòng ban
                    </button>
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

        <!-- Departments Grid -->
        <div class="row">
            <c:forEach var="dept" items="${departments}">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card department-card h-100">
                        <div class="card-actions">
                            <button class="edit-btn" title="Sửa" data-bs-toggle="modal" data-bs-target="#editDeptModal" data-id="${dept.departmentId}" data-name="${dept.name}" data-desc="${dept.description}">
                                <i class="fas fa-pen"></i>
                            </button>
                            <button class="delete-btn" title="Xóa" data-bs-toggle="modal" data-bs-target="#deleteDeptModal" data-id="${dept.departmentId}" data-name="${dept.name}">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                        <div class="card-body text-center">
                            <div class="mb-3">
                                <i class="fas fa-building department-icon"></i>
                            </div>
                            <h5 class="card-title text-primary">${dept.name}</h5>
                            <p class="card-text text-muted">
                                <c:choose>
                                    <c:when test="${not empty dept.description}">
                                        ${dept.description}
                                    </c:when>
                                    <c:otherwise>
                                        <em>Chưa có mô tả</em>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            
                            <div class="mt-3">
                                <span class="badge bg-info stats-badge me-2">
                                    <i class="fas fa-users me-1"></i>Nhân viên
                                </span>
                                <span class="badge bg-success stats-badge">
                                    <i class="fas fa-chart-line me-1"></i>Hoạt động
                                </span>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-top-0">
                            <a href="${pageContext.request.contextPath}/departments?action=view&id=${dept.departmentId}" 
                               class="btn btn-primary btn-sm w-100">
                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Empty State -->
        <c:if test="${empty departments}">
            <div class="text-center py-5">
                <i class="fas fa-building fa-4x text-muted mb-3"></i>
                <h4 class="text-muted">Chưa có phòng ban nào</h4>
                <p class="text-muted">Hệ thống chưa có thông tin phòng ban.</p>
            </div>
        </c:if>

        <!-- Summary Stats -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="fas fa-chart-bar me-2"></i>Thống kê tổng quan
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-md-3 mb-3">
                                <div class="border-end">
                                    <h3 class="text-primary mb-1">${departments.size()}</h3>
                                    <small class="text-muted">Tổng số phòng ban</small>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="border-end">
                                    <h3 class="text-success mb-1">5</h3>
                                    <small class="text-muted">Phòng ban hoạt động</small>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="border-end">
                                    <h3 class="text-info mb-1">18</h3>
                                    <small class="text-muted">Tổng nhân viên</small>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div>
                                    <h3 class="text-warning mb-1">3</h3>
                                    <small class="text-muted">Manager</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thêm phòng ban -->
    <div class="modal fade" id="addDeptModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus me-2"></i>Thêm phòng ban</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/departments?action=add" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Tên phòng ban</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Sửa phòng ban -->
    <div class="modal fade" id="editDeptModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-pen me-2"></i>Sửa phòng ban</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="editDeptForm" action="${pageContext.request.contextPath}/departments?action=edit" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editDeptId">
                        <div class="mb-3">
                            <label class="form-label">Tên phòng ban</label>
                            <input type="text" class="form-control" name="name" id="editDeptName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" id="editDeptDesc" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Xóa phòng ban -->
    <div class="modal fade" id="deleteDeptModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="fas fa-trash me-2"></i>Xóa phòng ban</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="deleteDeptForm" action="${pageContext.request.contextPath}/departments?action=delete" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" id="deleteDeptId">
                        <p>Bạn có chắc chắn muốn xóa phòng ban <strong id="deleteDeptName"></strong>?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var editModal = document.getElementById('editDeptModal');
        editModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var name = button.getAttribute('data-name');
            var desc = button.getAttribute('data-desc');
            document.getElementById('editDeptId').value = id;
            document.getElementById('editDeptName').value = name;
            document.getElementById('editDeptDesc').value = desc;
        });
        var deleteModal = document.getElementById('deleteDeptModal');
        deleteModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var name = button.getAttribute('data-name');
            document.getElementById('deleteDeptId').value = id;
            document.getElementById('deleteDeptName').textContent = name;
        });
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