/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.RequestStatusHistory;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for RequestStatusHistory entity
 */
public class RequestStatusHistoryDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(RequestStatusHistoryDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Request_Status_History ORDER BY changed_at DESC";
    private static final String SQL_FIND_BY_ID = "SELECT * FROM Request_Status_History WHERE history_id = ?";
    private static final String SQL_FIND_BY_REQUEST_ID = "SELECT * FROM Request_Status_History WHERE request_id = ? ORDER BY changed_at DESC";
    private static final String SQL_FIND_BY_CHANGED_BY = "SELECT * FROM Request_Status_History WHERE changed_by = ? ORDER BY changed_at DESC";
    private static final String SQL_CREATE = "INSERT INTO Request_Status_History (request_id, from_status_id, to_status_id, changed_by, changed_at, comment) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE Request_Status_History SET request_id = ?, from_status_id = ?, to_status_id = ?, changed_by = ?, changed_at = ?, comment = ? WHERE history_id = ?";
    private static final String SQL_DELETE = "DELETE FROM Request_Status_History WHERE history_id = ?";
    
    public RequestStatusHistoryDAO() {
        super();
    }
    
    /**
     * Find all request status histories
     */
    public List<RequestStatusHistory> findAll() {
        List<RequestStatusHistory> histories = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                histories.add(mapResultSetToRequestStatusHistory(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách request status histories", e);
        }
        return histories;
    }
    
    /**
     * Find request status history by ID
     */
    public RequestStatusHistory findById(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRequestStatusHistory(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm request status history với ID: " + id, e);
        }
        return null;
    }
    
    /**
     * Find request status histories by request ID
     */
    public List<RequestStatusHistory> findByRequestId(int requestId) {
        List<RequestStatusHistory> histories = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_REQUEST_ID)) {
            ps.setInt(1, requestId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    histories.add(mapResultSetToRequestStatusHistory(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm request status histories với request ID: " + requestId, e);
        }
        return histories;
    }
    
    /**
     * Find request status histories by changed by user ID
     */
    public List<RequestStatusHistory> findByChangedBy(int changedBy) {
        List<RequestStatusHistory> histories = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_CHANGED_BY)) {
            ps.setInt(1, changedBy);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    histories.add(mapResultSetToRequestStatusHistory(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm request status histories với changed by: " + changedBy, e);
        }
        return histories;
    }
    
    /**
     * Create new request status history
     */
    public boolean create(RequestStatusHistory history) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setInt(1, history.getRequestId());
            ps.setInt(2, history.getFromStatusId());
            ps.setInt(3, history.getToStatusId());
            ps.setInt(4, history.getChangedBy());
            ps.setTimestamp(5, java.sql.Timestamp.valueOf(history.getChangedAt()));
            ps.setString(6, history.getComment());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo request status history cho request ID: " + history.getRequestId(), e);
            return false;
        }
    }
    
    /**
     * Update request status history
     */
    public boolean update(RequestStatusHistory history) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
            ps.setInt(1, history.getRequestId());
            ps.setInt(2, history.getFromStatusId());
            ps.setInt(3, history.getToStatusId());
            ps.setInt(4, history.getChangedBy());
            ps.setTimestamp(5, java.sql.Timestamp.valueOf(history.getChangedAt()));
            ps.setString(6, history.getComment());
            ps.setInt(7, history.getHistoryId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật request status history với ID: " + history.getHistoryId(), e);
            return false;
        }
    }
    
    /**
     * Delete request status history by ID
     */
    public boolean delete(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa request status history với ID: " + id, e);
            return false;
        }
    }
    
    /**
     * Map ResultSet to RequestStatusHistory object
     */
    private RequestStatusHistory mapResultSetToRequestStatusHistory(ResultSet rs) throws SQLException {
        RequestStatusHistory history = new RequestStatusHistory();
        history.setHistoryId(rs.getInt("history_id"));
        history.setRequestId(rs.getInt("request_id"));
        history.setFromStatusId(rs.getInt("from_status_id"));
        history.setToStatusId(rs.getInt("to_status_id"));
        history.setChangedBy(rs.getInt("changed_by"));
        history.setChangedAt(rs.getTimestamp("changed_at").toLocalDateTime());
        history.setComment(rs.getString("comment"));
        return history;
    }
}
