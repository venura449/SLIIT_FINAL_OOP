<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Driving School</title>
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
            max-width: 800px;
            margin: 40px auto;
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

        .profile-section {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-avatar {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #2c3e50;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: 600;
        }

        .profile-info {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 15px;
        }

        .profile-info .label {
            font-weight: 600;
            color: #2c3e50;
        }

        .profile-info .value {
            color: #333;
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

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #2c3e50;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
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

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .modal-header {
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 18px;
            color: #2c3e50;
        }

        .modal-close {
            font-size: 24px;
            cursor: pointer;
            color: #6c757d;
            transition: color 0.3s;
        }

        .modal-close:hover {
            color: #343a40;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #e9ecef;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
    </style>
</head>
<body>
    <%!
        // File path for users.txt
        private static final String USERS_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\users.txt";

        // Get user by email
        private String[] getUserByEmail(String email) {
            try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3 && parts[1].equalsIgnoreCase(email)) {
                        return parts;
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }

        // Update user profile
        private boolean updateUserProfile(String originalEmail, String name, String email, String password) {
            List<String> updatedUsers = new ArrayList<>();
            boolean found = false;

            try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3 && parts[1].equalsIgnoreCase(originalEmail)) {
                        // Update the user
                        String updatedUser = name + "," + email + ",";

                        // If password is provided, update it; otherwise, keep the old one
                        if (password != null && !password.trim().isEmpty()) {
                            updatedUser += password;
                        } else {
                            updatedUser += parts[2];
                        }

                        updatedUsers.add(updatedUser);
                        found = true;
                    } else {
                        updatedUsers.add(line);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }

            if (!found) {
                return false;
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE))) {
                for (String user : updatedUsers) {
                    writer.write(user);
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }

            return true;
        }

        // Delete user account
        private boolean deleteUserAccount(String email) {
            List<String> updatedUsers = new ArrayList<>();
            boolean found = false;

            try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3 && parts[1].equalsIgnoreCase(email)) {
                        found = true;
                        continue; // Skip this line (delete it)
                    }
                    updatedUsers.add(line);
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }

            if (!found) {
                return false;
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE))) {
                for (String user : updatedUsers) {
                    writer.write(user);
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }

            return true;
        }

        // Get initials from name
        private String getInitials(String name) {
            if (name == null || name.isEmpty()) {
                return "?";
            }

            String[] parts = name.split(" ");
            StringBuilder initials = new StringBuilder();

            for (String part : parts) {
                if (!part.isEmpty()) {
                    initials.append(part.charAt(0));
                    if (initials.length() >= 2) {
                        break;
                    }
                }
            }

            return initials.toString().toUpperCase();
        }
    %>

    <%
        // Check if user is logged in
        String userEmail = (String) session.getAttribute("user");
        if (userEmail == null) {
            response.sendRedirect("Login/login.jsp?error=Please log in to view your profile");
            return;
        }

        // Get user data
        String[] userData = getUserByEmail(userEmail);
        if (userData == null) {
            response.sendRedirect("Login/login.jsp?error=User not found");
            return;
        }

        String userName = userData[0];
        String userPassword = userData[2];
        boolean isAdmin = userEmail.endsWith("@admin.com");

        // Process form submissions
        String action = request.getParameter("action");
        String message = null;
        boolean isError = false;

        if ("update".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (name != null && email != null) {
                boolean success = updateUserProfile(userEmail, name, email, password);
                if (success) {
                    // Update session with new email if changed
                    if (!email.equals(userEmail)) {
                        session.setAttribute("user", email);
                        userEmail = email;
                    }

                    // Refresh user data
                    userData = getUserByEmail(userEmail);
                    userName = userData[0];
                    userPassword = userData[2];
                    isAdmin = userEmail.endsWith("@admin.com");

                    message = "Profile updated successfully";
                } else {
                    message = "Failed to update profile";
                    isError = true;
                }
            }
        } else if ("delete".equals(action)) {
            String confirmEmail = request.getParameter("confirmEmail");

            if (confirmEmail != null && confirmEmail.equals(userEmail)) {
                boolean success = deleteUserAccount(userEmail);
                if (success) {
                    // Invalidate session and redirect to login
                    session.invalidate();
                    response.sendRedirect("Login/login.jsp?success=Account deleted successfully");
                    return;
                } else {
                    message = "Failed to delete account";
                    isError = true;
                }
            } else {
                message = "Email confirmation does not match";
                isError = true;
            }
        }
    %>

    <header>
        <h1>My Profile</h1>
        <div class="header-actions">
            <a href="Home page/homepage.jsp"><i class="fas fa-home"></i> Home</a>
            <% if (isAdmin) { %>
                <a href="Home page/AdminDash.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <% } %>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </header>

    <div class="container">
        <% if (message != null) { %>
            <div class="alert <%= isError ? "alert-error" : "alert-success" %>">
                <%= message %>
            </div>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h2>Profile Information</h2>
            </div>
            <div class="card-body">
                <div class="tab-container">
                    <div class="tabs">
                        <div class="tab active" onclick="openTab(event, 'profile-tab')">View Profile</div>
                        <div class="tab" onclick="openTab(event, 'edit-tab')">Edit Profile</div>
                        <div class="tab" onclick="openTab(event, 'security-tab')">Security</div>
                    </div>

                    <!-- Profile Tab -->
                    <div id="profile-tab" class="tab-content active">
                        <div class="profile-section">
                            <div class="profile-avatar">
                                <div class="avatar" style="background-color: <%= isAdmin ? "#0d47a1" : "#2c3e50" %>;">
                                    <%= getInitials(userName) %>
                                </div>
                            </div>

                            <div class="profile-info">
                                <div class="label">Name:</div>
                                <div class="value"><%= userName %></div>

                                <div class="label">Email:</div>
                                <div class="value"><%= userEmail %></div>

                                <div class="label">Account Type:</div>
                                <div class="value"><%= isAdmin ? "Administrator" : "User" %></div>
                            </div>
                        </div>
                    </div>

                    <!-- Edit Profile Tab -->
                    <div id="edit-tab" class="tab-content">
                        <form action="user-profile.jsp" method="post">
                            <input type="hidden" name="action" value="update">

                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" id="name" name="name" value="<%= userName %>" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="<%= userEmail %>" required>
                            </div>

                            <div class="form-group">
                                <label for="password">Password (leave blank to keep current)</label>
                                <input type="password" id="password" name="password">
                            </div>

                            <div class="actions">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>

                    <!-- Security Tab -->
                    <div id="security-tab" class="tab-content">
                        <h3 style="margin-bottom: 20px; color: #2c3e50;">Delete Account</h3>
                        <p style="margin-bottom: 20px; color: #6c757d;">
                            Warning: This action cannot be undone. All your data will be permanently deleted.
                        </p>

                        <button onclick="openDeleteModal()" class="btn btn-danger">Delete My Account</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Account Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Confirm Account Deletion</h3>
                <span class="modal-close" onclick="closeDeleteModal()">&times;</span>
            </div>
            <form action="user-profile.jsp" method="post">
                <input type="hidden" name="action" value="delete">
                <div class="modal-body">
                    <p style="margin-bottom: 20px; color: #721c24;">
                        <strong>Warning:</strong> This action cannot be undone. All your data will be permanently deleted.
                    </p>
                    <div class="form-group">
                        <label for="confirmEmail">Please enter your email to confirm deletion</label>
                        <input type="email" id="confirmEmail" name="confirmEmail" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="closeDeleteModal()">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete Account</button>
                </div>
            </form>
        </div>
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

        function openDeleteModal() {
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target == modal) {
                modal.style.display = 'none';
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
