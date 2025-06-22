package Controller;

import DAO.RequestDAO;
import DAO.RequestStatusHistoryDAO;
import DAO.UserDAO;
import Models.Request;
import Models.RequestStatusHistory;
import Models.User;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to handle request approval and rejection
 */
public class ApprovalServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ApprovalServlet.class.getName());
    private final RequestDAO requestDAO = new RequestDAO();
    private final RequestStatusHistoryDAO historyDAO = new RequestStatusHistoryDAO();
    private final UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("approve".equals(action)) {
            approveRequest(request, response);
        } else if ("reject".equals(action)) {
            rejectRequest(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
    
    private void approveRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }
        
        try {
            String requestIdStr = request.getParameter("requestId");
            String comment = request.getParameter("comment");
            
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
            
            // Check if user has permission to approve this request
            if (!hasApprovalPermission(user, req)) {
                request.setAttribute("error", "Bạn không có quyền phê duyệt đơn này");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            
            // Check if request is in pending status
            if (req.getStatusId() != 1) { // Assuming 1 is "InProgress"
                request.setAttribute("error", "Đơn này không thể phê duyệt (không ở trạng thái chờ)");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            
            // Approve the request
            boolean success = requestDAO.approve(requestId, user.getUserId(), comment);
            
            if (success) {
                // Log the status change
                RequestStatusHistory history = new RequestStatusHistory();
                history.setRequestId(requestId);
                history.setFromStatusId(1); // InProgress
                history.setToStatusId(2); // Approved
                history.setChangedBy(user.getUserId());
                history.setChangedAt(LocalDateTime.now());
                history.setComment(comment != null ? comment.trim() : "Được phê duyệt");
                
                historyDAO.create(history);
                
                session.setAttribute("message", "Phê duyệt đơn nghỉ phép thành công!");
                response.sendRedirect("Request?action=view&id=" + requestId);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi phê duyệt đơn");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn không hợp lệ");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi phê duyệt đơn", e);
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
    
    private void rejectRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }
        
        try {
            String requestIdStr = request.getParameter("requestId");
            String comment = request.getParameter("comment");
            
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
            
            // Check if user has permission to reject this request
            if (!hasApprovalPermission(user, req)) {
                request.setAttribute("error", "Bạn không có quyền từ chối đơn này");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            
            // Check if request is in pending status
            if (req.getStatusId() != 1) { // Assuming 1 is "InProgress"
                request.setAttribute("error", "Đơn này không thể từ chối (không ở trạng thái chờ)");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            
            // Reject the request
            boolean success = requestDAO.reject(requestId, user.getUserId(), comment);
            
            if (success) {
                // Log the status change
                RequestStatusHistory history = new RequestStatusHistory();
                history.setRequestId(requestId);
                history.setFromStatusId(1); // InProgress
                history.setToStatusId(3); // Rejected
                history.setChangedBy(user.getUserId());
                history.setChangedAt(LocalDateTime.now());
                history.setComment(comment != null ? comment.trim() : "Bị từ chối");
                
                historyDAO.create(history);
                
                session.setAttribute("message", "Từ chối đơn nghỉ phép thành công!");
                response.sendRedirect("Request?action=view&id=" + requestId);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi từ chối đơn");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn không hợp lệ");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi từ chối đơn", e);
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
    
    private boolean hasApprovalPermission(User user, Request req) {
        // Admin can approve any request
        if ("Admin".equals(user.getUsername())) {
            return true;
        }
        
        // Manager can approve requests from their subordinates
        if (req.getUserId() != user.getUserId()) {
            User requestUser = userDAO.findById(req.getUserId());
            if (requestUser != null && requestUser.getManagerId() != null && 
                requestUser.getManagerId() == user.getUserId()) {
                return true;
            }
        }
        
        return false;
    }
} 