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
                    Float serviceFee = Float.parseFloat(request.getParameter("serviceFee"));
                    String senderFirstName = request.getParameter("senderFirstName").trim();
                    senderFirstName = NameFormatter.formatName(senderFirstName);
                    String senderMiddleName = request.getParameter("senderMiddleName").trim();
                    senderMiddleName = NameFormatter.formatName(senderMiddleName);
                    String senderLastName = request.getParameter("senderLastName").trim();
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
                    String receiverFirstName = request.getParameter("receiverFirstName").trim();
                    receiverFirstName = NameFormatter.formatName(receiverFirstName);
                    String receiverMiddleName = request.getParameter("receiverMiddleName").trim();
                    receiverMiddleName = NameFormatter.formatName(receiverMiddleName);
                    String receiverLastName = request.getParameter("receiverLastName").trim();
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
                    Float amount = Float.parseFloat(request.getParameter("amount"));
                    try {
                        if (senderFirstName.isEmpty() || senderLastName.isEmpty() || receiverFirstName.isEmpty() || receiverLastName.isEmpty() || amount <= 0) {
                            out.println("Sorry, invalid input. Please try again.");
                        } else {
                            transaction_port.insertNewTransaction(serviceFee, senderName, senderContactNumber, receiverName, receiverContactNumber, amount);
                            out.println("Submission successful. You can come to any of our branches at any time to confirm and process your transaction.");
                        }
                    } catch (Exception error) {
                        error.printStackTrace();
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
                    <input type="text" id="senderContactNumber" name="senderContactNumber" oninput="NumbersOnly(this)" minlength="3" maxlength="15" required><br>
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
                    <input type="text" id="receiverContactNumber" name="receiverContactNumber" oninput="NumbersOnly(this)" minlength="3" maxlength="15" required><br>
                </div>
            </div>
            <div>
                <h3>Amount Money</h3>
                <label for="amount">Amount:</label>
                <input type="text" id="amount" name="amount" oninput="NumbersOnly(this); CalculateServiceFee();" maxlength="6" required><br>
                <label for="serviceFee">Service Fee:</label>
                <input type="text" id="serviceFee" name="serviceFee" readonly required><br><br>
                <button type="submit">Submit</button>
                <script>
                    function LettersOnly(inputField) {
                        var pattern = /^[A-Za-z]+( [A-Za-z]+)*$/;
                        var inputValue = inputField.value;
                        if (!pattern.test(inputValue)) {
                            inputField.value = inputValue.replace(/[^A-Za-z\s]/g, '').replace(/\s{2,}/g, ' ');
                        }
                    }
                    function NumbersOnly(inputField) {
                        var pattern = /^[0-9]+$/;
                        var inputValue = inputField.value;
                        if (!pattern.test(inputValue)) {
                            inputField.value = inputValue.replace(/[^0-9]/g, '');
                        }
                    }
                    function CalculateServiceFee() {
                        var amount = document.getElementById('amount').value;
                        var serviceFee = isNaN(amount) ? 0 : (parseFloat(amount) * 0.02).toFixed(2);
                        document.getElementById('serviceFee').value = serviceFee;
                    }
                </script>
            </div>
        </form><br>
        <form action="index.jsp">
            <input type="submit" value="Cancel">
        </form>
    </body>
</html>