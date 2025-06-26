/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import Models.User;
import Models.RoleContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author hieun
 */
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang login.jsp
        request.getRequestDispatcher("/JSP/Login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý đăng nhập
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Kiểm tra dữ liệu đầu vào
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập!");
            request.getRequestDispatcher("/JSP/Login.jsp").forward(request, response);
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.authenticate(username.trim(), password.trim());
            
            if (user != null) {
                // Đăng nhập thành công
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Lấy danh sách role contexts
                List<RoleContext> roleContexts = userDAO.getUserRoleContexts(user.getUserId());
                session.setAttribute("roleContexts", roleContexts);
                for (RoleContext context : roleContexts) {
                    if ("Admin".equalsIgnoreCase(context.getRoleName())) {
                        session.setAttribute("selectedRole", "Admin");
                        session.setAttribute("selectedDept", 0); 
                        response.sendRedirect("admin/home");
                        return;
                    }
                }
                if (roleContexts.size() == 1) {
                    // Chỉ có 1 context, tự động chọn
                    RoleContext context = roleContexts.get(0);
                    session.setAttribute("selectedRole", context.getRoleName());
                    session.setAttribute("selectedDept", context.getDepartmentId());
                    session.setAttribute("selectedDeptName", context.getDepartmentName());
                    
                    // Redirect theo role
                    if ("Employee".equalsIgnoreCase(context.getRoleName())) {
                        response.sendRedirect("employee/home");
                    } else if ("Manager".equalsIgnoreCase(context.getRoleName())) {
                        response.sendRedirect("manager/home");
                    } else {
                        // Xử lý cho các role khác nếu có
                        request.setAttribute("error", "Vai trò của bạn không được hỗ trợ để tự động đăng nhập.");
                        request.getRequestDispatcher("/JSP/Login.jsp").forward(request, response);
                    }
                } else if (roleContexts.size() > 1) {
                    // Có nhiều contexts, chuyển đến trang chọn
                    response.sendRedirect("selectContext");
                } else {
                    // Không có role nào hợp lệ
                    request.setAttribute("error", "Tài khoản không có quyền truy cập!");
                    request.getRequestDispatcher("/JSP/Login.jsp").forward(request, response);
                }
                
            } else {
                // Đăng nhập thất bại
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
                request.setAttribute("username", username);
                request.getRequestDispatcher("/JSP/Login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.out.println("Lỗi đăng nhập: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau!");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/JSP/Login.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập";
    }// </editor-fold>

}
