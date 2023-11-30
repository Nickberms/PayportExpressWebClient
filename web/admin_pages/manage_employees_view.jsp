<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="extra_features.*"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="net.java.dev.jaxb.array.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Employees</title>
        <link rel="stylesheet" type="text/css" href="admin_styles.css">
        <script type="text/javascript" src="admin_scripts.js"></script>
        <%
            BranchWebServices_Service branch_service = new BranchWebServices_Service();
            BranchWebServices branch_port = branch_service.getBranchWebServicesPort();
            EmployeeWebServices_Service employee_service = new EmployeeWebServices_Service();
            EmployeeWebServices employee_port = employee_service.getEmployeeWebServicesPort();
        %>
    </head>
    <body>        
        <%
            HttpServletResponse httpResponse = response;
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");
            httpResponse.setDateHeader("Expires", 0);
            session = request.getSession(false);
            String adminId = (String) session.getAttribute("adminId");
            if (session == null || session.getAttribute("adminId") == null) {
                response.sendRedirect("../admin_login.jsp");
                return;
            }
            String firstName = (String) session.getAttribute("firstName");
            String lastName = (String) session.getAttribute("lastName");
            String action = request.getParameter("action");
            try {
                if (action.equals("logout")) {
                    if (session != null) {
                        session.invalidate();
                    }
                    response.sendRedirect("../admin_login.jsp");
                    return;
                }
            } catch (Exception error) {
                error.printStackTrace();
            }
        %>
        <h2>Welcome <%= firstName%> <%= lastName%></h2>
        <p>Admin ID: <%= adminId%></p>
        <a href="manage_employees_view.jsp?action=logout">Logout</a>
        <%
            try {
                if (action.equals("delete")) {
                    String employeeIdParam = request.getParameter("employeeId");
                    int employeeId = Integer.parseInt(employeeIdParam);
                    employee_port.deleteEmployee(employeeId);
                    response.sendRedirect("manage_employees_view.jsp");
                }
            } catch (Exception error) {
                error.printStackTrace();
            }
        %>
        <br><br><h2>Manage Employees</h2>
        <form action="manage_branches_view.jsp">
            <input type="submit" value="Go to Branches Table">
        </form><br>
        <form action="add_employee_form.jsp">
            <input type="submit" value="Add New Employee">
        </form><br>
        <form action="<%=request.getRequestURI()%>" method="get">
            <label for="keyword">Search Employees:</label>
            <input type="text" id="keyword" name="keyword">
            <input type="submit" value="Search">
        </form><br>
        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Branch Stationed</th>
                    <th>Working Status</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Birthdate</th>
                    <th>Sex</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Email Address</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<StringArray> employeeArray = employee_port.selectAllEmployees();
                    List<String[]> employees = new ArrayList<>();
                    for (StringArray employeeStringArray : employeeArray) {
                        employees.add(employeeStringArray.getItem().toArray(new String[0]));
                    }
                    HashMap<Integer, String> branchMap = new HashMap<>();
                    List<StringArray> branchArray = branch_port.selectAllBranches();
                    for (StringArray branchStringArray : branchArray) {
                        String[] branch = branchStringArray.getItem().toArray(new String[0]);
                        branchMap.put(Integer.parseInt(branch[0]), branch[2]);
                    }
                    String keyword = request.getParameter("keyword");
                    if (keyword != null) {
                        keyword = keyword.toLowerCase();
                    }
                    for (String[] employee : employees) {
                        String branchName = branchMap.getOrDefault(Integer.parseInt(employee[1]), "No Branch");
                        boolean matchesKeyword = true;
                        if (keyword != null && !keyword.trim().isEmpty()) {
                            matchesKeyword = false;
                            for (String field : employee) {
                                if (field != null && field.toLowerCase().contains(keyword)) {
                                    matchesKeyword = true;
                                    break;
                                }
                            }
                            if (branchName.toLowerCase().contains(keyword)) {
                                matchesKeyword = true;
                            }
                        }
                        if (matchesKeyword) {
                %>
                <tr>
                    <td><%= employee[0]%></td>
                    <td><%= employee[1]%> <%= branchName%></td>
                    <td><%= employee[2]%></td>
                    <td><%= employee[3]%></td>
                    <td><%= employee[4]%></td>
                    <td><%= employee[5]%></td>
                    <td><%= employee[6]%></td>
                    <td><%= employee[7]%></td>
                    <td><%= employee[8]%></td>
                    <td><%= employee[9]%></td>
                    <td>
                        <a href="update_employee_form.jsp?employeeId=<%= employee[0]%>">Update</a>
                        <a href="manage_employees_view.jsp?action=delete&employeeId=<%= employee[0]%>" onclick="return confirm('Delete employee? Make sure it does not hold any records anymore');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>   
            </tbody>
        </table><br><br><br>
    </body>
</html>