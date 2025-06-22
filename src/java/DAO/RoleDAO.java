/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Role;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for Role entity
 */
public class RoleDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(RoleDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Roles ORDER BY name";
    private static final String SQL_FIND_BY_ID = "SELECT * FROM Roles WHERE role_id = ?";
    private static final String SQL_FIND_BY_NAME = "SELECT * FROM Roles WHERE name = ?";
    private static final String SQL_CREATE = "INSERT INTO Roles (name, description) VALUES (?, ?)";
    private static final String SQL_UPDATE = "UPDATE Roles SET name = ?, description = ? WHERE role_id = ?";
    private static final String SQL_DELETE = "DELETE FROM Roles WHERE role_id = ?";
    
    public RoleDAO() {
        super();
    }
    
    /**
     * Find all roles
     */
    public List<Role> findAll() {
        List<Role> roles = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                roles.add(mapResultSetToRole(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách roles", e);
        }
        return roles;
    }
    
    /**
     * Find role by ID
     */
    public Role findById(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRole(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm role với ID: " + id, e);
        }
        return null;
    }
    
    /**
     * Find role by name
     */
    public Role findByName(String name) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_NAME)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRole(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm role với name: " + name, e);
        }
        return null;
    }
    
    /**
     * Create new role
     */
    public boolean create(Role role) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setString(1, role.getName());
            ps.setString(2, role.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo role: " + role.getName(), e);
            return false;
        }
    }
    
    /**
     * Update role
     */
    public boolean update(Role role) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, role.getName());
            ps.setString(2, role.getDescription());
            ps.setInt(3, role.getRoleId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật role với ID: " + role.getRoleId(), e);
            return false;
        }
    }
    
    /**
     * Delete role by ID
     */
    public boolean delete(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa role với ID: " + id, e);
            return false;
        }
    }
    
    /**
     * Map ResultSet to Role object
     */
    private Role mapResultSetToRole(ResultSet rs) throws SQLException {
        Role role = new Role();
        role.setRoleId(rs.getInt("role_id"));
        role.setName(rs.getString("name"));
        role.setDescription(rs.getString("description"));
        return role;
    }
}
