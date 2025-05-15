<%@ page import="com.auth.UserUtils" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="userprofile.css">
</head>
<body>

<%
    // Retrieve user session details
    HttpSession session1 = request.getSession();
    String userEmail = (String) session1.getAttribute("user");
    String username = (String) session1.getAttribute("username");

    String formattedDate = "N/A";

    if (userEmail != null) {
        // File path for user details
        String userFilePath = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\userdetails.txt";

        // Fetch user details
        String[] userDetails = UserUtils.getUserDetails(userEmail, userFilePath);

        if (userDetails != null) {
            String rawDate = userDetails[4];
            if (rawDate != null && !rawDate.isEmpty()) {
                try {
                    LocalDateTime joinedDate = LocalDateTime.parse(rawDate);
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy hh:mm a");
                    formattedDate = joinedDate.format(formatter);
                } catch (Exception e) {
                    formattedDate = "Invalid Date";
                }
            }
%>

<div class="profile-container">
    <div class="profile-sidebar">
        <label for="uploadPic" class="profile-pic-box">
            <img src="<%= userDetails[5] %>" alt="Profile Picture" class="profile-pic" id="profileImage">
            <input type="file" id="uploadPic" accept="image/*" hidden>
            <i class="fa fa-camera upload-icon"></i>
        </label>
        <h2 id="userName"><%= username %></h2>
        <p class="username-detail">Change Profile Picture</p>
        <a style="color: #2c3e50; font-weight: 500; text-decoration: none;" href="../Home%20page/homepage.jsp">Back</a>
    </div>

    <div class="profile-content">
        <h2>Profile Information</h2>
        <div class="info-box">
            <p><i class="fa fa-envelope"></i> <%= userDetails[0] %></p>
            <p><i class="fa-solid fa-phone"></i> Phone: <%= userDetails[2] %></p>
            <p><i class="fa-solid fa-map-marker-alt"></i> Location: <%= userDetails[3] %></p>
            <p><i class="fa-solid fa-calendar"></i> Joined: <%= formattedDate %></p>
        </div>

        <h2>Booked Lessons</h2>
        <div class="lessons-container" style="max-height: 300px; overflow-y: auto;">
            <ul id="lessonsList">
                <%
                    String bookingsFilePath = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\auth\\bookings.txt";
                    List<String[]> bookings = UserUtils.getBookings(userEmail, bookingsFilePath);

                    if (bookings.isEmpty()) {
                %>
                <li>No bookings found</li>
                <%
                } else {
                    for (String[] booking : bookings) {
                        String bookingId = booking[0];    // Booking ID
                        String date = booking[4];         // Date
                        String time = booking[5];         // Time
                        String instructor = booking[4];   // Instructor
                        String vehicleType = booking[3];  // Vehicle Type
                %>
                <li>
                    <strong>Vehicle:</strong> <%= vehicleType %>
                    <strong>Date:</strong> <%= date %> <br>
                    <strong>Time:</strong> <%= time %> <br>
                    <strong>Instructor:</strong> <%= instructor %> <br>
                    <form action="../delete" method="post" style="display:inline;">
                        <input type="hidden" name="bookingId" value="<%= bookingId %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </li>
                <%
                        }
                    }
                %>
            </ul>
        </div>

    </div>
</div>

<%
} else {
%>
<p>User details not found!</p>
<%
    }
} else {
%>
<p>Please log in to view your profile.</p>
<%
    }
%>

<script src="userprofile.js"></script>
</body>
</html>
