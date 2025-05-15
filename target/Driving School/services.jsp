<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services - Driving School</title>
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
        
        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
        }
        
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .logo {
            font-size: 24px;
            font-weight: 600;
        }
        
        .nav-links {
            display: flex;
            list-style: none;
            gap: 20px;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .nav-links a:hover {
            color: #f1c40f;
        }
        
        .login-btn {
            background-color: #f1c40f;
            color: #2c3e50 !important;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: 600;
        }
        
        .profile-container {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            overflow: hidden;
        }
        
        .profile-pic {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .page-title {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .page-title h1 {
            font-size: 36px;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .page-title p {
            color: #7f8c8d;
            font-size: 16px;
        }
        
        .services-filter {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 8px 16px;
            border: none;
            background-color: #ecf0f1;
            color: #2c3e50;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .filter-btn:hover, .filter-btn.active {
            background-color: #2c3e50;
            color: white;
        }
        
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .service-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .service-header {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            position: relative;
        }
        
        .service-header h3 {
            font-size: 18px;
            margin-bottom: 5px;
        }
        
        .service-category {
            display: inline-block;
            padding: 2px 8px;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 4px;
            font-size: 12px;
            margin-bottom: 5px;
        }
        
        .service-price {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 20px;
            font-weight: 600;
        }
        
        .service-body {
            padding: 20px;
        }
        
        .service-description {
            color: #555;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .service-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        
        .service-duration {
            display: flex;
            align-items: center;
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .service-duration i {
            margin-right: 5px;
        }
        
        .book-btn {
            background-color: #f1c40f;
            color: #2c3e50;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .book-btn:hover {
            background-color: #e67e22;
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
        
        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }
        
        /* Category-specific colors */
        .service-card.Lessons .service-header {
            background-color: #3498db;
        }
        
        .service-card.Courses .service-header {
            background-color: #27ae60;
        }
        
        .service-card.Special .service-header {
            background-color: #e67e22;
        }
    </style>
</head>
<body>
    <%!
        // File path for services.txt
        private static final String SERVICES_FILE = "C:\\Users\\Venura\\Documents\\DrivingSchool\\DrivingSchool\\src\\main\\java\\com\\services\\services.txt";
        
        // Get all services from the file
        private List<String[]> getAllServices() {
            List<String[]> services = new ArrayList<>();
            
            File file = new File(SERVICES_FILE);
            if (!file.exists()) {
                return services;
            }
            
            try (BufferedReader reader = new BufferedReader(new FileReader(SERVICES_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 6) {
                        services.add(parts);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return services;
        }
    %>
    
    <header>
        <nav class="navbar">
            <div class="logo">Driving School</div>
            <ul class="nav-links">
                <li><a href="Home page/homepage.jsp">Home</a></li>
                <li><a href="Courses%20page/courses.jsp">Courses</a></li>
                <li><a href="services.jsp">Services</a></li>
                <li><a href="Pricing/pricing.jsp">Pricing</a></li>
                <li><a href="About%20Us/aboutus.jsp">About us</a></li>
                <li>
                    <div class="profile-container">
                        <a href="user-profile.jsp">
                            <img src="Login/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png" alt="User Profile" class="profile-pic">
                        </a>
                    </div>
                </li>
                <li>
                    <%
                        String userEmail = (String) session.getAttribute("user");
                        if (userEmail != null) { 
                    %>
                    <a href="logout" class="login-btn">Logout</a>
                    <% } else { %>
                    <a href="Login/login.jsp" class="login-btn">Login</a>
                    <% } %>
                </li>
            </ul>
        </nav>
    </header>
    
    <div class="container">
        <div class="page-title">
            <h1>Our Services</h1>
            <p>Explore our range of driving lessons and specialized services</p>
        </div>
        
        <div class="services-filter">
            <button class="filter-btn active" onclick="filterServices('all')">All Services</button>
            <button class="filter-btn" onclick="filterServices('Lessons')">Lessons</button>
            <button class="filter-btn" onclick="filterServices('Courses')">Courses</button>
            <button class="filter-btn" onclick="filterServices('Special')">Special</button>
        </div>
        
        <div class="services-grid">
            <% 
                List<String[]> services = getAllServices();
                
                if (services != null && !services.isEmpty()) {
                    for (String[] service : services) {
                        String id = service[0];
                        String name = service[1];
                        String description = service[2];
                        String price = service[3];
                        String duration = service[4];
                        String category = service[5];
            %>
            <div class="service-card <%= category %>" data-category="<%= category %>">
                <div class="service-header">
                    <span class="service-category"><%= category %></span>
                    <h3><%= name %></h3>
                    <span class="service-price">$<%= price %></span>
                </div>
                <div class="service-body">
                    <p class="service-description"><%= description %></p>
                    <div class="service-details">
                        <span class="service-duration"><i class="far fa-clock"></i> <%= duration %> minutes</span>
                        <a href="Booking%20Page/booking.jsp?service=<%= id %>" class="book-btn">Book Now</a>
                    </div>
                </div>
            </div>
            <% 
                    }
                } else { 
            %>
            <div class="empty-state">
                <i class="fas fa-concierge-bell"></i>
                <p>No services available at the moment. Please check back later.</p>
            </div>
            <% } %>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Driving School. All Rights Reserved.</p>
    </footer>
    
    <script>
        function filterServices(category) {
            // Update active button
            const buttons = document.querySelectorAll('.filter-btn');
            buttons.forEach(button => {
                button.classList.remove('active');
                if (button.textContent.includes(category === 'all' ? 'All' : category)) {
                    button.classList.add('active');
                }
            });
            
            // Filter services
            const services = document.querySelectorAll('.service-card');
            services.forEach(service => {
                if (category === 'all' || service.dataset.category === category) {
                    service.style.display = 'block';
                } else {
                    service.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>
