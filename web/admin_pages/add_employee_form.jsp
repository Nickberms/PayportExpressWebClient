<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="extra_features.*"%>
<%@page import="web_services.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="javax.xml.datatype.*"%>
<%@page import="net.java.dev.jaxb.array.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add New Employee</title>
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
            if (session == null || session.getAttribute("adminId") == null) {
                response.sendRedirect("../admin_login.jsp");
                return;
            }
            String action = request.getParameter("action");
            try {
                if (action.equals("insert")) {
                    int branchStationed = Integer.parseInt(request.getParameter("branchStationed"));
                    String firstName = request.getParameter("firstName");
                    firstName = NameFormatter.formatName(firstName);
                    String lastName = request.getParameter("lastName");
                    lastName = NameFormatter.formatName(lastName);
                    String birthdateString = request.getParameter("birthdate");
                    Date gregorian = null;
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    gregorian = dateFormat.parse(birthdateString);
                    GregorianCalendar gregorianCalendar = new GregorianCalendar();
                    gregorianCalendar.setTime(gregorian);
                    XMLGregorianCalendar birthdate = DatatypeFactory.newInstance().newXMLGregorianCalendar(gregorianCalendar);
                    String sex = request.getParameter("sex");
                    String town = request.getParameter("town");
                    town = NameFormatter.formatName(town);
                    String municipality = request.getParameter("municipality");
                    municipality = NameFormatter.formatName(municipality);
                    String province = request.getParameter("province");
                    province = NameFormatter.formatName(province);
                    String address = town + ", " + municipality + ", " + province;
                    String phoneNumber = request.getParameter("phoneNumber");
                    String emailAddress = request.getParameter("emailAddress");
                    String password = request.getParameter("password");
                    try {
                        employee_port.insertNewEmployee(branchStationed, firstName, lastName, birthdate, sex, address, phoneNumber, emailAddress, password);
                        response.sendRedirect("manage_employees_view.jsp");
                    } catch (Exception error) {
                        error.printStackTrace();
                    }
                }
            } catch (Exception error) {
                error.printStackTrace();
            }
        %>
        <h2>Add New Payport Express Employee</h2>
        <form action="add_employee_form.jsp?action=insert" method="post">
            <div>
                <div>
                    <h3>Branch</h3>
                    <label for="branchStationed">Branch Station:</label>
                    <select id="branchStationed" name="branchStationed">
                        <%
                            List<StringArray> branchArray = branch_port.selectAllBranches();
                            List<String[]> branches = new ArrayList<>();
                            for (StringArray branchStringArray : branchArray) {
                                branches.add(branchStringArray.getItem().toArray(new String[0]));
                            }
                            for (String[] branch : branches) {
                        %>
                        <option value="<%= branch[0]%>"><%= branch[0]%> <%= branch[2]%></option>
                        <%
                            }
                        %>
                    </select><br>
                    <h3>Basic Information</h3>
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" oninput="LettersOnly(this)" required><br>
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" oninput="LettersOnly(this)" required><br>
                    <label for="birthdate">Birthdate:</label>
                    <input type="date" id="birthdate" name="birthdate" required><br>
                    <label for="sex">Sex:</label>
                    <select id="sex" name="sex">
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select><br>
                    <h3>Address</h3>
                    <label for="town">Town:</label>
                    <input type="text" id="town" name="town" oninput="LettersOnly(this)" required><br>
                    <label for="municipality">Municipality:</label>
                    <input type="text" id="municipality" name="municipality" oninput="LettersOnly(this)" required><br>
                    <label for="province">Province:</label>
                    <input type="text" id="province" name="province" oninput="LettersOnly(this)" required><br>
                    <h3>Credentials</h3>
                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" oninput="NumbersOnly(this)" required><br>
                    <label for="emailAddress">Email Address:</label>
                    <input type="email" id="emailAddress" name="emailAddress" oninput="EmailOnly(this)" required><br>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required><br><br>
                </div>
            </div>
            <div>
                <button type="submit">Save</button>
            </div>
        </form><br>
        <form action="manage_employees_view.jsp">
            <input type="submit" value="Cancel">
        </form><br><br>
    </body>
</html>