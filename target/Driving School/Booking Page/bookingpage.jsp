<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession();
    String user = (String) session1.getAttribute("user"); // Fetch user session
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driving School - Booking</title>
    <link rel="stylesheet" href="bookingpage.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
<header>
    <nav style="height: 70px; letter-spacing: 1px;" class="navbar">
        <div class="logo">Driving School</div>
        <ul class="nav-links">
            <li><a href="../Home%20page/homepage.jsp">Home</a></li>
            <li><a href="../Courses%20page/courses.jsp">Courses</a></li>
            <li><a href="../Pricing/pricing.jsp">Pricing</a></li>
            <li><a href="../About%20Us/aboutus.jsp">About us</a></li>
            <li>
                <div class="profile-container">
                    <a href="../User%20Profile/userprofile.jsp">
                        <img src="../Login/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png"
                             alt="User Profile" class="profile-pic">
                    </a>
                </div>
            </li>
            <% if (user != null) { %>
            <!-- If user is logged in, show logout button -->
            <li><a href="../logout" class="login-btn">Logout</a></li>
            <% } else { %>
            <!-- If user is not logged in, show login button -->
            <li><a href="../Login/login.jsp" class="login-btn">Login</a></li>
            <% } %>
        </ul>
    </nav>
</header>

<section class="booking-hero">
    <div class="hero-content">
        <h1>Book Your Driving Lesson</h1>
        <p>Select your preferred time and instructor.</p>
    </div>
</section>

<section class="booking-form">
    <h2>Schedule Your Lesson</h2>
    <form id="bookingForm" action="../add" method="post">
        <label for="name">Full Name</label>
        <input type="text" name="name" id="name" required>

        <label for="email">Email</label>
        <input type="email" name="email" id="email" value="<%= user != null ? user : "" %>" required>

        <label for="date">Select Date</label>
        <input type="date" name="date" id="date" required>

        <label for="time">Select Time</label>
        <input type="time" name="time" id="time" required>

        <label for="instructor">Choose Instructor</label>
        <select name="instructor" id="instructor">
            <option value="John Doe">John Doe</option>
            <option value="Jane Smith">Jane Smith</option>
            <option value="Michael Brown">Michael Brown</option>
        </select>

        <!-- Added Vehicle Type Dropdown -->
        <label for="vehicle">Choose Vehicle Type</label>
        <select name="vehicle" id="vehicle" required>
            <option value="Sedan">Sedan</option>
            <option value="SUV">SUV</option>
            <option value="Truck">Truck</option>
            <option value="Motorbike">Motorbike</option>
        </select>

        <button type="submit" class="btn primary-btn">Confirm Booking</button>
    </form>
</section>

<footer>
    <p>&copy; 2025 Driving School. All Rights Reserved.</p>
</footer>

</body>
</html>
