<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Driving School Admin</title>
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
            max-width: 1200px;
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

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
        }

        .btn-view {
            background-color: #e3f2fd;
            color: #0d47a1;
        }

        .btn-view:hover {
            background-color: #bbdefb;
        }

        .btn-edit {
            background-color: #fff3e0;
            color: #e65100;
        }

        .btn-edit:hover {
            background-color: #ffe0b2;
        }

        .btn-delete {
            background-color: #ffebee;
            color: #b71c1c;
        }

        .btn-delete:hover {
            background-color: #ffcdd2;
        }

        .btn-add {
            background-color: #e8f5e9;
            color: #1b5e20;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-add:hover {
            background-color: #c8e6c9;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #adb5bd;
        }

        .empty-state p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        .search-box {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-box input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-box button {
            padding: 10px 15px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-box button:hover {
            background-color: #1a252f;
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
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }

        .admin-badge {
            display: inline-block;
            padding: 2px 6px;
            background-color: #e3f2fd;
            color: #0d47a1;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <%!
        // File path for users.txt
        private static final String USERS_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\users.txt";

        // Get all users from the file
        private List<String[]> getAllUsers() {
            List<String[]> users = new ArrayList<>();

            try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3) {
                        users.add(parts);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            return users;
        }

        // Delete a user by email
        private boolean deleteUser(String email) {
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

        // Update a user
        private boolean updateUser(String originalEmail, String name, String email, String password) {
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

        // Add a new user
        private boolean addUser(String name, String email, String password) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE, true))) {
                String newUser = name + "," + email + "," + password;
                writer.write(newUser);
                writer.newLine();
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }

            return true;
        }
    %>

    <%
        // Check for password authentication
        String password = "123"; // Set the password
        String enteredPassword = request.getParameter("adminPassword");
        boolean isAuthenticated = false;

        // Check if password is stored in session
        Boolean sessionAuth = (Boolean) session.getAttribute("userManagementAuthenticated");
        if (sessionAuth != null && sessionAuth) {
            isAuthenticated = true;
        }

        // Check if password was just submitted
        if (enteredPassword != null && enteredPassword.equals(password)) {
            isAuthenticated = true;
            session.setAttribute("userManagementAuthenticated", true);
        }

        // Process form submissions
        String action = request.getParameter("action");
        String message = null;
        boolean isError = false;

        if ("delete".equals(action)) {
            String email = request.getParameter("email");
            if (email != null && !email.isEmpty()) {
                boolean success = deleteUser(email);
                if (success) {
                    message = "User deleted successfully";
                } else {
                    message = "Failed to delete user";
                    isError = true;
                }
            }
        } else if ("edit".equals(action)) {
            String originalEmail = request.getParameter("originalEmail");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (originalEmail != null && name != null && email != null) {
                boolean success = updateUser(originalEmail, name, email, password);
                if (success) {
                    message = "User updated successfully";
                } else {
                    message = "Failed to update user";
                    isError = true;
                }
            }
        } else if ("add".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (name != null && email != null && password != null) {
                boolean success = addUser(name, email, password);
                if (success) {
                    message = "User added successfully";
                } else {
                    message = "Failed to add user";
                    isError = true;
                }
            }
        }

        // Get all users
        List<String[]> users = getAllUsers();
    %>

    <header>
        <h1>Manage Users</h1>
        <div class="header-actions">
            <a href="Home page/AdminDash.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </header>

    <div class="container">
        <% if (message != null) { %>
            <div class="alert <%= isError ? "alert-error" : "alert-success" %>">
                <%= message %>
            </div>
        <% } %>

        <% if (!isAuthenticated) { %>
            <!-- Password Authentication Form -->
            <div class="card">
                <div class="card-header">
                    <h2>Authentication Required</h2>
                </div>
                <div class="card-body">
                    <form action="direct-user-management.jsp" method="post" style="max-width: 400px; margin: 0 auto;">
                        <div class="form-group">
                            <label for="adminPassword">Enter Admin Password</label>
                            <input type="password" id="adminPassword" name="adminPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="background-color: #2c3e50; color: white; width: 100%; margin-top: 10px;">Access User Management</button>
                    </form>
                </div>
            </div>
        <% } else { %>
            <!-- User Management Content (only shown after authentication) -->
            <div style="text-align: right; margin-bottom: 10px;">
                <a href="admin-logout.jsp" class="btn" style="background-color: #ffebee; color: #b71c1c;">
                    <i class="fas fa-lock"></i> Logout from Protected Area
                </a>
            </div>
            <div class="card">
                <div class="card-header">
                    <h2>All Users</h2>
                    <button class="btn btn-add" onclick="openAddModal()"><i class="fas fa-plus"></i> Add User</button>
                </div>
                <div class="card-body">
                    <div class="search-box">
                        <input type="text" id="searchInput" placeholder="Search users...">
                        <button onclick="searchUsers()"><i class="fas fa-search"></i> Search</button>
                    </div>

                <% if (users != null && !users.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (String[] user : users) {
                            String name = user[0];
                            String email = user[1];
                            boolean isAdmin = email.endsWith("@admin.com");
                        %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= email %></td>
                            <td>
                                <% if (isAdmin) { %>
                                    <span class="admin-badge">Admin</span>
                                <% } else { %>
                                    User
                                <% } %>
                            </td>
                            <td class="actions">
                                <button class="btn btn-edit" onclick="openEditModal('<%= name %>', '<%= email %>')"><i class="fas fa-edit"></i></button>
                                <button class="btn btn-delete" onclick="confirmDelete('<%= email %>')"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-users"></i>
                    <p>No users found</p>
                </div>
                <% } %>
                </div>
            </div>
        <% } %>
    </div>

    <!-- Add User Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Add New User</h3>
                <span class="modal-close" onclick="closeAddModal()">&times;</span>
            </div>
            <form action="direct-user-management.jsp" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addName">Name</label>
                        <input type="text" id="addName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="addEmail">Email</label>
                        <input type="email" id="addEmail" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="addPassword">Password</label>
                        <input type="password" id="addPassword" name="password" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-view" onclick="closeAddModal()">Cancel</button>
                    <button type="submit" class="btn btn-add">Add User</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Edit User</h3>
                <span class="modal-close" onclick="closeEditModal()">&times;</span>
            </div>
            <form action="direct-user-management.jsp" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" id="originalEmail" name="originalEmail">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editName">Name</label>
                        <input type="text" id="editName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email</label>
                        <input type="email" id="editEmail" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="editPassword">Password (leave blank to keep current)</label>
                        <input type="password" id="editPassword" name="password">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-view" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="btn btn-edit">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Confirm Delete</h3>
                <span class="modal-close" onclick="closeDeleteModal()">&times;</span>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this user? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button onclick="closeDeleteModal()" class="btn btn-view">Cancel</button>
                <a id="confirmDeleteBtn" href="#" class="btn btn-delete">Delete</a>
            </div>
        </div>
    </div>

    <script>
        // Search functionality
        function searchUsers() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toUpperCase();
            const table = document.querySelector('table');
            const tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                let found = false;
                const td = tr[i].getElementsByTagName('td');

                for (let j = 0; j < td.length - 1; j++) { // Skip the actions column
                    const cell = td[j];
                    if (cell) {
                        const txtValue = cell.textContent || cell.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }

                tr[i].style.display = found ? '' : 'none';
            }
        }

        // Add User Modal
        function openAddModal() {
            document.getElementById('addModal').style.display = 'flex';
        }

        function closeAddModal() {
            document.getElementById('addModal').style.display = 'none';
        }

        // Edit User Modal
        function openEditModal(name, email) {
            document.getElementById('editName').value = name;
            document.getElementById('editEmail').value = email;
            document.getElementById('originalEmail').value = email;
            document.getElementById('editPassword').value = '';
            document.getElementById('editModal').style.display = 'flex';
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // Delete Confirmation
        function confirmDelete(email) {
            const modal = document.getElementById('deleteModal');
            const confirmBtn = document.getElementById('confirmDeleteBtn');

            modal.style.display = 'flex';
            confirmBtn.href = 'direct-user-management.jsp?action=delete&email=' + encodeURIComponent(email);
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modals when clicking outside
        window.onclick = function(event) {
            const addModal = document.getElementById('addModal');
            const editModal = document.getElementById('editModal');
            const deleteModal = document.getElementById('deleteModal');

            if (event.target == addModal) {
                addModal.style.display = 'none';
            } else if (event.target == editModal) {
                editModal.style.display = 'none';
            } else if (event.target == deleteModal) {
                deleteModal.style.display = 'none';
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
