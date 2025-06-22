/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.RoleFeature;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for RoleFeature entity
 */
public class RoleFeatureDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(RoleFeatureDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Role_Features ORDER BY role_id, feature_id";
    private static final String SQL_FIND_BY_ROLE_ID = "SELECT * FROM Role_Features WHERE role_id = ?";
    private static final String SQL_FIND_BY_FEATURE_ID = "SELECT * FROM Role_Features WHERE feature_id = ?";
    private static final String SQL_FIND_BY_ROLE_AND_FEATURE = "SELECT * FROM Role_Features WHERE role_id = ? AND feature_id = ?";
    private static final String SQL_CREATE = "INSERT INTO Role_Features (role_id, feature_id) VALUES (?, ?)";
    private static final String SQL_DELETE_BY_ROLE_AND_FEATURE = "DELETE FROM Role_Features WHERE role_id = ? AND feature_id = ?";
    private static final String SQL_DELETE_BY_ROLE_ID = "DELETE FROM Role_Features WHERE role_id = ?";
    private static final String SQL_DELETE_BY_FEATURE_ID = "DELETE FROM Role_Features WHERE feature_id = ?";
    
    public RoleFeatureDAO() {
        super();
    }
    
    /**
     * Find all role features
     */
    public List<RoleFeature> findAll() {
        List<RoleFeature> roleFeatures = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                roleFeatures.add(mapResultSetToRoleFeature(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách role features", e);
        }
        return roleFeatures;
    }
    
    /**
     * Find role features by role ID
 */
    public List<RoleFeature> findByRoleId(int roleId) {
        List<RoleFeature> roleFeatures = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ROLE_ID)) {
            ps.setInt(1, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    roleFeatures.add(mapResultSetToRoleFeature(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm role features với role ID: " + roleId, e);
        }
        return roleFeatures;
    }
    
    /**
     * Find role features by feature ID
     */
    public List<RoleFeature> findByFeatureId(int featureId) {
        List<RoleFeature> roleFeatures = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_FEATURE_ID)) {
            ps.setInt(1, featureId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    roleFeatures.add(mapResultSetToRoleFeature(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm role features với feature ID: " + featureId, e);
        }
        return roleFeatures;
    }
    
    /**
     * Find role feature by role ID and feature ID
     */
    public RoleFeature findByRoleAndFeature(int roleId, int featureId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ROLE_AND_FEATURE)) {
            ps.setInt(1, roleId);
            ps.setInt(2, featureId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRoleFeature(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm role feature với role ID: " + roleId + " và feature ID: " + featureId, e);
        }
        return null;
    }
    
    /**
     * Create new role feature
     */
    public boolean create(RoleFeature roleFeature) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setInt(1, roleFeature.getRoleId());
            ps.setInt(2, roleFeature.getFeatureId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo role feature với role ID: " + roleFeature.getRoleId() + " và feature ID: " + roleFeature.getFeatureId(), e);
            return false;
        }
    }
    
    /**
     * Delete role feature by role ID and feature ID
     */
    public boolean deleteByRoleAndFeature(int roleId, int featureId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE_BY_ROLE_AND_FEATURE)) {
            ps.setInt(1, roleId);
            ps.setInt(2, featureId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa role feature với role ID: " + roleId + " và feature ID: " + featureId, e);
            return false;
        }
    }
    
    /**
     * Delete all role features by role ID
     */
    public boolean deleteByRoleId(int roleId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE_BY_ROLE_ID)) {
            ps.setInt(1, roleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa role features với role ID: " + roleId, e);
            return false;
        }
    }
    
    /**
     * Delete all role features by feature ID
     */
    public boolean deleteByFeatureId(int featureId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE_BY_FEATURE_ID)) {
            ps.setInt(1, featureId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa role features với feature ID: " + featureId, e);
            return false;
        }
    }
    
    /**
     * Check if role has specific feature
     */
    public boolean hasRoleFeature(int roleId, int featureId) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ROLE_AND_FEATURE)) {
            ps.setInt(1, roleId);
            ps.setInt(2, featureId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra role feature với role ID: " + roleId + " và feature ID: " + featureId, e);
        }
        return false;
    }
    
    /**
     * Map ResultSet to RoleFeature object
     */
    private RoleFeature mapResultSetToRoleFeature(ResultSet rs) throws SQLException {
        RoleFeature roleFeature = new RoleFeature();
        roleFeature.setRoleId(rs.getInt("role_id"));
        roleFeature.setFeatureId(rs.getInt("feature_id"));
        return roleFeature;
    }
}
