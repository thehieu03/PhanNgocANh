<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đơn nghỉ phép của tôi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
        }
        .container {
            max-width: 900px;
            margin-top: 40px;
        }
        .table thead th {
            background: #667eea;
            color: #fff;
        }
        .badge {
            font-size: 1em;
        }
        .back-btn {
            margin-top: 24px;
        }
    </style>
</head>
<body>
<div class="container bg-white shadow rounded p-4">
    <h2 class="mb-4 text-center">Đơn nghỉ phép của tôi</h2>
    <c:if test="${not empty requests}">
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tiêu đề</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Lý do</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${requests}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td><c:out value="${req.title}" default="N/A"/></td>
                            <td><c:out value="${req.startDate}" default="N/A"/></td>
                            <td><c:out value="${req.endDate}" default="N/A"/></td>
                            <td><c:out value="${req.reason}" default="N/A"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${req.statusId == 1}">
                                        <span class="badge bg-warning text-dark">Chờ duyệt</span>
                                    </c:when>
                                    <c:when test="${req.statusId == 2}">
                                        <span class="badge bg-success">Đã duyệt</span>
                                    </c:when>
                                    <c:when test="${req.statusId == 3}">
                                        <span class="badge bg-danger">Từ chối</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Không xác định</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${req.createdAt}" default="N/A"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${empty requests}">
        <div class="alert alert-info text-center">Bạn chưa có đơn nghỉ phép nào.</div>
    </c:if>
    <div class="text-center back-btn">
        <a href="${pageContext.request.contextPath}/employee/home" class="btn btn-secondary">&larr; Quay lại trang chủ</a>
    </div>
</div>
</body>
</html> 