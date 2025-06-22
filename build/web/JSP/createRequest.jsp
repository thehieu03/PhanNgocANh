<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo đơn nghỉ phép - Hệ thống Quản lý Nghỉ phép</title>
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
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-plus me-2"></i>Tạo đơn nghỉ phép mới
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
                        
                        <form action="Request" method="POST" id="requestForm">
                            <input type="hidden" name="action" value="create">
                            
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="title" class="form-label">
                                        <i class="fas fa-heading me-1"></i>Tiêu đề đơn
                                    </label>
                                    <input type="text" class="form-control" id="title" name="title" 
                                           placeholder="Nhập tiêu đề đơn nghỉ phép" required
                                           value="${requestScope.title}">
                                    <div class="form-text">Ví dụ: Nghỉ phép năm 2024, Nghỉ ốm, Nghỉ việc riêng...</div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="startDate" class="form-label">
                                        <i class="fas fa-calendar-plus me-1"></i>Ngày bắt đầu
                                    </label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" 
                                           required min="${requestScope.today}">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="endDate" class="form-label">
                                        <i class="fas fa-calendar-minus me-1"></i>Ngày kết thúc
                                    </label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" 
                                           required min="${requestScope.today}">
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="reason" class="form-label">
                                        <i class="fas fa-comment me-1"></i>Lý do nghỉ phép
                                    </label>
                                    <textarea class="form-control" id="reason" name="reason" rows="4" 
                                              placeholder="Mô tả chi tiết lý do nghỉ phép..." required>${requestScope.reason}</textarea>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <strong>Lưu ý:</strong>
                                        <ul class="mb-0 mt-2">
                                            <li>Đơn nghỉ phép sẽ được gửi đến quản lý trực tiếp để phê duyệt</li>
                                            <li>Ngày bắt đầu không được trong quá khứ</li>
                                            <li>Ngày kết thúc phải sau ngày bắt đầu</li>
                                            <li>Bạn có thể theo dõi trạng thái đơn trong mục "Đơn của tôi"</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="Request?action=list" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-paper-plane me-2"></i>Gửi đơn
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('startDate').min = today;
        document.getElementById('endDate').min = today;
        
        // Update end date minimum when start date changes
        document.getElementById('startDate').addEventListener('change', function() {
            document.getElementById('endDate').min = this.value;
            if (document.getElementById('endDate').value && 
                document.getElementById('endDate').value < this.value) {
                document.getElementById('endDate').value = this.value;
            }
        });
        
        // Form validation
        document.getElementById('requestForm').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const reason = document.getElementById('reason').value.trim();
            
            if (!title || !startDate || !endDate || !reason) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin!');
                return false;
            }
            
            if (startDate > endDate) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
                return false;
            }
            
            if (startDate < today) {
                e.preventDefault();
                alert('Ngày bắt đầu không được trong quá khứ!');
                return false;
            }
        });
        
        // Calculate and display number of days
        function calculateDays() {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);
            
            if (startDate && endDate && startDate <= endDate) {
                const diffTime = Math.abs(endDate - startDate);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
                
                // Remove existing day count display
                const existingDisplay = document.getElementById('dayCount');
                if (existingDisplay) {
                    existingDisplay.remove();
                }
                
                // Add new day count display
                const dayCountDiv = document.createElement('div');
                dayCountDiv.id = 'dayCount';
                dayCountDiv.className = 'alert alert-success mt-2';
                dayCountDiv.innerHTML = `<i class="fas fa-calendar-day me-2"></i>Số ngày nghỉ: <strong>${diffDays} ngày</strong>`;
                
                document.getElementById('endDate').parentNode.appendChild(dayCountDiv);
            }
        }
        
        document.getElementById('startDate').addEventListener('change', calculateDays);
        document.getElementById('endDate').addEventListener('change', calculateDays);
    </script>
</body>
</html> 