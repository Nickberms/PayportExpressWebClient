<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="extra_features.*"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="net.java.dev.jaxb.array.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Branches</title>
        <link rel="stylesheet" type="text/css" href="admin_styles.css">
        <script type="text/javascript" src="admin_scripts.js"></script>
        <%
            BranchWebServices_Service branch_service = new BranchWebServices_Service();
            BranchWebServices branch_port = branch_service.getBranchWebServicesPort();
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
        <a href="manage_branches_view.jsp?action=logout">Logout</a>
        <%
            try {
                if (action.equals("delete")) {
                    String branchIdParam = request.getParameter("branchId");
                    int branchId = Integer.parseInt(branchIdParam);
                    branch_port.deleteBranch(branchId);
                    response.sendRedirect("manage_branches_view.jsp");
                }
            } catch (Exception error) {
                error.printStackTrace();
            }
        %>
        <br><br><h2>Manage Branches</h2>
        <form action="manage_employees_view.jsp">
            <input type="submit" value="Go to Employees Table">
        </form><br>
        <form action="add_branch_form.jsp">
            <input type="submit" value="Add New Branch">
        </form><br>
        <form action="<%=request.getRequestURI()%>" method="get">
            <label for="keyword">Search Branches:</label>
            <input type="text" id="keyword" name="keyword">
            <input type="submit" value="Search">
        </form><br>
        <table>
            <thead>
                <tr>
                    <th>Branch ID</th>
                    <th>Operation Status</th>
                    <th>Branch Name</th>
                    <th>Address</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<StringArray> branchArray = branch_port.selectAllBranches();
                    List<String[]> branches = new ArrayList<>();
                    for (StringArray branchStringArray : branchArray) {
                        branches.add(branchStringArray.getItem().toArray(new String[0]));
                    }
                    String keyword = request.getParameter("keyword");
                    if (keyword != null) {
                        keyword = keyword.toLowerCase();
                    }
                    for (String[] branch : branches) {
                        boolean matchesKeyword = true;
                        if (keyword != null && !keyword.trim().isEmpty()) {
                            matchesKeyword = false;
                            for (String field : branch) {
                                if (field != null && field.toLowerCase().contains(keyword)) {
                                    matchesKeyword = true;
                                    break;
                                }
                            }
                        }
                        if (matchesKeyword) {
                %>
                <tr>
                    <td><%= branch[0]%></td>
                    <td><%= branch[1]%></td>
                    <td><%= branch[2]%></td>
                    <td><%= branch[3]%></td>
                    <td>
                        <a href="update_branch_form.jsp?branchId=<%= branch[0]%>">Update</a>
                        <a href="manage_branches_view.jsp?action=delete&branchId=<%= branch[0]%>" onclick="return confirm('Delete branch? Make sure it does not hold any records anymore');">Delete</a>
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