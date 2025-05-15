<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Inquiries - Driving School Admin</title>
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
        
        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-new {
            background-color: #e3f2fd;
            color: #0d47a1;
        }
        
        .status-replied {
            background-color: #e8f5e9;
            color: #1b5e20;
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
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 5px;
        }
        
        .pagination a {
            padding: 8px 12px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            text-decoration: none;
            color: #2c3e50;
            transition: background-color 0.3s;
        }
        
        .pagination a:hover, .pagination a.active {
            background-color: #2c3e50;
            color: white;
            border-color: #2c3e50;
        }
        
        .truncate {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 200px;
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
    <header>
        <h1>Manage Inquiries</h1>
        <div class="header-actions">
            <a href="Home%20page/AdminDash.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
        %>
        
        <div class="card">
            <div class="card-header">
                <h2>All Inquiries</h2>
            </div>
            <div class="card-body">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search inquiries...">
                    <button onclick="searchInquiries()"><i class="fas fa-search"></i> Search</button>
                </div>
                
                <% 
                    List<String[]> inquiries = (List<String[]>) request.getAttribute("inquiries");
                    
                    if (inquiries != null && !inquiries.isEmpty()) {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (String[] inquiry : inquiries) {
                                String id = inquiry[0];
                                String timestamp = inquiry[0];
                                String email = inquiry[1];
                                String name = inquiry[2];
                                String phone = inquiry[3];
                                String subject = inquiry[4];
                                String message = inquiry[5];
                                
                                // Format the timestamp
                                try {
                                    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
                                    LocalDateTime dateTime = LocalDateTime.parse(timestamp, inputFormatter);
                                    timestamp = dateTime.format(outputFormatter);
                                } catch (Exception e) {
                                    // Keep original if parsing fails
                                }
                                
                                // Check if there's a reply
                                boolean hasReply = false;
                                try {
                                    java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.FileReader("src\\main\\java\\com\\auth\\inquiry_replies.txt"));
                                    String line;
                                    while ((line = reader.readLine()) != null) {
                                        String[] parts = line.split(",");
                                        if (parts.length >= 3 && parts[0].equals(id)) {
                                            hasReply = true;
                                            break;
                                        }
                                    }
                                    reader.close();
                                } catch (Exception e) {
                                    // File might not exist yet
                                }
                        %>
                        <tr>
                            <td><%= timestamp %></td>
                            <td><%= name %></td>
                            <td><%= email %></td>
                            <td><%= subject %></td>
                            <td class="truncate"><%= message.replace(";;", ",") %></td>
                            <td>
                                <% if (hasReply) { %>
                                    <span class="status-badge status-replied">Replied</span>
                                <% } else { %>
                                    <span class="status-badge status-new">New</span>
                                <% } %>
                            </td>
                            <td class="actions">
                                <a href="inquiry-management?action=view&id=<%= id %>" class="btn btn-view"><i class="fas fa-eye"></i></a>
                                <a href="#" onclick="confirmDelete('<%= id %>')" class="btn btn-delete"><i class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <div class="pagination">
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">&raquo;</a>
                </div>
                <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <p>No inquiries found</p>
                </div>
                <% } %>
            </div>
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
                <p>Are you sure you want to delete this inquiry? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button onclick="closeDeleteModal()" class="btn btn-view">Cancel</button>
                <a id="confirmDeleteBtn" href="#" class="btn btn-delete">Delete</a>
            </div>
        </div>
    </div>
    
    <script>
        // Search functionality
        function searchInquiries() {
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
        
        // Delete confirmation
        function confirmDelete(id) {
            const modal = document.getElementById('deleteModal');
            const confirmBtn = document.getElementById('confirmDeleteBtn');
            
            modal.style.display = 'flex';
            confirmBtn.href = 'inquiry-management?action=delete&id=' + id;
        }
        
        function closeDeleteModal() {
            const modal = document.getElementById('deleteModal');
            modal.style.display = 'none';
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
