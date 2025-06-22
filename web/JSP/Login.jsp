<%-- 
    Document   : Login
    Created on : Jun 22, 2025, 5:35:20 PM
    Author     : hieun
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập - Hệ thống Quản lý Nghỉ phép</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
            
            .login-container {
                background: white;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }
            
            .login-header {
                text-align: center;
                margin-bottom: 2rem;
            }
            
            .login-header h1 {
                color: #333;
                font-size: 1.8rem;
                margin-bottom: 0.5rem;
            }
            
            .login-header p {
                color: #666;
                font-size: 0.9rem;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                color: #333;
                font-weight: 500;
            }
            
            .form-group input {
                width: 100%;
                padding: 0.75rem;
                border: 2px solid #e1e5e9;
                border-radius: 5px;
                font-size: 1rem;
                transition: border-color 0.3s ease;
            }
            
            .form-group input:focus {
                outline: none;
                border-color: #667eea;
            }
            
            .btn-login {
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
            
            .btn-login:hover {
                transform: translateY(-2px);
            }
            
            .error-message {
                background: #fee;
                color: #c33;
                padding: 0.75rem;
                border-radius: 5px;
                margin-bottom: 1rem;
                border-left: 4px solid #c33;
            }
            
            .success-message {
                background: #efe;
                color: #363;
                padding: 0.75rem;
                border-radius: 5px;
                margin-bottom: 1rem;
                border-left: 4px solid #363;
            }
            
            .form-footer {
                text-align: center;
                margin-top: 1.5rem;
                color: #666;
                font-size: 0.9rem;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-header">
                <h1>Đăng nhập</h1>
                <p>Hệ thống Quản lý Nghỉ phép</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="success-message">
                    ${success}
                </div>
            </c:if>
            
            <form action="login" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" value="${username}" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn-login">Đăng nhập</button>
            </form>
            
            <div class="form-footer">
                <p>© 2024 Hệ thống Quản lý Nghỉ phép</p>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function validateForm() {
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value.trim();
                
                if (username === '') {
                    alert('Vui lòng nhập tên đăng nhập!');
                    return false;
                }
                
                if (password === '') {
                    alert('Vui lòng nhập mật khẩu!');
                    return false;
                }
                
                return true;
            }
            
            // Auto focus on username field
            document.getElementById('username').focus();
        </script>
    </body>
</html>
