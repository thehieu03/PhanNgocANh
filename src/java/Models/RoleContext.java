package Models;

/**
 * Model class for RoleContext - represents user role in a specific department
 */
public class RoleContext {
    private String roleName;
    private int departmentId;
    private String departmentName;
    
    public RoleContext() {
    }
    
    public RoleContext(String roleName, int departmentId, String departmentName) {
        this.roleName = roleName;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
    }
    
    public String getRoleName() {
        return roleName;
    }
    
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
    
    public int getDepartmentId() {
        return departmentId;
    }
    
    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }
    
    public String getDepartmentName() {
        return departmentName;
    }
    
    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }
    
    @Override
    public String toString() {
        return "RoleContext{" + "roleName=" + roleName + ", departmentId=" + departmentId + ", departmentName=" + departmentName + '}';
    }
} 