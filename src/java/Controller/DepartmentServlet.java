package Controller;

import DAO.DepartmentDAO;
import DAO.UserDAO;
import Models.Department;
import Models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class DepartmentServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                listDepartments(request, response);
                break;
            case "view":
                viewDepartment(request, response);
                break;
            default:
                listDepartments(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            DepartmentDAO departmentDAO = new DepartmentDAO();
            Department dept = new Department();
            dept.setName(name);
            dept.setDescription(description);
            boolean success = departmentDAO.create(dept);
            if (success) {
                request.setAttribute("message", "Thêm phòng ban thành công!");
            } else {
                request.setAttribute("error", "Thêm phòng ban thất bại!");
            }
            listDepartments(request, response);
        } else if ("edit".equals(action)) {
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            try {
                int id = Integer.parseInt(idStr);
                DepartmentDAO departmentDAO = new DepartmentDAO();
                Department dept = departmentDAO.findById(id);
                if (dept != null) {
                    dept.setName(name);
                    dept.setDescription(description);
                    boolean success = departmentDAO.update(dept);
                    if (success) {
                        request.setAttribute("message", "Cập nhật phòng ban thành công!");
                    } else {
                        request.setAttribute("error", "Cập nhật phòng ban thất bại!");
                    }
                } else {
                    request.setAttribute("error", "Không tìm thấy phòng ban để cập nhật!");
                }
            } catch (Exception e) {
                request.setAttribute("error", "ID phòng ban không hợp lệ!");
            }
            listDepartments(request, response);
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            try {
                int id = Integer.parseInt(idStr);
                DepartmentDAO departmentDAO = new DepartmentDAO();
                boolean success = departmentDAO.delete(id);
                if (success) {
                    request.setAttribute("message", "Xóa phòng ban thành công!");
                } else {
                    request.setAttribute("error", "Xóa phòng ban thất bại!");
                }
            } catch (Exception e) {
                request.setAttribute("error", "ID phòng ban không hợp lệ!");
            }
            listDepartments(request, response);
        } else {
            processRequest(request, response);
        }
    }

    private void listDepartments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DepartmentDAO departmentDAO = new DepartmentDAO();
            List<Department> departments = departmentDAO.findAll();
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("/JSP/departmentList.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách phòng ban: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách phòng ban!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    private void viewDepartment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String deptIdStr = request.getParameter("id");
            if (deptIdStr == null || deptIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/departments");
                return;
            }
            int deptId = Integer.parseInt(deptIdStr);
            DepartmentDAO departmentDAO = new DepartmentDAO();
            Department department = departmentDAO.findById(deptId);
            if (department == null) {
                request.setAttribute("error", "Không tìm thấy phòng ban!");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            UserDAO userDAO = new UserDAO();
            List<User> users = userDAO.findByDepartment(deptId);
            request.setAttribute("department", department);
            request.setAttribute("users", users);
            request.getRequestDispatcher("/JSP/departmentDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID phòng ban không hợp lệ!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi khi xem chi tiết phòng ban: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin phòng ban!");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
} 