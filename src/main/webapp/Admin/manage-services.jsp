<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Services - Driving School Admin</title>
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
            max-width: 600px;
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
        
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .category-badge {
            display: inline-block;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .category-lessons {
            background-color: #e3f2fd;
            color: #0d47a1;
        }
        
        .category-courses {
            background-color: #e8f5e9;
            color: #1b5e20;
        }
        
        .category-special {
            background-color: #fff3e0;
            color: #e65100;
        }
        
        .price-column {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .duration-column {
            color: #6c757d;
            font-size: 13px;
        }
        
        .description-column {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>
    <header>
        <h1>Manage Services</h1>
        <div class="header-actions">
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
        %>
        
        <div class="card">
            <div class="card-header">
                <h2>All Services</h2>
                <button class="btn btn-add" onclick="openAddModal()"><i class="fas fa-plus"></i> Add Service</button>
            </div>
            <div class="card-body">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search services...">
                    <button onclick="searchServices()"><i class="fas fa-search"></i> Search</button>
                </div>
                
                <% 
                    List<String[]> services = (List<String[]>) request.getAttribute("services");
                    
                    if (services != null && !services.isEmpty()) {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Duration</th>
                            <th>Category</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (String[] service : services) {
                                String id = service[0];
                                String name = service[1];
                                String description = service[2];
                                String price = service[3];
                                String duration = service[4];
                                String category = service[5];
                                
                                String categoryClass = "";
                                if (category.equalsIgnoreCase("Lessons")) {
                                    categoryClass = "category-lessons";
                                } else if (category.equalsIgnoreCase("Courses")) {
                                    categoryClass = "category-courses";
                                } else {
                                    categoryClass = "category-special";
                                }
                        %>
                        <tr>
                            <td><%= name %></td>
                            <td class="description-column" title="<%= description %>"><%= description %></td>
                            <td class="price-column">$<%= price %></td>
                            <td class="duration-column"><%= duration %> min</td>
                            <td><span class="category-badge <%= categoryClass %>"><%= category %></span></td>
                            <td class="actions">
                                <button class="btn btn-edit" onclick="openEditModal('<%= id %>', '<%= name %>', '<%= description %>', '<%= price %>', '<%= duration %>', '<%= category %>')"><i class="fas fa-edit"></i></button>
                                <button class="btn btn-delete" onclick="confirmDelete('<%= id %>')"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-concierge-bell"></i>
                    <p>No services found</p>
                    <button class="btn btn-add" onclick="openAddModal()"><i class="fas fa-plus"></i> Add Your First Service</button>
                </div>
                <% } %>
            </div>
        </div>
    </div>
    
    <!-- Add Service Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Add New Service</h3>
                <span class="modal-close" onclick="closeAddModal()">&times;</span>
            </div>
            <form action="../service-management" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addName">Service Name</label>
                        <input type="text" id="addName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="addDescription">Description</label>
                        <textarea id="addDescription" name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="addPrice">Price ($)</label>
                        <input type="number" id="addPrice" name="price" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="addDuration">Duration (minutes)</label>
                        <input type="number" id="addDuration" name="duration" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="addCategory">Category</label>
                        <select id="addCategory" name="category" required>
                            <option value="Lessons">Lessons</option>
                            <option value="Courses">Courses</option>
                            <option value="Special">Special</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-view" onclick="closeAddModal()">Cancel</button>
                    <button type="submit" class="btn btn-add">Add Service</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Edit Service Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Edit Service</h3>
                <span class="modal-close" onclick="closeEditModal()">&times;</span>
            </div>
            <form action="../service-management" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" id="editId" name="id">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editName">Service Name</label>
                        <input type="text" id="editName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description</label>
                        <textarea id="editDescription" name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Price ($)</label>
                        <input type="number" id="editPrice" name="price" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="editDuration">Duration (minutes)</label>
                        <input type="number" id="editDuration" name="duration" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="editCategory">Category</label>
                        <select id="editCategory" name="category" required>
                            <option value="Lessons">Lessons</option>
                            <option value="Courses">Courses</option>
                            <option value="Special">Special</option>
                        </select>
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
                <p>Are you sure you want to delete this service? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button onclick="closeDeleteModal()" class="btn btn-view">Cancel</button>
                <a id="confirmDeleteBtn" href="#" class="btn btn-delete">Delete</a>
            </div>
        </div>
    </div>
    
    <script>
        // Search functionality
        function searchServices() {
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
        
        // Add Service Modal
        function openAddModal() {
            document.getElementById('addModal').style.display = 'flex';
        }
        
        function closeAddModal() {
            document.getElementById('addModal').style.display = 'none';
        }
        
        // Edit Service Modal
        function openEditModal(id, name, description, price, duration, category) {
            document.getElementById('editId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editDescription').value = description;
            document.getElementById('editPrice').value = price;
            document.getElementById('editDuration').value = duration;
            document.getElementById('editCategory').value = category;
            document.getElementById('editModal').style.display = 'flex';
        }
        
        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }
        
        // Delete Confirmation
        function confirmDelete(id) {
            const modal = document.getElementById('deleteModal');
            const confirmBtn = document.getElementById('confirmDeleteBtn');
            
            modal.style.display = 'flex';
            confirmBtn.href = '../service-management?action=delete&id=' + encodeURIComponent(id);
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
