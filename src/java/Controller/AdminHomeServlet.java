package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for Admin Home page
 */
public class AdminHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Basic authentication check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Authorization check for Admin role
        String selectedRole = (String) session.getAttribute("selectedRole");
        if (!"Admin".equalsIgnoreCase(selectedRole)) {
            // If not admin, redirect to an error page or login
            response.sendRedirect("login?error=Access+Denied");
            return;
        }
        
        // Forward to the admin home page
        request.getRequestDispatcher("/JSP/adminHome.jsp").forward(request, response);
    }
} 