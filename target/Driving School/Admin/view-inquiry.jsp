<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Inquiry - Driving School Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            font-size: 24px;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .header-actions a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 4px;
            background-color: rgba(255, 255, 255, 0.1);
            transition: background-color 0.3s;
        }

        .header-actions a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .card-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h2 {
            font-size: 18px;
            color: #2c3e50;
        }

        .card-body {
            padding: 20px;
        }

        .inquiry-details {
            margin-bottom: 30px;
        }

        .inquiry-details .row {
            display: flex;
            margin-bottom: 15px;
        }

        .inquiry-details .label {
            width: 120px;
            font-weight: 600;
            color: #2c3e50;
        }

        .inquiry-details .value {
            flex: 1;
        }

        .inquiry-message {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            white-space: pre-line;
        }

        .reply-section {
            margin-top: 30px;
        }

        .reply-section h3 {
            font-size: 16px;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .reply-box {
            background-color: #f0f7ff;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .reply-box .reply-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
            color: #4a6f8a;
        }

        .reply-box .reply-content {
            white-space: pre-line;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #2c3e50;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
            display: inline-block;
        }

        .btn-primary {
            background-color: #2c3e50;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1a252f;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .tab-container {
            margin-bottom: 20px;
        }

        .tabs {
            display: flex;
            border-bottom: 1px solid #dee2e6;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border: 1px solid transparent;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            margin-bottom: -1px;
            transition: all 0.3s;
        }

        .tab.active {
            border-color: #dee2e6 #dee2e6 #fff;
            background-color: #fff;
            color: #2c3e50;
            font-weight: 600;
        }

        .tab-content {
            display: none;
            padding: 20px 0;
        }

        .tab-content.active {
            display: block;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 10px;
        }

        .status-new {
            background-color: #e3f2fd;
            color: #0d47a1;
        }

        .status-replied {
            background-color: #e8f5e9;
            color: #1b5e20;
        }

        .flag-checkbox {
            margin-top: 20px;
        }

        .flag-checkbox input {
            margin-right: 5px;
        }

        .flag-checkbox label {
            color: #dc3545;
            font-weight: 600;
        }

        .flagged {
            color: #dc3545 !important;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <header>
        <h1>View Inquiry</h1>
        <div class="header-actions">
            <a href="inquiry-management"><i class="fas fa-arrow-left"></i> Back to Inquiries</a>
            <a href="../Home%20page/AdminDash.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="../logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </header>

    <div class="container">
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");

            if (success != null && !success.isEmpty()) {
        %>
            <div class="alert alert-success">
                <%= success %>
            </div>
        <%
            }

            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <%
            }

            String[] inquiry = (String[]) request.getAttribute("inquiry");
            String[] reply = (String[]) request.getAttribute("reply");

            if (inquiry != null) {
                String id = inquiry[0];
                String timestamp = inquiry[0];
                String email = inquiry[1];
                String name = inquiry[2];
                String phone = inquiry[3];
                String subject = inquiry[4];
                String message = inquiry[5].replace(";;", ",");

                // Format the timestamp
                try {
                    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
                    LocalDateTime dateTime = LocalDateTime.parse(timestamp, inputFormatter);
                    timestamp = dateTime.format(outputFormatter);
                } catch (Exception e) {
                    // Keep original if parsing fails
                }

                boolean hasReply = (reply != null);
                String replyTimestamp = "";
                String replyText = "";

                if (hasReply) {
                    replyTimestamp = reply[1];
                    replyText = reply[2].replace(";;", ",");

                    // Format the reply timestamp
                    try {
                        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
                        LocalDateTime dateTime = LocalDateTime.parse(replyTimestamp, inputFormatter);
                        replyTimestamp = dateTime.format(outputFormatter);
                    } catch (Exception e) {
                        // Keep original if parsing fails
                    }
                }
        %>
        <div class="card">
            <div class="card-header">
                <h2>
                    Inquiry Details
                    <% if (hasReply) { %>
                        <span class="status-badge status-replied">Replied</span>
                    <% } else { %>
                        <span class="status-badge status-new">New</span>
                    <% } %>
                </h2>
            </div>
            <div class="card-body">
                <div class="tab-container">
                    <div class="tabs">
                        <div class="tab active" onclick="openTab(event, 'view-tab')">View</div>
                        <div class="tab" onclick="openTab(event, 'edit-tab')">Edit</div>
                        <div class="tab" onclick="openTab(event, 'reply-tab')">Reply</div>
                    </div>

                    <!-- View Tab -->
                    <div id="view-tab" class="tab-content active">
                        <div class="inquiry-details">
                            <div class="row">
                                <div class="label">Date:</div>
                                <div class="value"><%= timestamp %></div>
                            </div>
                            <div class="row">
                                <div class="label">Name:</div>
                                <div class="value"><%= name %></div>
                            </div>
                            <div class="row">
                                <div class="label">Email:</div>
                                <div class="value"><%= email %></div>
                            </div>
                            <div class="row">
                                <div class="label">Phone:</div>
                                <div class="value"><%= phone %></div>
                            </div>
                            <div class="row">
                                <div class="label">Subject:</div>
                                <div class="value"><%= subject %></div>
                            </div>
                            <div class="row">
                                <div class="label">Message:</div>
                                <div class="value">
                                    <div class="inquiry-message"><%= message %></div>
                                </div>
                            </div>
                        </div>

                        <% if (hasReply) { %>
                        <div class="reply-section">
                            <h3>Your Reply</h3>
                            <div class="reply-box">
                                <div class="reply-header">
                                    <span>Replied on: <%= replyTimestamp %></span>
                                </div>
                                <div class="reply-content"><%= replyText %></div>
                            </div>
                        </div>
                        <% } %>

                        <div class="actions">
                            <a href="inquiry-management" class="btn btn-secondary">Back to List</a>
                            <a href="#" onclick="confirmDelete('<%= id %>')" class="btn btn-danger">Delete Inquiry</a>
                        </div>
                    </div>

                    <!-- Edit Tab -->
                    <div id="edit-tab" class="tab-content">
                        <form action="${pageContext.request.contextPath}/inquiry-management" method="post">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%= id %>">

                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" id="name" name="name" value="<%= name %>" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="<%= email %>" required>
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text" id="phone" name="phone" value="<%= phone %>">
                            </div>

                            <div class="form-group">
                                <label for="subject">Subject</label>
                                <input type="text" id="subject" name="subject" value="<%= subject %>">
                            </div>

                            <div class="form-group">
                                <label for="message">Message</label>
                                <textarea id="message" name="message" required><%= message %></textarea>
                            </div>

                            <div class="flag-checkbox">
                                <input type="checkbox" id="flag" name="flag" value="1">
                                <label for="flag">Flag this inquiry as important</label>
                            </div>

                            <div class="actions">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                <a href="#" onclick="openTab(event, 'view-tab')" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>

                    <!-- Reply Tab -->
                    <div id="reply-tab" class="tab-content">
                        <form action="${pageContext.request.contextPath}/inquiry-management" method="post">
                            <input type="hidden" name="action" value="reply">
                            <input type="hidden" name="id" value="<%= id %>">

                            <div class="inquiry-details">
                                <div class="row">
                                    <div class="label">From:</div>
                                    <div class="value"><%= name %> (<%= email %>)</div>
                                </div>
                                <div class="row">
                                    <div class="label">Subject:</div>
                                    <div class="value"><%= subject %></div>
                                </div>
                                <div class="row">
                                    <div class="label">Message:</div>
                                    <div class="value">
                                        <div class="inquiry-message"><%= message %></div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="reply">Your Reply</label>
                                <textarea id="reply" name="reply" required><%= hasReply ? replyText : "" %></textarea>
                            </div>

                            <div class="actions">
                                <button type="submit" class="btn btn-primary">Send Reply</button>
                                <a href="#" onclick="openTab(event, 'view-tab')" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } else { %>
        <div class="card">
            <div class="card-body">
                <p>Inquiry not found. It may have been deleted.</p>
                <div class="actions">
                    <a href="inquiry-management" class="btn btn-secondary">Back to List</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <script>
        function openTab(evt, tabName) {
            // Hide all tab content
            const tabContents = document.getElementsByClassName("tab-content");
            for (let i = 0; i < tabContents.length; i++) {
                tabContents[i].classList.remove("active");
            }

            // Remove active class from all tabs
            const tabs = document.getElementsByClassName("tab");
            for (let i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove("active");
            }

            // Show the selected tab content and add active class to the button
            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");
        }

        function confirmDelete(id) {
            if (confirm("Are you sure you want to delete this inquiry? This action cannot be undone.")) {
                window.location.href = "${pageContext.request.contextPath}/inquiry-management?action=delete&id=" + id;
            }
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.display = 'none';
            });
        }, 5000);
    </script>
</body>
</html>
