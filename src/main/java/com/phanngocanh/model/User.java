package com.phanngocanh.model;

import java.util.List;

import javax.management.relation.Role;

import Models.Department;

/**
 * Model class for User entity
 */
public class User {
    private int userId;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private int departmentId;
    private Integer managerId;
    private Department department;
    private User manager;
    private List<Role> roles;
    
    public User() {}
    
    public User(int userId, String username, String passwordHash, String fullName, 
                String email, int departmentId, Integer managerId) {
        this.userId = userId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.departmentId = departmentId;
        this.managerId = managerId;
    }
    
    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public int getDepartmentId() { return departmentId; }
    public void setDepartmentId(int departmentId) { this.departmentId = departmentId; }
    
    public Integer getManagerId() { return managerId; }
    public void setManagerId(Integer managerId) { this.managerId = managerId; }
    
    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
    
    public User getManager() { return manager; }
    public void setManager(User manager) { this.manager = manager; }
    
    public List<Role> getRoles() { return roles; }
    public void setRoles(List<Role> roles) { this.roles = roles; }
    
    // Utility methods
    public boolean hasRole(String roleName) {
        if (roles == null) return false;
        return roles.stream().anyMatch(role -> role.getRoleName().equals(roleName));
    }
    
    public boolean isManager() {
        return hasRole("Manager");
    }
    
    public boolean isAdmin() {
        return hasRole("Admin");
    }
    
    public boolean isEmployee() {
        return hasRole("Employee");
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", departmentId=" + departmentId +
                ", managerId=" + managerId +
                '}';
    }
} 