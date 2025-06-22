/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Department;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for Department entity
 */
public class DepartmentDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(DepartmentDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Departments ORDER BY name";
    private static final String SQL_FIND_BY_ID = "SELECT * FROM Departments WHERE department_id = ?";
    private static final String SQL_FIND_BY_NAME = "SELECT * FROM Departments WHERE name = ?";
    private static final String SQL_CREATE = "INSERT INTO Departments (name, description) VALUES (?, ?)";
    private static final String SQL_UPDATE = "UPDATE Departments SET name = ?, description = ? WHERE department_id = ?";
    private static final String SQL_DELETE = "DELETE FROM Departments WHERE department_id = ?";
    
    public DepartmentDAO() {
        super();
    }
    
    /**
     * Find all departments
     */
    public List<Department> findAll() {
        List<Department> departments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                departments.add(mapResultSetToDepartment(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách departments", e);
        }
        return departments;
    }
    
    /**
     * Find department by ID
     */
    public Department findById(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDepartment(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm department với ID: " + id, e);
        }
        return null;
    }
    
    /**
     * Find department by name
     */
    public Department findByName(String name) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_NAME)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDepartment(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm department với name: " + name, e);
        }
        return null;
    }
    
    /**
     * Create new department
     */
    public boolean create(Department department) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo department: " + department.getName(), e);
            return false;
        }
    }
    
    /**
     * Update department
     */
    public boolean update(Department department) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            ps.setInt(3, department.getDepartmentId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật department với ID: " + department.getDepartmentId(), e);
            return false;
        }
    }
    
    /**
     * Delete department by ID
     */
    public boolean delete(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa department với ID: " + id, e);
            return false;
        }
    }
    
    /**
     * Map ResultSet to Department object
     */
    private Department mapResultSetToDepartment(ResultSet rs) throws SQLException {
        Department department = new Department();
        department.setDepartmentId(rs.getInt("department_id"));
        department.setName(rs.getString("name"));
        department.setDescription(rs.getString("description"));
        return department;
    }
}
