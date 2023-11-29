<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Employee Login</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script type="text/javascript" src="scripts.js"></script>
        <%
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
            if (session != null) {
                session.invalidate();
            }
            String errorMessage = "";
            try {
                if ("POST".equals(request.getMethod())) {
                    String emailAddress = request.getParameter("emailAddress");
                    String password = request.getParameter("password");
                    List<String> employee = employee_port.employeeLogin(emailAddress, password);
                    if (employee != null) {
                        String working_status = employee.get(2);
                        if ("Fired".equals(working_status)) {
                            errorMessage = "Access is prohibited for former employees.";
                        } else {
                            session = request.getSession(true);
                            session.setAttribute("employeeId", employee.get(0));
                            session.setAttribute("branchStationed", employee.get(1));
                            session.setAttribute("firstName", employee.get(3));
                            session.setAttribute("lastName", employee.get(4));
                            response.sendRedirect("employee_pages/manage_transactions_view.jsp");
                            return;
                        }
                    } else {
                        errorMessage = "Invalid email address or password.";
                    }
                }
            } catch (Exception error) {
                errorMessage = "Invalid email address or password.";
                error.printStackTrace();
            }
        %>
        <form method="POST">
            <h2>Employee Login</h2>
            <label for="emailAddress">Email Address:</label>
            <input type="text" id="emailAddress" name="emailAddress" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            <input type="submit" value="Log In"><br><br>
            <div><%= errorMessage%></div><br>
        </form>
        <form action="add_transaction_form.jsp">
            <input type="submit" value="Go to Add Transaction Form">
        </form>
        <p><a href="admin_login.jsp">Log in as Admin</a></p>
    </body>
</html>