<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="extra_features.*"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add New Branch</title>
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
            if (session == null || session.getAttribute("adminId") == null) {
                response.sendRedirect("../admin_login.jsp");
                return;
            }
            String action = request.getParameter("action");
            try {
                if (action.equals("insert")) {
                    String branchName = request.getParameter("branchName").trim();
                    branchName = NameFormatter.formatName(branchName);
                    String town = request.getParameter("town").trim();
                    town = NameFormatter.formatName(town);
                    String municipality = request.getParameter("municipality").trim();
                    municipality = NameFormatter.formatName(municipality);
                    String province = request.getParameter("province").trim();
                    province = NameFormatter.formatName(province);
                    String address = town + ", " + municipality + ", " + province;
                    try {
                        if (branchName.isEmpty() || town.isEmpty() || municipality.isEmpty() || province.isEmpty()) {
                            out.println("Sorry, invalid input. Please try again.");
                        } else {
                            branch_port.insertNewBranch(branchName, address);
                            response.sendRedirect("manage_branches_view.jsp");
                        }
                    } catch (Exception error) {
                        error.printStackTrace();
                    }
                }
            } catch (Exception error) {
                error.printStackTrace();
            }
        %>
        <h2>Add New Payport Express Branch</h2>
        <form action="add_branch_form.jsp?action=insert" method="post">
            <div>
                <div>
                    <h3>Name</h3>
                    <label for="branchName">Branch Name:</label>
                    <input type="text" id="branchName" name="branchName" oninput="LettersOnly(this)" required><br>
                    <h3>Address</h3>
                    <label for="town">Town:</label>
                    <input type="text" id="town" name="town" oninput="LettersOnly(this)" required><br>
                    <label for="municipality">Municipality:</label>
                    <input type="text" id="municipality" name="municipality" oninput="LettersOnly(this)" required><br>
                    <label for="province">Province:</label>
                    <input type="text" id="province" name="province" oninput="LettersOnly(this)" required><br>
                </div>
            </div><br>
            <div>
                <button type="submit">Save</button>
            </div>
        </form><br>
        <form action="manage_branches_view.jsp">
            <input type="submit" value="Cancel">
        </form>
    </body>
</html>