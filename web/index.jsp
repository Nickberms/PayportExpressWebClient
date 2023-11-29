<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Payport Express</title>
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
        %>
        <br><form action="add_transaction_form.jsp">
            <input type="submit" value="Go to Add Transaction Form">
        </form><br>
        <form action="employee_login.jsp">
            <input type="submit" value="Go to Employee Login">
        </form>
    </body>
</html>