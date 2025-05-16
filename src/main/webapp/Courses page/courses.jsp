<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driving School - Courses</title>
    <link rel="stylesheet" href="courses.css">
</head>
<body>
    <header style="width: 100%;">
        <nav  style="height: 70px; letter-spacing: 1px;"  class="navbar">
            <div class="logo">Driving School</div>
            <ul class="nav-links">
                <li><a href="../Home%20page/homepage.jsp">Home</a></li>
                <li><a href="../Courses page/courses.jsp">Courses</a></li>
                <li><a href="../Pricing/pricing.jsp">Pricing</a></li>
                <li><a href="../About%20Us/aboutus.jsp">About us</a></li>
                <li>
                    <div class="profile-container">
                        <a href="../User%20Profile/userprofile.jsp">
                            <img src="../Login/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png" alt="User Profile" class="profile-pic">
                        </a>
                    </div>
                </li>
                <li><a href="../Login/login.jsp" class="login-btn">Login</a></li>
            </ul>
        </nav>
    </header>
    <!-- Courses Section -->
    <section class="courses-section">
        <div class="container">
            <h2 class="section-title">Our Driving Courses</h2>
            <div class="courses-grid">
                
                <!-- Course 1 -->
                <div class="course-card"> 
                    <img src="Basic Driving Course.png" alt="Basic Driving Course">
                    <h3>Light Vehicles</h3>
                    <p>Perfect for beginners! Learn the fundamentals of safe driving.</p>
                    <a href="../Courses/Light%20Vahicals/lightvahicals.jsp"><button class="enroll-btn">Enroll Now</button></a>
                </div>

                <!-- Course 2 -->
                <div class="course-card">
                    <img src="Advanced Driving Course.png" alt="Advanced Driving Course">
                    <h3>Medium Vehicles</h3>
                    <p>Enhance your driving skills with advanced techniques and safety measures.</p>
                    <a href="../Courses/Medium%20Vehicles/medium-vehicles.jsp"><button class="enroll-btn">Enroll Now</button></a>
                </div>

                <!-- Course 3 -->
                <div class="course-card">
                    <img src="Highway Driving Course.png" alt="Highway Driving Course">
                    <h3>Heavy Vehicles</h3>
                    <p>Master high-speed driving and learn highway safety rules.</p>
                    <a href="../Courses/Heavy%20Vehicles/heavy-vehicles.jsp"><button class="enroll-btn">Enroll Now</button></a>
                </div>

                <!-- Course 4 -->
                <div class="course-card">
                    <img src="DALL·E 2025-03-17 17.12.02 - A visually engaging illustration of a defensive driving course. The scen.webp" alt="Defensive Driving Course">
                    <h3>Motorcycles</h3>
                    <p>Learn how to drive safely in challenging conditions.</p>
                    <a href="../Courses/Motorcycles/motorcycles.jsp"><button class="enroll-btn" > Enroll Now</button></a>
                </div>

                 <!-- Course 5 -->
                 <div class="course-card"> 
                    <img src="Basic Driving Course.png" alt="Basic Driving Course">
                    <h3>Three Wheelers</h3>
                    <p>Perfect for beginners! Learn the fundamentals of safe driving.</p>
                    <a href="../Courses/Three%20Wheelers/Three%20Wheelers%20Manual%20Transmission/threewheelers-manual-transmission.jsp"><button class="enroll-btn" > Enroll Now</button></a>
                </div>

            </div>
        </div>
    </section>

    <script src="courses.js"></script>  

</body>
</html>
