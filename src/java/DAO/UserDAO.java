/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.User;
import Models.RoleContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for User entity
 */
public class UserDAO extends DbContext {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    
    // SQL Constants
    private static final String SQL_FIND_ALL = "SELECT * FROM Users ORDER BY username";
    private static final String SQL_FIND_BY_ID = "SELECT * FROM Users WHERE user_id = ?";
    private static final String SQL_FIND_BY_USERNAME = "SELECT * FROM Users WHERE username = ?";
    private static final String SQL_FIND_BY_EMAIL = "SELECT * FROM Users WHERE email = ?";
    private static final String SQL_FIND_BY_DEPARTMENT_ID = "SELECT * FROM Users WHERE department_id = ? ORDER BY username";
    private static final String SQL_FIND_BY_USERNAME_AND_PASSWORD = "SELECT * FROM Users WHERE username = ? AND password_hash = ?";
    private static final String SQL_AUTHENTICATE = "SELECT u.* FROM Users u WHERE u.username = ? AND u.password_hash = ?";
    private static final String SQL_GET_USER_ROLE_CONTEXTS = 
        "SELECT r.name as role_name, u.department_id, d.name as department_name " +
        "FROM Users u " +
        "INNER JOIN User_Roles ur ON u.user_id = ur.user_id " +
        "INNER JOIN Roles r ON ur.role_id = r.role_id " +
        "LEFT JOIN Departments d ON u.department_id = d.department_id " +
        "WHERE u.user_id = ?";
    private static final String SQL_CREATE = "INSERT INTO Users (username, password_hash, full_name, email, department_id, manager_id) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE Users SET username = ?, password_hash = ?, full_name = ?, email = ?, department_id = ?, manager_id = ? WHERE user_id = ?";
    private static final String SQL_DELETE = "DELETE FROM Users WHERE user_id = ?";
    private static final String SQL_UPDATE_PASSWORD = "UPDATE Users SET password_hash = ? WHERE user_id = ?";
    
    public UserDAO() {
        super();
    }
    
    /**
     * Authenticate user with username and password
     */
    public User authenticate(String username, String password) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_AUTHENTICATE)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xác thực user với username: " + username, e);
        }
        return null;
    }
    
    /**
     * Get user role contexts (role + department combinations)
     */
    public List<RoleContext> getUserRoleContexts(int userId) {
        List<RoleContext> contexts = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_GET_USER_ROLE_CONTEXTS)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RoleContext context = new RoleContext();
                    context.setRoleName(rs.getString("role_name"));
                    context.setDepartmentId(rs.getInt("department_id"));
                    String departmentName = rs.getString("department_name");
                    context.setDepartmentName(departmentName == null ? "Toàn hệ thống" : departmentName);
                    contexts.add(context);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy role contexts cho user ID: " + userId, e);
        }
        return contexts;
    }
    
    /**
     * Find all users
     */
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách users", e);
        }
        return users;
    }
    
    /**
     * Find user by ID
     */
    public User findById(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm user với ID: " + id, e);
        }
        return null;
    }
    
    /**
     * Find user by username
     */
    public User findByUsername(String username) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_USERNAME)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm user với username: " + username, e);
        }
        return null;
    }
    
    /**
     * Find user by email
     */
    public User findByEmail(String email) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_EMAIL)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm user với email: " + email, e);
        }
        return null;
    }
    
    /**
     * Find users by department ID
     */
    public List<User> findByDepartmentId(int departmentId) {
        List<User> users = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_DEPARTMENT_ID)) {
            ps.setInt(1, departmentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm users với department ID: " + departmentId, e);
        }
        return users;
    }
    
    /**
     * Find user by username and password (for login) - deprecated, use authenticate instead
     */
    public User getUserByUsernameAndPassword(String username, String password) {
        return authenticate(username, password);
    }
    
    /**
     * Create new user
     */
    public boolean create(User user) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_CREATE)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setInt(5, user.getDepartmentId());
            ps.setObject(6, user.getManagerId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo user: " + user.getUsername(), e);
            return false;
        }
    }
    
    /**
     * Update user
     */
    public boolean update(User user) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setInt(5, user.getDepartmentId());
            ps.setObject(6, user.getManagerId());
            ps.setInt(7, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật user với ID: " + user.getUserId(), e);
            return false;
        }
    }
    
    /**
     * Update user password
     */
    public boolean updatePassword(int userId, String newPassword) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE_PASSWORD)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật password cho user ID: " + userId, e);
            return false;
        }
    }
    
    /**
     * Delete user by ID
     */
    public boolean delete(int id) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa user với ID: " + id, e);
            return false;
        }
    }
    
    /**
     * Check if username exists
     */
    public boolean isUsernameExists(String username) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_USERNAME)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra username: " + username, e);
        }
        return false;
    }
    
    /**
     * Check if email exists
     */
    public boolean isEmailExists(String email) {
        try (PreparedStatement ps = connection.prepareStatement(SQL_FIND_BY_EMAIL)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi kiểm tra email: " + email, e);
        }
        return false;
    }
    
    /**
     * Map ResultSet to User object
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setDepartmentId(rs.getInt("department_id"));
        
        // Handle nullable manager_id
        int managerId = rs.getInt("manager_id");
        if (!rs.wasNull()) {
            user.setManagerId(managerId);
        }
        
        return user;
    }
}
