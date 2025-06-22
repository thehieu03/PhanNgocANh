/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.UserRole;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for UserRole entity
 */
public class UserRoleDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(UserRoleDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM User_Roles ORDER BY user_id, role_id";
    private static final String SQL_FIND_BY_USER_ID = "SELECT * FROM User_Roles WHERE user_id = ?";
    private static final String SQL_FIND_BY_ROLE_ID = "SELECT * FROM User_Roles WHERE role_id = ?";
    private static final String SQL_FIND_BY_USER_AND_ROLE = "SELECT * FROM User_Roles WHERE user_id = ? AND role_id = ?";
    private static final String SQL_CREATE = "INSERT INTO User_Roles (user_id, role_id) VALUES (?, ?)";
    private static final String SQL_DELETE_BY_USER_AND_ROLE = "DELETE FROM User_Roles WHERE user_id = ? AND role_id = ?";
    private static final String SQL_DELETE_BY_USER_ID = "DELETE FROM User_Roles WHERE user_id = ?";
    private static final String SQL_DELETE_BY_ROLE_ID = "DELETE FROM User_Roles WHERE role_id = ?";
    
    public UserRoleDAO() {
        super();
    }
    
    /**
     * Find all user roles
     */
    public List<UserRole> findAll() {
        List<UserRole> userRoles = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                userRoles.add(mapResultSetToUserRole(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách user roles", e);
        }
        return userRoles;
    }
    
    /**
     * Find user roles by user ID
     */
    public List<UserRole> findByUserId(int userId) {
        List<UserRole> userRoles = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_USER_ID)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userRoles.add(mapResultSetToUserRole(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm user roles với user ID: " + userId, e);
        }
        return userRoles;
    }
    
    /**
     * Find user roles by role ID
     */
    public List<UserRole> findByRoleId(int roleId) {
        List<UserRole> userRoles = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ROLE_ID)) {
            ps.setInt(1, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userRoles.add(mapResultSetToUserRole(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm user roles với role ID: " + roleId, e);
        }
        return userRoles;
    }
    
    /**
     * Find user role by user ID and role ID
     */
    public UserRole findByUserAndRole(int userId, int roleId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_USER_AND_ROLE)) {
            ps.setInt(1, userId);
            ps.setInt(2, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUserRole(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm user role với user ID: " + userId + " và role ID: " + roleId, e);
        }
        return null;
    }
    
    /**
     * Create new user role
     */
    public boolean create(UserRole userRole) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setInt(1, userRole.getUserId());
            ps.setInt(2, userRole.getRoleId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo user role với user ID: " + userRole.getUserId() + " và role ID: " + userRole.getRoleId(), e);
            return false;
        }
    }
    
    /**
     * Delete user role by user ID and role ID
     */
    public boolean deleteByUserAndRole(int userId, int roleId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE_BY_USER_AND_ROLE)) {
            ps.setInt(1, userId);
            ps.setInt(2, roleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa user role với user ID: " + userId + " và role ID: " + roleId, e);
            return false;
        }
    }
    
    /**
     * Delete all user roles by user ID
     */
    public boolean deleteByUserId(int userId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE_BY_USER_ID)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa user roles với user ID: " + userId, e);
            return false;
        }
    }
    
    /**
     * Delete all user roles by role ID
     */
    public boolean deleteByRoleId(int roleId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE_BY_ROLE_ID)) {
            ps.setInt(1, roleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa user roles với role ID: " + roleId, e);
            return false;
        }
    }
    
    /**
     * Check if user has specific role
     */
    public boolean hasUserRole(int userId, int roleId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_USER_AND_ROLE)) {
            ps.setInt(1, userId);
            ps.setInt(2, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra user role với user ID: " + userId + " và role ID: " + roleId, e);
        }
        return false;
    }
    
    /**
     * Map ResultSet to UserRole object
     */
    private UserRole mapResultSetToUserRole(ResultSet rs) throws SQLException {
        UserRole userRole = new UserRole();
        userRole.setUserId(rs.getInt("user_id"));
        userRole.setRoleId(rs.getInt("role_id"));
        return userRole;
    }
}
