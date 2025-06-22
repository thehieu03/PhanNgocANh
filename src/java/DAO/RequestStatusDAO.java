/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.RequestStatus;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for RequestStatus entity
 */
public class RequestStatusDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(RequestStatusDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Request_Status ORDER BY status_id";
    private static final String SQL_FIND_BY_ID = "SELECT * FROM Request_Status WHERE status_id = ?";
    private static final String SQL_FIND_BY_NAME = "SELECT * FROM Request_Status WHERE name = ?";
    private static final String SQL_CREATE = "INSERT INTO Request_Status (name, description) VALUES (?, ?)";
    private static final String SQL_UPDATE = "UPDATE Request_Status SET name = ?, description = ? WHERE status_id = ?";
    private static final String SQL_DELETE = "DELETE FROM Request_Status WHERE status_id = ?";
    
    public RequestStatusDAO() {
        super();
    }
    
    /**
     * Find all request statuses
     */
    public List<RequestStatus> findAll() {
        List<RequestStatus> statuses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                statuses.add(mapResultSetToRequestStatus(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách request statuses", e);
        }
        return statuses;
    }
    
    /**
     * Find request status by ID
     */
    public RequestStatus findById(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRequestStatus(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm request status với ID: " + id, e);
        }
        return null;
    }
    
    /**
     * Find request status by name
     */
    public RequestStatus findByName(String name) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_NAME)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRequestStatus(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm request status với name: " + name, e);
        }
        return null;
    }
    
    /**
     * Create new request status
     */
    public boolean create(RequestStatus status) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setString(1, status.getName());
            ps.setString(2, status.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo request status: " + status.getName(), e);
            return false;
        }
    }
    
    /**
     * Update request status
     */
    public boolean update(RequestStatus status) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, status.getName());
            ps.setString(2, status.getDescription());
            ps.setInt(3, status.getStatusId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật request status với ID: " + status.getStatusId(), e);
            return false;
        }
    }
    
    /**
     * Delete request status by ID
     */
    public boolean delete(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa request status với ID: " + id, e);
            return false;
        }
    }
    
    /**
     * Map ResultSet to RequestStatus object
     */
    private RequestStatus mapResultSetToRequestStatus(ResultSet rs) throws SQLException {
        RequestStatus status = new RequestStatus();
        status.setStatusId(rs.getInt("status_id"));
        status.setName(rs.getString("name"));
        status.setDescription(rs.getString("description"));
        return status;
    }
}
