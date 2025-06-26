<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn nghỉ phép của tôi - Hệ thống Quản lý Nghỉ phép</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background: #f5f7fa; min-height: 100vh; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1rem 2rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-content { display: flex; justify-content: space-between; align-items: center; max-width: 1200px; margin: 0 auto; }
        .header h1 { font-size: 1.5rem; font-weight: 600; }
        .user-info { display: flex; align-items: center; gap: 1rem; }
        .user-name { font-weight: 500; }
        .logout-btn { background: rgba(255,255,255,0.2); color: white; border: none; padding: 0.5rem 1rem; border-radius: 5px; text-decoration: none; font-size: 0.9rem; transition: background 0.3s ease; }
        .logout-btn:hover { background: rgba(255,255,255,0.3); color: white; text-decoration: none; }
        .container { max-width: 1100px; margin: 2rem auto; background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); padding: 2rem; }
        .table th, .table td { vertical-align: middle; }
        .status-badge { font-size: 0.95rem; padding: 0.3em 0.8em; border-radius: 12px; }
        .status-inprogress { background: #fff3cd; color: #856404; }
        .status-approved { background: #d4edda; color: #155724; }
        .status-rejected { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>Hệ thống Quản lý Nghỉ phép</h1>
            <div class="user-info">
                <span class="user-name">Xin chào, ${sessionScope.fullName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
            </div>
        </div>
    </div>
    <div class="container">
        <h2 class="mb-4">Đơn nghỉ phép của tôi</h2>
        <c:if test="${not empty requests}">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
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
                            <td>${req.title}</td>
                            <td><fmt:formatDate value="${req.startDate}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${req.endDate}" pattern="dd/MM/yyyy"/></td>
                            <td>${req.reason}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${req.statusId == 1}"><span class="status-badge status-inprogress">Chờ duyệt</span></c:when>
                                    <c:when test="${req.statusId == 2}"><span class="status-badge status-approved">Đã duyệt</span></c:when>
                                    <c:when test="${req.statusId == 3}"><span class="status-badge status-rejected">Từ chối</span></c:when>
                                    <c:otherwise><span class="status-badge">Không xác định</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${not empty req.createdAt}">
                                    <fmt:formatDate value="${req.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </c:if>
                                <c:if test="${empty req.createdAt}">N/A</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty requests}">
            <div class="alert alert-info">Bạn chưa có đơn nghỉ phép nào.</div>
        </c:if>
        <a href="${pageContext.request.contextPath}/employee/home" class="btn btn-secondary mt-3">&larr; Quay lại trang chủ</a>
    </div>
</body>
</html> 