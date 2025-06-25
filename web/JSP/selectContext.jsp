<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Ngữ cảnh - Hệ thống Quản lý Nghỉ phép</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .context-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        
        .context-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .context-header h1 {
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }
        
        .context-header p {
            color: #666;
            font-size: 0.9rem;
        }
        
        .welcome-message {
            background: #e8f4fd;
            color: #0c5460;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1.5rem;
            border-left: 4px solid #17a2b8;
        }
        
        .context-options {
            margin-bottom: 2rem;
        }
        
        .context-option {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .context-option:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }
        
        .context-option input[type="radio"] {
            margin-right: 1rem;
            transform: scale(1.2);
        }
        
        .context-option label {
            flex: 1;
            cursor: pointer;
            font-weight: 500;
            color: #333;
        }
        
        .context-option .role-badge {
            background: #667eea;
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: 1rem;
        }
        
        .btn-continue {
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .btn-continue:hover {
            transform: translateY(-2px);
        }
        
        .btn-continue:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }
        
        .error-message {
            background: #fee;
            color: #c33;
            padding: 0.75rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            border-left: 4px solid #c33;
        }
        
        .logout-link {
            text-align: center;
            margin-top: 1rem;
        }
        
        .logout-link a {
            color: #667eea;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .logout-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="context-container">
        <div class="context-header">
            <h1>Chọn Ngữ cảnh</h1>
            <p>Bạn có thể hoạt động với nhiều vai trò khác nhau</p>
        </div>
        
        <div class="welcome-message">
            <strong>Xin chào, ${sessionScope.fullName}!</strong><br>
            Vui lòng chọn ngữ cảnh bạn muốn sử dụng:
        </div>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <form action="selectContext" method="post" onsubmit="return validateSelection()">
            <div class="context-options">
                <c:forEach var="context" items="${sessionScope.roleContexts}">
                    <div class="context-option">
                        <input type="radio" id="context_${context.roleName}_${context.departmentId}" 
                               name="selectedContext" value="${context.roleName}:${context.departmentId}">
                        <label for="context_${context.roleName}_${context.departmentId}">
                            <c:choose>
                                <c:when test="${context.roleName == 'Employee'}">
                                    Là Nhân viên tại ${context.departmentName}
                                </c:when>
                                <c:when test="${context.roleName == 'Manager'}">
                                    Là Quản lý tại ${context.departmentName}
                                </c:when>
                                <c:otherwise>
                                    Là ${context.roleName} tại ${context.departmentName}
                                </c:otherwise>
                            </c:choose>
                        </label>
                        <span class="role-badge">${context.roleName}</span>
                    </div>
                </c:forEach>
            </div>
            
            <button type="submit" class="btn-continue" id="continueBtn" disabled>
                Tiếp tục
            </button>
        </form>
        
        <div class="logout-link">
            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </div>
    </div>
    
    <script>
        const radioButtons = document.querySelectorAll('input[name="selectedContext"]');
        const continueBtn = document.getElementById('continueBtn');
        
        radioButtons.forEach(radio => {
            radio.addEventListener('change', function() {
                continueBtn.disabled = !this.checked;
            });
        });
        
        // Add click event to context options
        const contextOptions = document.querySelectorAll('.context-option');
        contextOptions.forEach(option => {
            option.addEventListener('click', function() {
                const radio = this.querySelector('input[type="radio"]');
                radio.checked = true;
                continueBtn.disabled = false;
            });
        });
        
        function validateSelection() {
            const selectedContext = document.querySelector('input[name="selectedContext"]:checked');
            if (!selectedContext) {
                alert('Vui lòng chọn một ngữ cảnh!');
                return false;
            }
            return true;
        }
    </script>
</body>
</html> 