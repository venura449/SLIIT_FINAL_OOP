<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lessons Page</title>
  <link rel="stylesheet" href="motorcycles-manual-transmission.css">
</head>
<body>
  <header style="width: 100%;">
    <nav  style="height: 100px;"  class="navbar">
        <div class="logo">Driving School</div>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/Home%20page/homepage.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/Courses%20page/courses.jsp">Courses</a></li>
            <li><a href="${pageContext.request.contextPath}/Pricing/pricing.jsp">Pricing</a></li>
            <li><a href="${pageContext.request.contextPath}/About%20Us/aboutus.jsp">About us</a></li>
            <li>
                <div class="profile-container">
                    <a href="${pageContext.request.contextPath}/User%20Profile/userprofile.jsp">
                        <img src="/Login/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png" alt="User Profile" class="profile-pic">
                    </a>
                </div>
            </li>
            <li><a href="${pageContext.request.contextPath}/Login/login.jsp" class="login-btn">Login</a></li>
        </ul>
    </nav>
</header>
  <div class="container" id="container">
    <div class="form-container lesson-list">
      <h1>Available Lessons</h1>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 1</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 2</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 3</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 4</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 5</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 6</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 7</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 8</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 9</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

      <div class="lesson-container">
        <div class="lesson-text">Lesson 10</div>
        <a href="${pageContext.request.contextPath}/Booking%20Page/bookingpage.jsp"><button class="enroll-button">Book Now</button></a>
      </div>

    </div>
  </div>
</body>
</html>
