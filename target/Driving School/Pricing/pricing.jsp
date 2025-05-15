<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="pricing.css">
    <title>Pricing Page</title>
</head>

<body>
    <header style="width: 100%;">
        <nav  style="height: 100px;"  class="navbar">
            <div class="logo">Driving School</div>
            <ul class="nav-links">
                <li><a href="../Home%20page/homepage.jsp">Home</a></li>
                <li><a href="../Courses%20page/courses.jsp">Courses</a></li>
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
    <div class="container" id="container">
        <!-- Pricing Section -->
        <div class="pricing-container">
            <h1>Choose Your Plan</h1>
            <div class="pricing-cards">
                <div class="card">
                    <h2>Basic</h2>
                    <div class="price">Rs.20,000</div>
                    <button>Choose Plan</button>
                </div>
                <div class="card featured">
                    <h2>Premium</h2>
                    <div class="price">Rs.35,000</div>
                    <button>Choose Plan</button>
                </div>
                <div class="card">
                    <h2>Pro</h2>
                    <div class="price">Rs.50,000</div>
                    <button>Choose Plan</button>
                </div>
                <div class="card">
                    <h2>Pro</h2>
                    <div class="price">Rs.50,000</div>
                    <button>Choose Plan</button>
                </div>
                <div class="card">
                    <h2>Pro</h2>
                    <div class="price">Rs.50,000</div>
                    <button>Choose Plan</button>
                </div>
            </div>

            <!-- Plan Descriptions -->
            <div class="plan-descriptions">
                <div class="description">
                    <h3>Basic</h3>
                    <p>This plan includes basic access to all the essential driving lessons, including theory and practice sessions. Perfect for beginners.</p>
                </div>
                <div class="description">
                    <h3>Premium</h3>
                    <p>Get everything in the Basic plan, plus additional advanced lessons and personalized instructor support. Ideal for more committed learners.</p>
                </div>
                <div class="description">
                    <h3>Pro</h3>
                    <p>Enjoy all features from the Premium plan with the addition of unlimited lessons, priority scheduling, and exclusive driving courses for pro learners.</p>
                </div>
                <div class="description">
                    <h3>Pro</h3>
                    <p>Enjoy all features from the Premium plan with the addition of unlimited lessons, priority scheduling, and exclusive driving courses for pro learners.</p>
                </div>
                <div class="description">
                    <h3>Pro</h3>
                    <p>Enjoy all features from the Premium plan with the addition of unlimited lessons, priority scheduling, and exclusive driving courses for pro learners.</p>
                </div>
            </div>
        </div>

        <!-- Toggle Sign Up and Login -->
        <div class="toggle-container">
            <div class="toggle-panel toggle-left">
                <h1>Welcome Back!</h1>
                <p>Enter your personal details to use all of site features</p>
                <button class="hidden" id="login">Sign In</button>
            </div>
            <div class="toggle-panel toggle-right">
                <h1>Hello, Friend!</h1>
                <p>Register with your personal details to use all of site features</p>
                <button class="hidden" id="register">Sign Up</button>
            </div>
        </div>
    </div>

    <script src="pricing.js"></script>
</body>

</html>
