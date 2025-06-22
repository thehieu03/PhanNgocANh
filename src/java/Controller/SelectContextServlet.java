package Controller;

import Models.RoleContext;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to handle context selection when user has multiple roles
 */
public class SelectContextServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to selectContext.jsp
        request.getRequestDispatcher("/JSP/selectContext.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get selected context
        String selectedContext = request.getParameter("selectedContext");
        
        if (selectedContext != null && !selectedContext.trim().isEmpty()) {
            // Parse the selected context (format: "roleName:departmentId")
            String[] parts = selectedContext.split(":");
            if (parts.length == 2) {
                String roleName = parts[0];
                int departmentId = Integer.parseInt(parts[1]);
                
                // Store in session
                session.setAttribute("selectedRole", roleName);
                session.setAttribute("selectedDept", departmentId);
                
                // Redirect based on role
                if ("Employee".equals(roleName)) {
                    response.sendRedirect("employee/home");
                } else if ("Manager".equals(roleName)) {
                    response.sendRedirect("manager/home");
                } else {
                    response.sendRedirect("admin/home");
                }
                return;
            }
        }
        
        // Invalid selection, redirect back to context selection
        request.setAttribute("error", "Vui lòng chọn một ngữ cảnh!");
        request.getRequestDispatcher("/JSP/selectContext.jsp").forward(request, response);
    }
} 