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
import java.time.LocalDateTime;
import java.util.List;

public class SubordinateRequestServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                listSubordinateRequests(request, response);
                break;
            case "view":
                viewRequest(request, response);
                break;
            case "approve":
                approveRequest(request, response);
                break;
            case "reject":
                rejectRequest(request, response);
                break;
            default:
                listSubordinateRequests(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("approve".equals(action)) {
            approveRequest(request, response);
        } else if ("reject".equals(action)) {
            rejectRequest(request, response);
        } else {
            listSubordinateRequests(request, response);
        }
    }

    private void listSubordinateRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");
            if (session == null || user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            int managerId = user.getUserId();
            RequestDAO requestDAO = new RequestDAO();
            List<Request> requests = requestDAO.findByManager(managerId);
            UserDAO userDAO = new UserDAO();
            for (Request req : requests) {
                User reqUser = userDAO.findById(req.getUserId());
                req.setUser(reqUser);
            }
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("/JSP/subordinateRequests.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách đơn cấp dưới: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    private void viewRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String requestIdStr = request.getParameter("id");
            if (requestIdStr == null || requestIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/subordinate-requests");
                return;
            }
            int requestId = Integer.parseInt(requestIdStr);
            RequestDAO requestDAO = new RequestDAO();
            Request req = requestDAO.findById(requestId);
            if (req == null) {
                request.setAttribute("error", "Không tìm thấy đơn!");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");
            int managerId = user.getUserId();
            UserDAO userDAO = new UserDAO();
            User requester = userDAO.findById(req.getUserId());
            if (requester.getManagerId() == null || requester.getManagerId() != managerId) {
                request.setAttribute("error", "Bạn không có quyền xem đơn này!");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            request.setAttribute("request", req);
            request.setAttribute("requester", requester);
            request.getRequestDispatcher("/JSP/requestDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn không hợp lệ!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi khi xem chi tiết đơn: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin đơn!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    private void approveRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String requestIdStr = request.getParameter("id");
            String comment = request.getParameter("comment");
            if (requestIdStr == null || requestIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/subordinate-requests");
                return;
            }
            int requestId = Integer.parseInt(requestIdStr);
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");
            int approverId = user.getUserId();
            RequestDAO requestDAO = new RequestDAO();
            boolean success = requestDAO.approve(requestId, approverId, comment);
            if (success) {
                session.setAttribute("message", "Đã duyệt đơn thành công!");
            } else {
                session.setAttribute("error", "Không thể duyệt đơn!");
            }
            response.sendRedirect(request.getContextPath() + "/subordinate-requests");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn không hợp lệ!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi khi duyệt đơn: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra khi duyệt đơn!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    private void rejectRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String requestIdStr = request.getParameter("id");
            String comment = request.getParameter("comment");
            if (requestIdStr == null || requestIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/subordinate-requests");
                return;
            }
            int requestId = Integer.parseInt(requestIdStr);
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");
            int rejecterId = user.getUserId();
            RequestDAO requestDAO = new RequestDAO();
            boolean success = requestDAO.reject(requestId, rejecterId, comment);
            if (success) {
                session.setAttribute("message", "Đã từ chối đơn thành công!");
            } else {
                session.setAttribute("error", "Không thể từ chối đơn!");
            }
            response.sendRedirect(request.getContextPath() + "/subordinate-requests");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn không hợp lệ!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi khi từ chối đơn: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra khi từ chối đơn!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
} 