/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Feature;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for Feature entity
 */
public class FeatureDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(FeatureDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Features ORDER BY name";
    private static final String SQL_FIND_BY_ID = "SELECT * FROM Features WHERE feature_id = ?";
    private static final String SQL_FIND_BY_NAME = "SELECT * FROM Features WHERE name = ?";
    private static final String SQL_CREATE = "INSERT INTO Features (name, description) VALUES (?, ?)";
    private static final String SQL_UPDATE = "UPDATE Features SET name = ?, description = ? WHERE feature_id = ?";
    private static final String SQL_DELETE = "DELETE FROM Features WHERE feature_id = ?";
    
    public FeatureDAO() {
        super();
    }
    
    /**
     * Find all features
     */
    public List<Feature> findAll() {
        List<Feature> features = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                features.add(mapResultSetToFeature(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách features", e);
        }
        return features;
    }
    
    /**
     * Find feature by ID
     */
    public Feature findById(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFeature(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm feature với ID: " + id, e);
        }
        return null;
    }
    
    /**
     * Find feature by name
     */
    public Feature findByName(String name) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_NAME)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFeature(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm feature với name: " + name, e);
        }
        return null;
    }
    
    /**
     * Create new feature
     */
    public boolean create(Feature feature) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setString(1, feature.getName());
            ps.setString(2, feature.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo feature: " + feature.getName(), e);
            return false;
        }
    }
    
    /**
     * Update feature
     */
    public boolean update(Feature feature) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, feature.getName());
            ps.setString(2, feature.getDescription());
            ps.setInt(3, feature.getFeatureId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật feature với ID: " + feature.getFeatureId(), e);
            return false;
        }
    }
    
    /**
     * Delete feature by ID
     */
    public boolean delete(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa feature với ID: " + id, e);
            return false;
        }
    }
    
    /**
     * Map ResultSet to Feature object
     */
    private Feature mapResultSetToFeature(ResultSet rs) throws SQLException {
        Feature feature = new Feature();
        feature.setFeatureId(rs.getInt("feature_id"));
        feature.setName(rs.getString("name"));
        feature.setDescription(rs.getString("description"));
        return feature;
    }
}
