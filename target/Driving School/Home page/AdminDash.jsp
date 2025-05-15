<%@ page import="java.util.Queue" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.auth.UserUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
        }

        /* Alert styles */
        .alert {
            padding: 12px 16px;
            border-radius: 4px;
            margin-bottom: 16px;
            display: none;
        }

        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-error {
            background-color: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        /* Avatar styles */
        .avatar {
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            font-weight: 600;
            font-size: 16px;
            color: white;
            text-transform: uppercase;
            user-select: none;
            transition: all 0.2s ease;
        }

        .avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        /* Different background colors based on first letter */
        .avatar-a, .avatar-f, .avatar-k, .avatar-p, .avatar-u, .avatar-z { background-color: #4f46e5; }
        .avatar-b, .avatar-g, .avatar-l, .avatar-q, .avatar-v { background-color: #0ea5e9; }
        .avatar-c, .avatar-h, .avatar-m, .avatar-r, .avatar-w { background-color: #10b981; }
        .avatar-d, .avatar-i, .avatar-n, .avatar-s, .avatar-x { background-color: #f59e0b; }
        .avatar-e, .avatar-j, .avatar-o, .avatar-t, .avatar-y { background-color: #ef4444; }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Enhanced Search Bar for Appointments Table
            const appointmentSearchInput = document.getElementById('appointmentSearch');
            const clearSearchButton = document.getElementById('clearSearch');
            const appointmentsTable = document.getElementById('appointmentsTable');
            const appointmentRows = appointmentsTable.getElementsByTagName('tr');

            // Show/hide clear button based on search input
            appointmentSearchInput.addEventListener('input', function() {
                clearSearchButton.style.display = this.value ? 'block' : 'none';
            });

            // Clear search when button is clicked
            clearSearchButton.addEventListener('click', function() {
                appointmentSearchInput.value = '';
                appointmentSearchInput.dispatchEvent(new Event('input'));
                this.style.display = 'none';
                appointmentSearchInput.focus();
            });

            // Function to highlight matching text in cells
            function highlightText(cell, query) {
                if (!query) return;

                const originalText = cell.textContent;
                const lowerText = originalText.toLowerCase();
                const index = lowerText.indexOf(query);

                if (index >= 0) {
                    const before = originalText.substring(0, index);
                    const match = originalText.substring(index, index + query.length);
                    const after = originalText.substring(index + query.length);

                    cell.innerHTML = before +
                        '<span class="bg-yellow-200 dark:bg-yellow-600 px-1 rounded">' +
                        match +
                        '</span>' +
                        after;
                    return true;
                }
                return false;
            }

            // Function to reset cell text (remove highlighting)
            function resetCellText(cell) {
                const originalText = cell.textContent;
                cell.innerHTML = originalText;
            }

            // Function to filter the rows based on the search query for appointments
            appointmentSearchInput.addEventListener('input', function() {
                const query = appointmentSearchInput.value.toLowerCase();
                let matchCount = 0;

                // Loop through all rows (excluding the header)
                for (let i = 1; i < appointmentRows.length; i++) {
                    const row = appointmentRows[i];
                    const cells = row.getElementsByTagName('td');
                    let rowMatches = false;

                    // Reset all cells first (remove previous highlighting)
                    for (let j = 0; j < cells.length; j++) {
                        resetCellText(cells[j]);
                    }

                    if (query) {
                        // Loop through cells that we want to search (skip status and actions)
                        for (let j = 0; j < cells.length - 2; j++) {
                            const cell = cells[j];
                            if (cell.textContent.toLowerCase().includes(query)) {
                                rowMatches = true;
                                highlightText(cell, query);
                            }
                        }
                    } else {
                        // If query is empty, show all rows
                        rowMatches = true;
                    }

                    // Show or hide the row based on whether it matches the search query
                    row.style.display = rowMatches ? '' : 'none';
                    if (rowMatches) matchCount++;
                }

                // Update the count in the stats card
                const appointmentCount = document.getElementById('appointmentCount');
                const totalAppointments = document.getElementById('totalAppointments').value;
                if (query) {
                    appointmentCount.innerHTML = `${matchCount} <span class="text-xs text-gray-500">of ${totalAppointments}</span>`;
                } else {
                    appointmentCount.innerHTML = totalAppointments;
                }
            });

            // Second Search Bar for another section (e.g., vehicles, students, etc.)
            const secondSearchContainer = document.querySelectorAll('.secondSearch input[type="search"]');
            const  secondSearchInput= document.querySelectorAll('.secondSearch .searchable-content');

            secondSearchInput.forEach(input => {
                input.addEventListener('input', function() {
                    const query = input.value.toLowerCase();

                    secondSearchContainer.forEach(content => {
                        let matchFound = false;
                        const items = content.getElementsByTagName('div'); // Assuming your content is in divs
                        for (let item of items) {
                            if (item.textContent.toLowerCase().includes(query)) {
                                matchFound = true;
                                break;
                            }
                        }
                        content.style.display = matchFound ? '' : 'none';
                    });
                });
            });

            // Check for URL parameters to show alerts
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('success')) {
                showAlert('success', urlParams.get('success'));
            }
            if (urlParams.has('error')) {
                showAlert('error', urlParams.get('error'));
            }

            // Profile dropdown toggle
            const profileButton = document.getElementById('profileButton');
            const profileDropdown = document.getElementById('profileDropdown');

            profileButton.addEventListener('click', function(e) {
                e.stopPropagation();
                profileDropdown.classList.toggle('hidden');
            });

            // Close dropdown when clicking outside
            document.addEventListener('click', function(e) {
                if (!profileButton.contains(e.target) && !profileDropdown.contains(e.target)) {
                    profileDropdown.classList.add('hidden');
                }
            });
        });

        // Function to open the edit modal
        function openEditModal(bookingId) {
            // Make an AJAX request to get booking details
            fetch('../admin-booking?action=getBooking&bookingId=' + bookingId)
                .then(response => response.json())
                .then(data => {
                    // Populate the form with booking details
                    document.getElementById('editBookingId').value = data.bookingId;
                    document.getElementById('editEmail').value = data.email;
                    document.getElementById('editName').value = data.name;
                    document.getElementById('editVehicle').value = data.vehicle;
                    document.getElementById('editInstructor').value = data.instructor;
                    document.getElementById('editDate').value = data.date;
                    document.getElementById('editTime').value = data.time;
                    document.getElementById('editFlagged').checked = data.flagged === "1";

                    // Show the modal
                    document.getElementById('editModal').style.display = 'block';
                })
                .catch(error => {
                    console.error('Error fetching booking details:', error);
                    // If AJAX fails, we can still open the modal and let the user fill in details
                    document.getElementById('editBookingId').value = bookingId;
                    document.getElementById('editModal').style.display = 'block';
                });
        }

        // Function to close the edit modal
        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // Function to toggle flag status
        function toggleFlag(bookingId) {
            if (confirm('Are you sure you want to toggle the flag status for this booking?')) {
                // Submit form to toggle flag
                document.getElementById('flagBookingId').value = bookingId;
                document.getElementById('flagForm').submit();
            }
        }

        // Function to confirm and delete a booking
        function confirmDelete(bookingId) {
            if (confirm('Are you sure you want to delete this booking? This action cannot be undone.')) {
                // Submit form to delete
                document.getElementById('deleteBookingId').value = bookingId;
                document.getElementById('deleteForm').submit();
            }
        }

        // Function to show alerts
        function showAlert(type, message) {
            const alertElement = document.getElementById('alert-' + type);
            alertElement.textContent = message;
            alertElement.style.display = 'block';

            // Hide the alert after 5 seconds
            setTimeout(() => {
                alertElement.style.display = 'none';
            }, 5000);
        }
    </script>

</head>

<%
    // Use the BookingSorter to get sorted bookings
    Queue<String[]> allBookings = UserUtils.getBookings("src\\main\\java\\com\\auth\\bookings.txt");

    // Debugging output to check data
    System.out.println("All bookings size: " + allBookings.size());
    if (allBookings.isEmpty()) {
        allBookings = new LinkedList<>();  // Fallback to empty queue if data is null or empty
        System.out.println("No bookings available");
    } else {
        // Print the first booking to check the data structure
        String[] firstBooking = allBookings.peek();  // Peek at the first item
        System.out.println("First booking data: " + Arrays.toString(firstBooking));
    }

    // Get the user's name from session and prepare avatar variables
    String username = (String) session.getAttribute("username");
    String avatarClass = "avatar-a"; // Default avatar class
    String initials = "AD"; // Default initials

    if (username != null && !username.isEmpty()) {
        // Set avatar class based on first letter
        avatarClass = "avatar-" + username.toLowerCase().charAt(0);

        // Extract initials (first letter of each word)
        String[] nameParts = username.split("\\s+");
        StringBuilder initialsBuilder = new StringBuilder();

        for (String part : nameParts) {
            if (!part.isEmpty()) {
                initialsBuilder.append(part.charAt(0));
                // Only use first two initials
                if (initialsBuilder.length() >= 2) break;
            }
        }

        String extractedInitials = initialsBuilder.toString().toUpperCase();

        // If we couldn't get 2 initials and name has at least 2 chars, use first 2 chars
        if (extractedInitials.length() < 2 && username.length() >= 2) {
            initials = username.substring(0, 2).toUpperCase();
        } else if (!extractedInitials.isEmpty()) {
            initials = extractedInitials;
        }
    }
%>

<body class="bg-gray-50 dark:bg-gray-900">
    <!-- Alert messages -->
    <div id="alert-success" class="alert alert-success"></div>
    <div id="alert-error" class="alert alert-error"></div>

    <!-- Hidden fields for JavaScript -->
    <input type="hidden" id="totalAppointments" value="<%= allBookings.size() %>">

    <!-- Hidden forms for actions -->
    <form id="deleteForm" action="../admin-booking" method="post" style="display:none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" id="deleteBookingId" name="bookingId" value="">
    </form>

    <form id="flagForm" action="../admin-booking" method="post" style="display:none;">
        <input type="hidden" name="action" value="flag">
        <input type="hidden" id="flagBookingId" name="bookingId" value="">
    </form>

    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2 class="text-xl font-bold mb-4">Edit Booking</h2>
            <form id="editForm" action="../admin-booking" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" id="editBookingId" name="bookingId" value="">

                <div class="grid grid-cols-2 gap-4">
                    <div class="mb-4">
                        <label for="editEmail" class="block text-sm font-medium text-gray-700">Email</label>
                        <input type="email" id="editEmail" name="email" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                    </div>

                    <div class="mb-4">
                        <label for="editName" class="block text-sm font-medium text-gray-700">Name</label>
                        <input type="text" id="editName" name="name" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                    </div>

                    <div class="mb-4">
                        <label for="editVehicle" class="block text-sm font-medium text-gray-700">Vehicle</label>
                        <select id="editVehicle" name="vehicle" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            <option value="Sedan">Sedan</option>
                            <option value="SUV">SUV</option>
                            <option value="Truck">Truck</option>
                            <option value="Motorcycle">Motorcycle</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label for="editInstructor" class="block text-sm font-medium text-gray-700">Instructor</label>
                        <select id="editInstructor" name="instructor" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                            <option value="John Doe">John Doe</option>
                            <option value="Jane Smith">Jane Smith</option>
                            <option value="Michael Brown">Michael Brown</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label for="editDate" class="block text-sm font-medium text-gray-700">Date</label>
                        <input type="date" id="editDate" name="date" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                    </div>

                    <div class="mb-4">
                        <label for="editTime" class="block text-sm font-medium text-gray-700">Time</label>
                        <input type="time" id="editTime" name="time" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="inline-flex items-center">
                        <input type="checkbox" id="editFlagged" name="flagged" class="rounded border-gray-300 text-blue-600 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                        <span class="ml-2 text-sm text-gray-700">Flag this booking</span>
                    </label>
                </div>

                <div class="flex justify-end">
                    <button type="button" onclick="closeEditModal()" class="mr-2 px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

<div class="flex min-h-screen">
    <!-- Sidebar -->
    <div class="w-64 bg-gray-800 text-white">
        <div class="border-b px-4 py-4">
            <div class="flex items-center mb-3">
                <i class="fas fa-car h-6 w-6 text-primary mr-2"></i>
                <span class="font-bold text-lg">DriveSchool</span>
            </div>
            <div class="flex items-center">
                <div class="avatar <%= avatarClass %> mr-3" style="width: 32px; height: 32px; font-size: 14px;">
                    <%= initials %>
                </div>
                <div class="overflow-hidden">
                    <div class="text-sm font-medium truncate"><%= username != null ? username : "Admin" %></div>
                    <div class="text-xs text-gray-400">Administrator</div>
                </div>
            </div>
        </div>
        <div class="p-4">
            <ul class="space-y-4">
                <li><a href="#" class="flex items-center text-sm py-2 px-4 rounded bg-gray-700"><i class="fas fa-tachometer-alt mr-2"></i> Dashboard</a></li>
                <li><a href="../inquiry-management" class="flex items-center text-sm py-2 px-4 rounded"><i class="fas fa-envelope mr-2"></i> Inquiries</a></li>
                <li><a href="../direct-user-management.jsp" class="flex items-center text-sm py-2 px-4 rounded"><i class="fas fa-user-cog mr-2"></i> Manage Users</a></li>
                <li><a href="../direct-service-management.jsp" class="flex items-center text-sm py-2 px-4 rounded"><i class="fas fa-concierge-bell mr-2"></i> Manage Services</a></li>
            </ul>
        </div>
        <div class="border-t p-4">
            <a href="../logout" class="block w-full py-2 px-4 rounded bg-gray-700 text-white text-sm text-center hover:bg-gray-600 transition-colors">
                <i class="fas fa-sign-out-alt mr-2 inline"></i>
                Log out
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="flex-1">
        <header class="sticky top-0 z-10 flex h-16 items-center justify-between gap-4 border-b bg-white px-4 dark:bg-gray-800">
            <div class="flex items-center">
                <h2 class="text-lg font-semibold text-gray-800 dark:text-white">Admin Dashboard</h2>
                <% if (username != null && !username.isEmpty()) { %>
                    <span class="ml-4 text-sm text-gray-600 dark:text-gray-300">Welcome, <span class="font-medium"><%= username %></span></span>
                <% } %>
            </div>
            <div class="flex items-center gap-4">
                <a href="../logout" class="flex items-center px-3 py-2 text-sm font-medium text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-300">
                    <i class="fas fa-sign-out-alt mr-2"></i>
                    Logout
                </a>
                <div class="relative">
                    <button id="profileButton" class="avatar <%= avatarClass %>">
                        <%= initials %>
                    </button>
                    <div id="profileDropdown" class="absolute right-0 mt-2 w-48 bg-white border border-gray-200 shadow-lg rounded-md dark:bg-gray-800 dark:border-gray-700 hidden">
                        <a href="#" class="block px-4 py-2 text-sm text-gray-900 dark:text-white hover:bg-gray-100">My Profile</a>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-900 dark:text-white hover:bg-gray-100">Settings</a>
                        <a href="../logout" class="block px-4 py-2 text-sm text-red-600 dark:text-red-400 hover:bg-gray-100">
                            <i class="fas fa-sign-out-alt mr-2"></i>Logout
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <main class="p-4 space-y-6">
            <div class="flex flex-col md:flex-row justify-between items-start">
                <div>
                    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Dashboard</h1>
                    <p class="text-gray-600 dark:text-gray-400">Welcome back, Admin! Here's an overview of your driving school.</p>
                </div>
                <button class="mt-4 md:mt-0 flex items-center bg-blue-500 text-white py-2 px-4 rounded">
                    <i class="fas fa-calendar-plus mr-2 h-4 w-4"></i> New Appointment
                </button>
            </div>

            <!-- Stats Cards -->
            <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                <div class="bg-white border p-4 rounded-md">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-medium text-gray-900">Total Appointments</span>
                        <i class="fas fa-calendar-alt h-4 w-4 text-gray-500"></i>
                    </div>
                    <div class="mt-2 text-2xl font-bold text-gray-900" id="appointmentCount"><%= allBookings.size() %></div>
                    <p class="text-xs text-gray-500">+12% from last month</p>
                </div>
                <div class="bg-white border p-4 rounded-md">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-medium text-gray-900">Active Students</span>
                        <i class="fas fa-user-graduate h-4 w-4 text-gray-500"></i>
                    </div>
                    <div class="mt-2 text-2xl font-bold text-gray-900">78</div>
                    <p class="text-xs text-gray-500">+4% from last month</p>
                </div>
                <div class="bg-white border p-4 rounded-md">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-medium text-gray-900">Available Vehicles</span>
                        <i class="fas fa-car h-4 w-4 text-gray-500"></i>
                    </div>
                    <div class="mt-2 text-2xl font-bold text-gray-900">12</div>
                    <p class="text-xs text-gray-500">+2 new vehicles added</p>
                </div>
                <div class="bg-white border p-4 rounded-md">
                    <div class="flex justify-between items-center">
                        <span class="text-sm font-medium text-gray-900">Instructors</span>
                        <i class="fas fa-chalkboard-teacher h-4 w-4 text-gray-500"></i>
                    </div>
                    <div class="mt-2 text-2xl font-bold text-gray-900">8</div>
                    <p class="text-xs text-gray-500">All instructors available</p>
                </div>
            </div>




            <!-- Appointments Table -->
            <div class="space-y-4">
                <div class="flex flex-col md:flex-row justify-between items-start gap-4">
                    <h2 class="text-xl font-semibold text-gray-900 dark:text-white">Recent Appointments</h2>
                    <div class="flex gap-4 w-full md:w-auto">
                        <div class="relative w-full md:w-64">
                            <i class="fas fa-search absolute left-2.5 top-2.5 h-4 w-4 text-gray-400 dark:text-gray-500"></i>
                            <input type="search" id="appointmentSearch" placeholder="Search appointments..."
                                class="pl-8 pr-8 w-full bg-gray-50 border rounded-md dark:bg-gray-700 dark:border-gray-600 dark:text-white focus:border-blue-500 focus:ring-1 focus:ring-blue-500" />
                            <button id="clearSearch" class="absolute right-2.5 top-2.5 h-4 w-4 text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300" style="display: none;">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="bg-white border rounded-md dark:bg-gray-700 dark:border-gray-600">
                    <table class="min-w-full table-auto" id="appointmentsTable">
                        <thead>
                        <tr class="bg-gray-100 dark:bg-gray-800">
                            <th class="px-4 py-2 text-left text-sm text-gray-900 dark:text-white">ID</th>
                            <th class="px-4 py-2 text-left text-sm text-gray-900 dark:text-white">Student</th>
                            <th class="px-4 py-2 text-left text-sm text-gray-900 dark:text-white">Vehicle</th>
                            <th class="px-4 py-2 text-left text-sm text-gray-900 dark:text-white">Instructor</th>
                            <th class="px-4 py-2 text-left text-sm text-gray-900 dark:text-white">Date</th>
                            <th class="px-4 py-2 text-left text-sm text-gray-900 dark:text-white">Time</th>
                            <th class="px-4 py-2 text-center text-sm text-gray-900 dark:text-white">Status</th>
                            <th class="px-4 py-2 text-right text-sm text-gray-900 dark:text-white">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            // Using an iterator to iterate over the queue
                            if (!allBookings.isEmpty()) {
                                Iterator<String[]> iterator = allBookings.iterator();
                                while (iterator.hasNext()) {
                                    String[] appointment = iterator.next();
                                    String bookingId = appointment[0];
                                    String lessonName = appointment[1];
                                    String vehicleType = appointment[3];
                                    String instructor = appointment[4];
                                    String date = appointment[5];
                                    String time = appointment[6]; // Fixed: Use index 6 for time
                                    String flagged = appointment.length >= 8 ? appointment[7] : "0";
                                    boolean isFlagged = "1".equals(flagged);
                        %>
                        <tr class="<%= isFlagged ? "bg-yellow-50 text-black" : "text-gray-900 dark:text-white" %>">
                            <td class="px-4 py-2"><%= bookingId %></td>
                            <td class="px-4 py-2"><%= lessonName %></td>
                            <td class="px-4 py-2"><%= vehicleType %></td>
                            <td class="px-4 py-2"><%= instructor %></td>
                            <td class="px-4 py-2"><%= date %></td>
                            <td class="px-4 py-2"><%= time %></td>
                            <td class="px-4 py-2 text-center">
                                <% if (isFlagged) { %>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-black">
                                        <i class="fas fa-flag mr-1"></i> Flagged
                                    </span>
                                <% } else { %>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                        <i class="fas fa-check mr-1"></i> Normal
                                    </span>
                                <% } %>
                            </td>
                            <td class="px-4 py-2 text-right">
                                <div class="flex justify-end space-x-2">
                                    <button onclick="openEditModal('<%= bookingId %>')" class="text-sm text-blue-500 dark:text-blue-400 hover:text-blue-700">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button onclick="toggleFlag('<%= bookingId %>')" class="text-sm <%= isFlagged ? "text-black hover:text-gray-700" : "text-gray-500 hover:text-gray-700" %>">
                                        <i class="fas fa-flag"></i>
                                    </button>
                                    <button onclick="confirmDelete('<%= bookingId %>')" class="text-sm text-red-500 dark:text-red-400 hover:text-red-700">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="8" class="text-center py-4 text-gray-600 dark:text-gray-400">No appointments available.</td></tr>
                        <%
                            }
                        %>
                        </tbody>

                    </table>
                </div>
            </div>

        </main>
    </div>
</div>

</body>
</html>
