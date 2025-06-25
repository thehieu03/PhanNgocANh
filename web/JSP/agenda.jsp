<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.Request" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch nghỉ phép phòng ban</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">Lịch nghỉ phép phòng ban</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${empty error}">
        <table class="table table-bordered table-hover">
            <thead class="table-light">
            <tr>
                <th>STT</th>
                <th>Tên nhân viên</th>
                <th>Tiêu đề</th>
                <th>Ngày bắt đầu</th>
                <th>Ngày kết thúc</th>
                <th>Lý do</th>
                <th>Trạng thái</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="req" items="${requests}" varStatus="loop">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td>${req.user != null ? req.user.fullName : 'N/A'}</td>
                    <td>${req.title}</td>
                    <td>${req.startDate}</td>
                    <td>${req.endDate}</td>
                    <td>${req.reason}</td>
                    <td>
                        <c:choose>
                            <c:when test="${req.statusId == 1}">Chờ duyệt</c:when>
                            <c:when test="${req.statusId == 2}">Đã duyệt</c:when>
                            <c:when test="${req.statusId == 3}">Từ chối</c:when>
                            <c:otherwise>Không xác định</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <a href="${pageContext.request.contextPath}/manager/home" class="btn btn-secondary mt-3">Quay lại trang quản lý</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 