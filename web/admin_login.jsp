<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Login</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script type="text/javascript" src="scripts.js"></script>
        <%
            AdminWebServices_Service admin_service = new AdminWebServices_Service();
            AdminWebServices admin_port = admin_service.getAdminWebServicesPort();
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
                    List<String> admin = admin_port.adminLogin(emailAddress, password);
                    if (admin != null) {
                        session = request.getSession(true);
                        session.setAttribute("adminId", admin.get(0));
                        session.setAttribute("firstName", admin.get(1));
                        session.setAttribute("lastName", admin.get(2));
                        response.sendRedirect("admin_pages/manage_employees_view.jsp");
                        return;
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
            <h2>Admin Login</h2>
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
        <p><a href="employee_login.jsp">Log in as Employee</a></p>
    </body>
</html>