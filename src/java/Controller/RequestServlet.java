package Controller;

import DAO.RequestDAO;
import DAO.RequestStatusDAO;
import DAO.UserDAO;
import Models.Request;
import Models.RequestStatus;
import Models.User;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to handle request operations (create, list, view)
 */
public class RequestServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(RequestServlet.class.getName());
    private final RequestDAO requestDAO = new RequestDAO();
    private final RequestStatusDAO statusDAO = new RequestStatusDAO();
    private final UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "view":
                viewRequest(request, response);
                break;
            case "list":
            default:
                listRequests(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createRequest(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<RequestStatus> statuses = statusDAO.findAll();
            request.setAttribute("statuses", statuses);
            request.getRequestDispatcher("/JSP/createRequest.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi hiển thị form tạo đơn", e);
            request.setAttribute("error", "Có lỗi xảy ra khi tải form");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
    
    private void createRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String title = request.getParameter("title");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String reason = request.getParameter("reason");
            
            // Validation
            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Tiêu đề không được để trống");
                showCreateForm(request, response);
                return;
            }
            
            if (startDateStr == null || endDateStr == null) {
                request.setAttribute("error", "Ngày bắt đầu và kết thúc không được để trống");
                showCreateForm(request, response);
                return;
            }
            
            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = LocalDate.parse(endDateStr);
            
            if (startDate.isAfter(endDate)) {
                request.setAttribute("error", "Ngày bắt đầu không được sau ngày kết thúc");
                showCreateForm(request, response);
                return;
            }
            
            if (startDate.isBefore(LocalDate.now())) {
                request.setAttribute("error", "Ngày bắt đầu không được trong quá khứ");
                showCreateForm(request, response);
                return;
            }
            
            // Create request
            Request newRequest = new Request();
            newRequest.setUserId(user.getUserId());
            newRequest.setTitle(title.trim());
            newRequest.setStartDate(startDate);
            newRequest.setEndDate(endDate);
            newRequest.setReason(reason != null ? reason.trim() : "");
            newRequest.setStatusId(1); // InProgress
            
            boolean success = requestDAO.create(newRequest);
            
            if (success) {
                session.setAttribute("message", "Tạo đơn nghỉ phép thành công!");
                response.sendRedirect("Request?action=list");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi tạo đơn");
                showCreateForm(request, response);
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo đơn nghỉ phép", e);
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            showCreateForm(request, response);
        }
    }
    
    private void listRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            List<Request> requests;
            String userRole = (String) session.getAttribute("userRole");
            
            // Check if user is manager or admin
            if ("Manager".equals(userRole) || "Admin".equals(userRole)) {
                // Managers can see requests from their subordinates
                requests = requestDAO.findByManager(user.getUserId());
            } else {
                // Regular employees see only their own requests
                requests = requestDAO.findByUser(user.getUserId());
            }
            
            List<RequestStatus> statuses = statusDAO.findAll();
            
            request.setAttribute("requests", requests);
            request.setAttribute("statuses", statuses);
            request.getRequestDispatcher("/JSP/listRequests.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách đơn", e);
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
    
    private void viewRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String requestIdStr = request.getParameter("id");
            if (requestIdStr == null || requestIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing request ID");
                return;
            }
            
            int requestId = Integer.parseInt(requestIdStr);
            Request req = requestDAO.findById(requestId);
            
            if (req == null) {
                request.setAttribute("error", "Không tìm thấy đơn nghỉ phép");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            
            // Check authorization
            String userRole = (String) session.getAttribute("userRole");
            if (!"Manager".equals(userRole) && !"Admin".equals(userRole) && req.getUserId() != user.getUserId()) {
                request.setAttribute("error", "Bạn không có quyền xem đơn này");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            
            // Get user info for the request
            User requestUser = userDAO.findById(req.getUserId());
            RequestStatus status = statusDAO.findById(req.getStatusId());
            
            request.setAttribute("request", req);
            request.setAttribute("requestUser", requestUser);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/JSP/viewRequest.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn không hợp lệ");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xem chi tiết đơn", e);
            request.setAttribute("error", "Có lỗi xảy ra khi tải chi tiết đơn");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
} 