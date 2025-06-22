package Controller;

import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for Employee Home page
 */
public class EmployeeHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Check if user has selected Employee context
        String selectedRole = (String) session.getAttribute("selectedRole");
        if (!"Employee".equals(selectedRole)) {
            response.sendRedirect("error?message=Không có quyền truy cập trang Employee");
            return;
        }
        
        // Forward to employee home page
        request.getRequestDispatcher("/JSP/employeeHome.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 