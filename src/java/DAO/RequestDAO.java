/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Request;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;

/**
 * DAO class for Request entity
 */
public class RequestDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(RequestDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Requests ORDER BY created_at DESC";
    private static final String SQL_FIND_BY_ID = "SELECT * FROM Requests WHERE request_id = ?";
    private static final String SQL_FIND_BY_USER = "SELECT * FROM Requests WHERE user_id = ? ORDER BY created_at DESC";
    private static final String SQL_FIND_BY_MANAGER = "SELECT r.* FROM Requests r INNER JOIN Users u ON r.user_id = u.user_id WHERE u.manager_id = ? ORDER BY r.created_at DESC";
    private static final String SQL_FIND_BY_STATUS = "SELECT * FROM Requests WHERE status_id = ? ORDER BY created_at DESC";
    private static final String SQL_FIND_BY_DATE_RANGE = "SELECT * FROM Requests WHERE start_date BETWEEN ? AND ? ORDER BY created_at DESC";
    private static final String SQL_CREATE = "INSERT INTO Requests (user_id, title, start_date, end_date, reason, status_id, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE Requests SET user_id = ?, title = ?, start_date = ?, end_date = ?, reason = ?, status_id = ?, updated_at = ? WHERE request_id = ?";
    private static final String SQL_DELETE = "DELETE FROM Requests WHERE request_id = ?";
    private static final String SQL_APPROVE = "UPDATE Requests SET status_id = 2, updated_at = ? WHERE request_id = ?"; // Assuming status_id 2 is "Approved"
    private static final String SQL_REJECT = "UPDATE Requests SET status_id = 3, updated_at = ? WHERE request_id = ?"; // Assuming status_id 3 is "Rejected"
    
    public RequestDAO() {
        super();
    }
    
    /**
     * Find all requests
     */
    public List<Request> findAll() {
        List<Request> requests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                requests.add(mapResultSetToRequest(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách requests", e);
        }
        return requests;
    }
    
    /**
     * Find request by ID
     */
    public Request findById(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRequest(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm request với ID: " + id, e);
        }
        return null;
    }
    
    /**
     * Find requests by user ID
     */
    public List<Request> findByUser(int userId) {
        List<Request> requests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_USER)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToRequest(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm requests với user ID: " + userId, e);
        }
        return requests;
    }
    
    /**
     * Find requests by manager ID (requests from subordinates)
     */
    public List<Request> findByManager(int managerId) {
        List<Request> requests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_MANAGER)) {
            ps.setInt(1, managerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToRequest(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm requests với manager ID: " + managerId, e);
        }
        return requests;
    }
    
    /**
     * Find requests by status ID
     */
    public List<Request> findByStatus(int statusId) {
        List<Request> requests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_STATUS)) {
            ps.setInt(1, statusId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToRequest(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm requests với status ID: " + statusId, e);
        }
        return requests;
    }
    
    /**
     * Find requests by date range
     */
    public List<Request> findByDateRange(LocalDate startDate, LocalDate endDate) {
        List<Request> requests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_DATE_RANGE)) {
            ps.setDate(1, java.sql.Date.valueOf(startDate));
            ps.setDate(2, java.sql.Date.valueOf(endDate));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToRequest(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm requests với date range từ " + startDate + " đến " + endDate, e);
        }
        return requests;
    }
    
    /**
     * Create new request
     */
    public boolean create(Request request) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setInt(1, request.getUserId());
            ps.setString(2, request.getTitle());
            ps.setDate(3, java.sql.Date.valueOf(request.getStartDate()));
            ps.setDate(4, java.sql.Date.valueOf(request.getEndDate()));
            ps.setString(5, request.getReason());
            ps.setInt(6, request.getStatusId());
            ps.setTimestamp(7, java.sql.Timestamp.valueOf(request.getCreatedAt()));
            ps.setTimestamp(8, java.sql.Timestamp.valueOf(request.getUpdatedAt()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo request cho user ID: " + request.getUserId(), e);
            return false;
        }
    }
    
    /**
     * Update request
     */
    public boolean update(Request request) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
            ps.setInt(1, request.getUserId());
            ps.setString(2, request.getTitle());
            ps.setDate(3, java.sql.Date.valueOf(request.getStartDate()));
            ps.setDate(4, java.sql.Date.valueOf(request.getEndDate()));
            ps.setString(5, request.getReason());
            ps.setInt(6, request.getStatusId());
            ps.setTimestamp(7, java.sql.Timestamp.valueOf(request.getUpdatedAt()));
            ps.setInt(8, request.getRequestId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật request với ID: " + request.getRequestId(), e);
            return false;
        }
    }
    
    /**
     * Delete request by ID
     */
    public boolean delete(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa request với ID: " + id, e);
            return false;
        }
    }
    
    /**
     * Approve request
     */
    public boolean approve(int requestId, int approverId, String comment) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_APPROVE)) {
            ps.setTimestamp(1, java.sql.Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, requestId);
            boolean success = ps.executeUpdate() > 0;
            
            if (success) {
                // Log the approval action
                LOGGER.info("Request " + requestId + " approved by user " + approverId + " with comment: " + comment);
            }
            
            return success;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi approve request với ID: " + requestId, e);
            return false;
        }
    }
    
    /**
     * Reject request
     */
    public boolean reject(int requestId, int approverId, String comment) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_REJECT)) {
            ps.setTimestamp(1, java.sql.Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, requestId);
            boolean success = ps.executeUpdate() > 0;
            
            if (success) {
                // Log the rejection action
                LOGGER.info("Request " + requestId + " rejected by user " + approverId + " with comment: " + comment);
            }
            
            return success;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi reject request với ID: " + requestId, e);
            return false;
        }
    }
    
    /**
     * Get pending requests (status_id = 1)
     */
    public List<Request> getPendingRequests() {
        List<Request> requests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement("SELECT * FROM Requests WHERE status_id = 1 ORDER BY created_at DESC")) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToRequest(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy pending requests", e);
        }
        return requests;
    }
    
    /**
     * Get requests statistics for a user
     */
    public int getRequestCountByStatus(int userId, int statusId) {
        try (PreparedStatement ps = connection.prepareStatement("SELECT COUNT(*) FROM Requests WHERE user_id = ? AND status_id = ?")) {
            ps.setInt(1, userId);
            ps.setInt(2, statusId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đếm requests cho user ID: " + userId + " và status ID: " + statusId, e);
        }
        return 0;
    }
    
    /**
     * Map ResultSet to Request object
     */
    private Request mapResultSetToRequest(ResultSet rs) throws SQLException {
        Request request = new Request();
        request.setRequestId(rs.getInt("request_id"));
        request.setUserId(rs.getInt("user_id"));
        request.setTitle(rs.getString("title"));
        java.sql.Date startDate = rs.getDate("start_date");
        if (startDate != null) request.setStartDate(startDate.toLocalDate());
        java.sql.Date endDate = rs.getDate("end_date");
        if (endDate != null) request.setEndDate(endDate.toLocalDate());
        request.setReason(rs.getString("reason"));
        request.setStatusId(rs.getInt("status_id"));
        java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) request.setCreatedAt(createdAt.toLocalDateTime());
        java.sql.Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) request.setUpdatedAt(updatedAt.toLocalDateTime());
        return request;
    }

    public List<Request> findByDepartment(int deptId) {
        List<Request> list = new ArrayList<>();
        String sql = "SELECT * FROM Request WHERE departmentId = ?";
        DbContext db = new DbContext(){};
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deptId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Request req = new Request();
                    req.setRequestId(rs.getInt("id"));
                    req.setUserId(rs.getInt("userId"));
                    req.setTitle(rs.getString("title"));
                    java.sql.Date startDate = rs.getDate("startDate");
                    if (startDate != null) req.setStartDate(startDate.toLocalDate());
                    java.sql.Date endDate = rs.getDate("endDate");
                    if (endDate != null) req.setEndDate(endDate.toLocalDate());
                    req.setReason(rs.getString("reason"));
                    req.setStatusId(rs.getInt("statusId"));
                    java.sql.Timestamp createdAt = rs.getTimestamp("createdAt");
                    if (createdAt != null) req.setCreatedAt(createdAt.toLocalDateTime());
                    java.sql.Timestamp updatedAt = rs.getTimestamp("updatedAt");
                    if (updatedAt != null) req.setUpdatedAt(updatedAt.toLocalDateTime());
                    list.add(req);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return list;
    }
}
