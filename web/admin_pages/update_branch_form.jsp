<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="extra_features.*"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Branch</title>
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
            String branchIdParam = request.getParameter("branchId");
            if (session == null || session.getAttribute("adminId") == null) {
                response.sendRedirect("../admin_login.jsp");
                return;
            } else if (branchIdParam == null || branchIdParam.trim().isEmpty()) {
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect("manage_branches_view.jsp");
                }
                return;
            }
            String action = request.getParameter("action");
            try {
                if (action.equals("update")) {
                    int branchId = Integer.parseInt(request.getParameter("branchId"));
                    String operationStatus = request.getParameter("operationStatus");
                    String branchName = request.getParameter("branchName");
                    branchName = NameFormatter.formatName(branchName);
                    String town = request.getParameter("town");
                    town = NameFormatter.formatName(town);
                    String municipality = request.getParameter("municipality");
                    municipality = NameFormatter.formatName(municipality);
                    String province = request.getParameter("province");
                    province = NameFormatter.formatName(province);
                    String address = town + ", " + municipality + ", " + province;
                    try {
                        branch_port.updateBranch(branchId, operationStatus, branchName, address);
                        response.sendRedirect("manage_branches_view.jsp");
                    } catch (Exception error) {
                        error.printStackTrace();
                    }
                }
            } catch (Exception error) {
                error.printStackTrace();
            }
        %>
        <h2>Update Payport Express Branch</h2>
        <form action="update_branch_form.jsp?action=update" method="post">
            <div> <%
                String branchIdStr = request.getParameter("branchId");
                int branchId = 0;
                List<String> branch = null;
                if (branchIdStr != null && !branchIdStr.isEmpty()) {
                    try {
                        branchId = Integer.parseInt(branchIdStr);
                        branch = branch_port.selectBranch(branchId);
                    } catch (Exception error) {
                        error.printStackTrace();
                    }
                }
                String fullAddress = branch.get(3);
                String[] addressParts = fullAddress.split(",");
                String town = addressParts.length > 0 ? addressParts[0].trim() : "";
                String municipality = addressParts.length > 1 ? addressParts[1].trim() : "";
                String province = addressParts.length > 2 ? addressParts[2].trim() : "";
                %>
                <div>
                    <label for="branchId">Branch ID:</label>
                    <input type="text" id="branchId" name="branchId" value="<%= branch.get(0)%>" readonly><br>
                    <h3>Status and Name</h3>
                    <label for="operationStatus">Operation Status:</label>
                    <select id="operationStatus" name="operationStatus">
                        <option value="Active" <%= "Active".equals(branch.get(1).trim()) ? "selected" : ""%>>Active</option>
                        <option value="Inactive" <%= "Inactive".equals(branch.get(1).trim()) ? "selected" : ""%>>Inactive</option>
                    </select><br>
                    <label for="branchName">Branch Name:</label>
                    <input type="text" id="branchName" name="branchName" value="<%= branch.get(2)%>" oninput="LettersOnly(this)" required><br>
                    <h3>Address</h3>
                    <label for="town">Town:</label>
                    <input type="text" id="town" name="town" value="<%= town%>" oninput="LettersOnly(this)" required><br>
                    <label for="municipality">Municipality:</label>
                    <input type="text" id="municipality" name="municipality" value="<%= municipality%>" oninput="LettersOnly(this)" required><br>
                    <label for="province">Province:</label>
                    <input type="text" id="province" name="province" value="<%= province%>" oninput="LettersOnly(this)" required><br>
                </div>
            </div>
            <div><br>
                <button type="submit">Save</button>
            </div>
        </form><br>
        <form action="manage_branches_view.jsp">
            <input type="submit" value="Cancel">
        </form>
    </body>
</html>