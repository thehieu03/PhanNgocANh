<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - Hệ thống Quản lý Nghỉ phép</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 500px;
            width: 100%;
        }
        .error-header {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        .error-body {
            padding: 40px 30px;
        }
        .btn-home {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
            color: white;
            transform: translateY(-2px);
        }
        /* CSS cho khung debug */
        .debug-box {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            padding: 15px;
            margin-top: 20px;
            font-size: 0.85em;
            white-space: pre-wrap;
            max-height: 300px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-header">
            <i class="fas fa-exclamation-triangle fa-4x mb-3"></i>
            <h2 class="mb-2">
                <c:choose>
                    <c:when test="${not empty requestScope.error}">Có lỗi xảy ra</c:when>
                    <c:when test="${pageContext.errorData.statusCode == 404}">Không tìm thấy trang</c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">Lỗi máy chủ</c:when>
                    <c:otherwise>Lỗi không xác định</c:otherwise>
                </c:choose>
            </h2>
            <p class="mb-0">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">Trang bạn đang tìm kiếm không tồn tại</c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">Có lỗi xảy ra trên máy chủ</c:when>
                    <c:otherwise>Vui lòng thử lại sau</c:otherwise>
                </c:choose>
            </p>
        </div>
        
        <div class="error-body text-center">
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger mb-4">
                    <i class="fas fa-info-circle me-2"></i>
                    ${requestScope.error}
                </div>
            </c:if>
            
            <c:if test="${pageContext.errorData.statusCode != 0}">
                <div class="alert alert-info mb-4">
                    <strong>Mã lỗi:</strong> ${pageContext.errorData.statusCode}
                    <br>
                    <strong>URL:</strong> ${pageContext.errorData.requestURI}
                </div>
            </c:if>
            
            <!-- Khung debug: in exception + stacktrace -->
            <div class="debug-box text-start">
                <c:choose>
                    <c:when test="${not empty requestScope.exceptionMessage}">
                        <strong>Exception:</strong> ${requestScope.exceptionMessage}<br/>
                        <strong>Stack trace:</strong><br/>
                        <pre style="white-space: pre-wrap;">${requestScope.stackTrace}</pre>
                    </c:when>
                    <c:otherwise>
                        <strong>Exception:</strong>
                        <%= exception == null ? "Không có exception." : exception.toString() %>
                        <br/><strong>Stack trace:</strong><br/>
                        <% if (exception != null) {
                             for (StackTraceElement el : exception.getStackTrace()) {
                               out.println("&nbsp;&nbsp;at " + el + "<br/>");
                             }
                           }
                        %>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="mb-4">
                <p class="text-muted">
                    Nếu vấn đề vẫn tiếp tục, vui lòng liên hệ quản trị viên hệ thống.
                </p>
            </div>
            
            <div class="d-grid gap-2">
                <a href="Home" class="btn btn-home">
                    <i class="fas fa-home me-2"></i>Về trang chủ
                </a>
                <button onclick="history.back()" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                </button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto redirect to home after 10 seconds
        setTimeout(() => window.location.href = 'Home', 10000);

        let countdown = 10;
        const countdownElement = document.createElement('div');
        countdownElement.className = 'text-center mt-3';
        countdownElement.innerHTML = `<small class="text-muted">Tự động chuyển về trang chủ sau <span id="countdown">${countdown}</span> giây</small>`;
        document.querySelector('.error-body').appendChild(countdownElement);

        const countdownInterval = setInterval(() => {
            countdown--;
            document.getElementById('countdown').textContent = countdown;
            if (countdown <= 0) clearInterval(countdownInterval);
        }, 1000);
    </script>
</body>
</html>
