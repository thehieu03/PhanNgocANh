package Controller;

import DAO.RequestDAO;
import Models.Request;
import Models.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class EmployeeRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy user từ session
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = user.getUserId();
        request.setAttribute("userId", userId); 

        try {
            RequestDAO requestDAO = new RequestDAO();
            // Nếu muốn lấy đơn chờ duyệt của cấp dưới (manager):
            // List<Request> requests = requestDAO.findPendingByManager(userId);
            // Nếu chỉ lấy đơn của chính user (employee):
            List<Request> requests = requestDAO.findByUser(userId);
            request.setAttribute("requests", requests);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể lấy danh sách đơn nghỉ phép: " + e.getMessage());
        }

        request.getRequestDispatcher("/JSP/employeeRequests.jsp").forward(request, response);
    }
} 