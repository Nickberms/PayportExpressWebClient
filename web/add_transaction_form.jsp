<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="extra_features.*"%>
<%@page import="web_services.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add New Transaction</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script type="text/javascript" src="scripts.js"></script>
        <%
            TransactionWebServices_Service transaction_service = new TransactionWebServices_Service();
            TransactionWebServices transaction_port = transaction_service.getTransactionWebServicesPort();
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
            String action = request.getParameter("action");
            try {
                if (action.equals("insert")) {
                    String senderFirstName = request.getParameter("senderFirstName");
                    senderFirstName = NameFormatter.formatName(senderFirstName);
                    String senderMiddleName = request.getParameter("senderMiddleName");
                    senderMiddleName = NameFormatter.formatName(senderMiddleName);
                    String senderLastName = request.getParameter("senderLastName");
                    senderLastName = NameFormatter.formatName(senderLastName);
                    String senderNameSuffix = request.getParameter("senderNameSuffix");
                    String senderName = senderFirstName;
                    if (senderMiddleName != null && !senderMiddleName.isEmpty()) {
                        senderName += " " + senderMiddleName;
                    }
                    senderName += " " + senderLastName;
                    if (senderNameSuffix != null && !senderNameSuffix.isEmpty()) {
                        senderName += " " + senderNameSuffix;
                    }
                    String senderContactNumber = request.getParameter("senderContactNumber");
                    String receiverFirstName = request.getParameter("receiverFirstName");
                    receiverFirstName = NameFormatter.formatName(receiverFirstName);
                    String receiverMiddleName = request.getParameter("receiverMiddleName");
                    receiverMiddleName = NameFormatter.formatName(receiverMiddleName);
                    String receiverLastName = request.getParameter("receiverLastName");
                    receiverLastName = NameFormatter.formatName(receiverLastName);
                    String receiverNameSuffix = request.getParameter("receiverNameSuffix");
                    String receiverName = receiverFirstName;
                    if (receiverMiddleName != null && !receiverMiddleName.isEmpty()) {
                        receiverName += " " + receiverMiddleName;
                    }
                    receiverName += " " + receiverLastName;
                    if (receiverNameSuffix != null && !receiverNameSuffix.isEmpty()) {
                        receiverName += " " + receiverNameSuffix;
                    }
                    String receiverContactNumber = request.getParameter("receiverContactNumber");
                    String amount = request.getParameter("amount");
                    boolean insertionResult = false;
                    try {
                        transaction_port.insertNewTransaction(senderName, senderContactNumber, receiverName, receiverContactNumber, amount);
                        insertionResult = true;
                    } catch (Exception error) {
                        error.printStackTrace();
                    }
                    if (insertionResult) {
                        out.println("Your form has been successfully sent. We will contact you anytime for verification.");
                    } else {
                        out.println("Sorry, an error occurred while processing your request. Please try again later or contact support.");
                    }
                }
            } catch (Exception error) {
                error.printStackTrace();
            }
        %>
        <h2>Payport Express Transaction Form</h2>
        <form action="add_transaction_form.jsp?action=insert" method="post">
            <div>
                <div>
                    <h3>Sender Details</h3>
                    <label for="senderFirstName">First Name:</label>
                    <input type="text" id="senderFirstName" name="senderFirstName" oninput="LettersOnly(this)" required><br>
                    <label for="senderMiddleName">Middle Name:</label>
                    <input type="text" id="senderMiddleName" name="senderMiddleName" oninput="LettersOnly(this)"><br>
                    <label for="senderLastName">Last Name:</label>
                    <input type="text" id="senderLastName" name="senderLastName" oninput="LettersOnly(this)" required><br>
                    <label for="senderNameSuffix">Name Suffix:</label>
                    <select id="senderNameSuffix" name="senderNameSuffix">
                        <option value="">None</option>
                        <option value="Sr.">Sr.</option>
                        <option value="Jr.">Jr.</option>
                        <option value="III">III</option>
                        <option value="IV">IV</option>
                        <option value="V">V</option>
                        <option value="VI">VI</option>
                        <option value="VII">VII</option>
                        <option value="VIII">VIII</option>
                        <option value="IX">IX</option>
                        <option value="X">X</option>
                    </select><br>
                    <label for="senderContactNumber">Contact Number:</label>
                    <input type="text" id="senderContactNumber" name="senderContactNumber" oninput="NumbersOnly(this)" required><br>
                </div>
                <div>
                    <h3>Receiver Details</h3>
                    <label for="receiverFirstName">First Name:</label>
                    <input type="text" id="receiverFirstName" name="receiverFirstName" oninput="LettersOnly(this)" required><br>
                    <label for="receiverMiddleName">Middle Name:</label>
                    <input type="text" id="receiverMiddleName" name="receiverMiddleName" oninput="LettersOnly(this)"><br>
                    <label for="receiverLastName">Last Name:</label>
                    <input type="text" id="receiverLastName" name="receiverLastName" oninput="LettersOnly(this)" required><br>
                    <label for="receiverNameSuffix">Name Suffix:</label>
                    <select id="receiverNameSuffix" name="receiverNameSuffix">
                        <option value="">None</option>
                        <option value="Sr.">Sr.</option>
                        <option value="Jr.">Jr.</option>
                        <option value="III">III</option>
                        <option value="IV">IV</option>
                        <option value="V">V</option>
                        <option value="VI">VI</option>
                        <option value="VII">VII</option>
                        <option value="VIII">VIII</option>
                        <option value="IX">IX</option>
                        <option value="X">X</option>
                    </select><br>
                    <label for="receiverContactNumber">Contact Number:</label>
                    <input type="text" id="receiverContactNumber" name="receiverContactNumber" oninput="NumbersOnly(this)" required><br>
                </div>
            </div>
            <div>
                <h3>Amount Money</h3>
                <label for="amount">Amount Money:</label>
                <input type="text" id="amount" name="amount" oninput="NumbersOnly(this)" required><br><br>
                <button type="submit">Submit</button>
            </div>
        </form><br>
        <form action="index.jsp">
            <input type="submit" value="Cancel">
        </form>
    </body>
</html>