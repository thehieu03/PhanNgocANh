package Controller;

import DAO.RequestDAO;
import DAO.UserDAO;
import DAO.DepartmentDAO;
import Models.Request;
import Models.User;
import Models.Department;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to handle agenda view with calendar display
 */
public class AgendaServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AgendaServlet.class.getName());
    private final RequestDAO requestDAO = new RequestDAO();
    private final UserDAO userDAO = new UserDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }
        
        try {
            String deptIdStr = request.getParameter("deptId");
            String fromDateStr = request.getParameter("from");
            String toDateStr = request.getParameter("to");
            
            // Default to current month if no dates provided
            LocalDate fromDate = fromDateStr != null ? LocalDate.parse(fromDateStr) : LocalDate.now().withDayOfMonth(1);
            LocalDate toDate = toDateStr != null ? LocalDate.parse(toDateStr) : LocalDate.now().withDayOfMonth(LocalDate.now().lengthOfMonth());
            
            int deptId = deptIdStr != null ? Integer.parseInt(deptIdStr) : user.getDepartmentId();
            
            // Get department info
            Department department = departmentDAO.findById(deptId);
            if (department == null) {
                request.setAttribute("error", "Không tìm thấy phòng ban");
                request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
                return;
            }
            
            // Get all departments for filter dropdown
            List<Department> departments = departmentDAO.findAll();
            
            // Get users in the department
            List<User> users = userDAO.findByDepartmentId(deptId);
            
            // Get approved requests in date range
            List<Request> approvedRequests = requestDAO.findByDateRange(fromDate, toDate);
            approvedRequests.removeIf(req -> req.getStatusId() != 2); // Only approved requests
            
            // Create agenda data structure
            Map<String, Map<Integer, String>> agendaData = createAgendaData(users, approvedRequests, fromDate, toDate);
            
            request.setAttribute("department", department);
            request.setAttribute("departments", departments);
            request.setAttribute("users", users);
            request.setAttribute("agendaData", agendaData);
            request.setAttribute("fromDate", fromDate);
            request.setAttribute("toDate", toDate);
            request.setAttribute("selectedDeptId", deptId);
            
            request.getRequestDispatcher("/JSP/agenda.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID phòng ban không hợp lệ");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tải agenda", e);
            request.setAttribute("error", "Có lỗi xảy ra khi tải lịch làm việc");
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }
    
    private Map<String, Map<Integer, String>> createAgendaData(List<User> users, List<Request> requests, LocalDate fromDate, LocalDate toDate) {
        Map<String, Map<Integer, String>> agendaData = new HashMap<>();
        
        // Initialize data structure
        LocalDate currentDate = fromDate;
        while (!currentDate.isAfter(toDate)) {
            String dateKey = currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            Map<Integer, String> userStatus = new HashMap<>();
            
            for (User user : users) {
                userStatus.put(user.getUserId(), "Work"); // Default to work
            }
            
            agendaData.put(dateKey, userStatus);
            currentDate = currentDate.plusDays(1);
        }
        
        // Fill in leave requests
        for (Request req : requests) {
            LocalDate reqStart = req.getStartDate();
            LocalDate reqEnd = req.getEndDate();
            
            // Check if request overlaps with our date range
            if (!reqStart.isAfter(toDate) && !reqEnd.isBefore(fromDate)) {
                LocalDate start = reqStart.isBefore(fromDate) ? fromDate : reqStart;
                LocalDate end = reqEnd.isAfter(toDate) ? toDate : reqEnd;
                
                LocalDate current = start;
                while (!current.isAfter(end)) {
                    String dateKey = current.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    Map<Integer, String> userStatus = agendaData.get(dateKey);
                    
                    if (userStatus != null) {
                        userStatus.put(req.getUserId(), "Off");
                    }
                    
                    current = current.plusDays(1);
                }
            }
        }
        
        return agendaData;
    }
} 