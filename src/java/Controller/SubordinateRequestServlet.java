package Controller;

import DAO.RequestDAO;
import DAO.UserDAO;
import Models.Request;
import Models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý xem và duyệt đơn nghỉ phép của cấp dưới
 */
public class SubordinateRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đảm bảo session còn tồn tại và user đã đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // Xác định action (list, view, approve, reject, detail)
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewRequest(request, response);
                break;
            case "approve":
                approveRequest(request, response);
                break;
            case "reject":
                rejectRequest(request, response);
                break;
            case "detail":
                detailRequestJson(request, response);
                break;
            case "list":
            default:
                listSubordinateRequests(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // POST xử lý approve/reject hoặc fallback về list
        String action = request.getParameter("action");
        if ("approve".equals(action)) {
            approveRequest(request, response);
        } else if ("reject".equals(action)) {
            rejectRequest(request, response);
        } else {
            // POST không xác định => show list
            listSubordinateRequests(request, response);
        }
    }

    /**
     * Hiển thị danh sách đơn của các cấp dưới
     */
    private void listSubordinateRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User manager = (User) request.getSession(false).getAttribute("user");
            int managerId = manager.getUserId();

            RequestDAO requestDAO = new RequestDAO();
            List<Request> requests = requestDAO.findByManager(managerId);

            // Lấy thông tin user cho từng đơn
            UserDAO userDAO = new UserDAO();
            for (Request req : requests) {
                User reqUser = userDAO.findById(req.getUserId());
                req.setUser(reqUser);
            }

            request.setAttribute("requests", requests);
            request.getRequestDispatcher("/JSP/subordinateRequests.jsp").forward(request, response);
        } catch (Exception e) {
            // In chi tiết lỗi ra console để debug
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn: " + e.getMessage());
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị chi tiết một đơn
     */
    private void viewRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/subordinate-requests");
                return;
            }

            int requestId = Integer.parseInt(idStr);
            RequestDAO requestDAO = new RequestDAO();
            Request req = requestDAO.findById(requestId);

            if (req == null) {
                request.setAttribute("error", "Không tìm thấy đơn!");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }

            User manager = (User) request.getSession(false).getAttribute("user");
            User requester = new UserDAO().findById(req.getUserId());
            if (requester.getManagerId() == null || requester.getManagerId() != manager.getUserId()) {
                request.setAttribute("error", "Bạn không có quyền xem đơn này!");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("request", req);
            request.setAttribute("requester", requester);
            request.getRequestDispatcher("/JSP/requestDetail.jsp").forward(request, response);
        } catch (NumberFormatException nfe) {
            request.setAttribute("error", "ID đơn không hợp lệ!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin đơn: " + e.getMessage());
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    /**
     * Duyệt đơn
     */
    private void approveRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/subordinate-requests");
                return;
            }
            int requestId = Integer.parseInt(idStr);
            String comment = request.getParameter("comment");

            User manager = (User) request.getSession(false).getAttribute("user");
            boolean success = new RequestDAO().approve(requestId, manager.getUserId(), comment);

            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("message", "Đã duyệt đơn thành công!");
            } else {
                session.setAttribute("error", "Không thể duyệt đơn!");
            }
            response.sendRedirect(request.getContextPath() + "/subordinate-requests");
        } catch (NumberFormatException nfe) {
            request.setAttribute("error", "ID đơn không hợp lệ!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi duyệt đơn: " + e.getMessage());
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    /**
     * Từ chối đơn
     */
    private void rejectRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/subordinate-requests");
                return;
            }
            int requestId = Integer.parseInt(idStr);
            String comment = request.getParameter("comment");

            User manager = (User) request.getSession(false).getAttribute("user");
            boolean success = new RequestDAO().reject(requestId, manager.getUserId(), comment);

            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("message", "Đã từ chối đơn thành công!");
            } else {
                session.setAttribute("error", "Không thể từ chối đơn!");
            }
            response.sendRedirect(request.getContextPath() + "/subordinate-requests");
        } catch (NumberFormatException nfe) {
            request.setAttribute("error", "ID đơn không hợp lệ!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi từ chối đơn: " + e.getMessage());
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    /**
     * Trả về JSON chi tiết đơn nghỉ phép cho frontend
     */
    private void detailRequestJson(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isBlank()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Thiếu id đơn\"}");
                return;
            }
            int requestId = Integer.parseInt(idStr);
            RequestDAO requestDAO = new RequestDAO();
            Request req = requestDAO.findById(requestId);
            if (req == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Không tìm thấy đơn\"}");
                return;
            }
            User manager = (User) request.getSession(false).getAttribute("user");
            UserDAO userDAO = new UserDAO();
            User requester = userDAO.findById(req.getUserId());
            if (requester.getManagerId() == null || requester.getManagerId() != manager.getUserId()) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"error\":\"Không có quyền xem đơn này\"}");
                return;
            }
            // Lấy tên trạng thái
            DAO.RequestStatusDAO statusDAO = new DAO.RequestStatusDAO();
            Models.RequestStatus status = statusDAO.findById(req.getStatusId());
            String statusName = status != null ? status.getName() : "";
            // Format ngày
            String startDate = req.getStartDate() != null ? String.format("%d/%d/%d", req.getStartDate().getDayOfMonth(), req.getStartDate().getMonthValue(), req.getStartDate().getYear()) : "N/A";
            String endDate = req.getEndDate() != null ? String.format("%d/%d/%d", req.getEndDate().getDayOfMonth(), req.getEndDate().getMonthValue(), req.getEndDate().getYear()) : "N/A";
            String createdAt = req.getCreatedAt() != null ? String.format("%d/%d/%d %02d:%02d", req.getCreatedAt().getDayOfMonth(), req.getCreatedAt().getMonthValue(), req.getCreatedAt().getYear(), req.getCreatedAt().getHour(), req.getCreatedAt().getMinute()) : "N/A";
            // Trả JSON
            String json = String.format("{\"title\":\"%s\",\"userFullName\":\"%s\",\"startDate\":\"%s\",\"endDate\":\"%s\",\"reason\":\"%s\",\"createdAt\":\"%s\",\"statusName\":\"%s\"}",
                escapeJson(req.getTitle()),
                escapeJson(requester.getFullName()),
                startDate,
                endDate,
                escapeJson(req.getReason()),
                createdAt,
                escapeJson(statusName)
            );
            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Lỗi server\"}");
        }
    }

    // Hàm escape ký tự đặc biệt cho JSON
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }
}
