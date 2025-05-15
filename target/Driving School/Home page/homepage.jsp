<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driving School - Home</title>
    <link rel="stylesheet" href="homepage.css">
    <link rel="stylesheet" href="userrating.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        /* Floating Inquiry Button */
        .floating-inquiry-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background-color: #f1c40f;
            color: #2c3e50;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            cursor: pointer;
            z-index: 999;
            transition: all 0.3s ease;
        }

        .floating-inquiry-btn:hover {
            transform: scale(1.1);
            background-color: #e67e22;
        }

        /* Inquiry Overlay */
        .inquiry-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .inquiry-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .inquiry-form-container {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            position: relative;
            transform: translateY(50px);
            transition: all 0.4s ease;
        }

        .inquiry-overlay.active .inquiry-form-container {
            transform: translateY(0);
        }

        .inquiry-form-container h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .inquiry-form-container .close-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 24px;
            color: #7f8c8d;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .inquiry-form-container .close-btn:hover {
            color: #e74c3c;
        }

        .inquiry-form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #2c3e50;
            font-weight: 500;
            text-align: left;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .submit-btn {
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background-color: #1a252f;
        }

        .form-message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            display: none;
        }

        .form-message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .form-message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<header>
    <nav style="height: 70px; letter-spacing: 1px;" class="navbar">
        <div class="logo">Driving School</div>
        <ul class="nav-links">
            <li><a href="../Home page/homepage.jsp">Home</a></li>
            <li><a href="../Courses%20page/courses.jsp">Courses</a></li>
            <li><a href="../services.jsp">Services</a></li>
            <li><a href="../Pricing/pricing.jsp">Pricing</a></li>
            <li><a href="../About%20Us/aboutus.jsp">About us</a></li>
            <li>
                <div class="profile-container">
                    <a href="../user-profile.jsp">
                        <img src="../Login/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png" alt="User Profile" class="profile-pic">
                    </a>
                </div>
            </li>
            <li>
                <%
                    String userEmail = (String) session.getAttribute("user");
                    if (userEmail != null) { %>
                <a href="../logout" class="login-btn">Logout</a>
                <% } else { %>
                <a href="../Login/login.jsp" class="login-btn">Login</a>
                <% } %>
            </li>
        </ul>
    </nav>
</header>

<section class="hero">
    <div class="hero-content">
        <h1>Learn to Drive with Confidence</h1>
        <p>Join our driving school and get the best training from professionals.</p>
        <a href="../Get%20Start/getstart.jsp" class="btn primary-btn">Get Started</a>
    </div>
</section>

<section class="courses">
    <h2>Our Courses</h2>
    <div class="course-container">
        <div class="course-card">
            <h3>Beginner Driving Course</h3>
            <p>Perfect for new learners with no prior experience.</p>
        </div>
        <div class="course-card">
            <h3>Advanced Driving Course</h3>
            <p>Enhance your driving skills and learn defensive driving.</p>
        </div>
        <div class="course-card">
            <h3>Test Preparation</h3>
            <p>Get ready for your driving test with confidence.</p>
        </div>
    </div>
</section>

<!-- User Rating Section -->
<section class="testimonials-section">
    <h2>Our Learners Say...</h2>
    <p>Real feedback from our satisfied learners.</p>
    <div class="testimonial-slider">
        <button class="prev-btn">&#10094;</button>
        <div class="testimonial-container">
            <div class="testimonial-card active">
                <img src="IMG-20250223-WA0062.jpg" alt="Learner 1" class="learner_dp">
                <h3>Parami Sadupama</h3>
                <p>⭐⭐⭐⭐⭐</p>
                <p>Great experience! Highly recommend.</p>
            </div>
            <div class="testimonial-card">
                <img src="./IMG-20250223-WA0062.jpg" alt="Learner 2" class="learner_dp">
                <h3>John Doe</h3>
                <p>⭐⭐⭐⭐⭐</p>
                <p>Very professional and friendly instructors.</p>
            </div>
            <div class="testimonial-card">
                <img src="./IMG-20250223-WA0062.jpg" alt="Learner 3" class="learner_dp">
                <h3>Mary Jane</h3>
                <p>⭐⭐⭐⭐⭐</p>
                <p>Helped me pass my driving test with ease.</p>
            </div>
        </div>
        <button class="next-btn">&#10095;</button>
    </div>
</section>

<section class="instructor-info">
    <h2>Who Teaches You to Drive?</h2>
    <div class="info-container">
        <div class="info-box">
            <span class="icon">⭐</span>
            <h3>Instructor Ratings</h3>
            <p>Access peer reviews & find top-rated instructors.</p>
        </div>
        <div class="info-box">
            <span class="icon">✅</span>
            <h3>Accredited</h3>
            <p>We verify instructor credentials for quality teaching.</p>
        </div>
        <div class="info-box">
            <span class="icon">🚗</span>
            <h3>Vehicle Safety</h3>
            <p>Access to modern, well-maintained training vehicles.</p>
        </div>
        <div class="info-box">
            <span class="icon">🔄</span>
            <h3>Always Your Choice</h3>
            <p>Switch instructors anytime, no questions asked.</p>
        </div>
    </div>
</section>


<!-- Floating Inquiry Button -->
<div class="floating-inquiry-btn" id="inquiryBtn" onclick="document.getElementById('inquiryOverlay').classList.add('active'); document.body.style.overflow='hidden';">
    <i class="fas fa-question"></i>
</div>

<!-- Inquiry Form Overlay -->
<div class="inquiry-overlay" id="inquiryOverlay" onclick="if(event.target === this) { this.classList.remove('active'); document.body.style.overflow=''; }">
    <div class="inquiry-form-container">
        <span class="close-btn" id="closeInquiry" onclick="document.getElementById('inquiryOverlay').classList.remove('active'); document.body.style.overflow='';">&times;</span>
        <h2>Send Us an Inquiry</h2>
        <form id="inquiryForm" class="inquiry-form" action="../inquiry" method="post">
            <div class="form-group">
                <label for="name">Name *</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone (Optional)</label>
                <input type="tel" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="subject">Subject</label>
                <select id="subject" name="subject">
                    <option value="General Inquiry">General Inquiry</option>
                    <option value="Course Information">Course Information</option>
                    <option value="Pricing">Pricing</option>
                    <option value="Scheduling">Scheduling</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="message">Message *</label>
                <textarea id="message" name="message" required></textarea>
            </div>
            <button type="submit" class="submit-btn">Submit Inquiry</button>
            <div id="formMessage" class="form-message"></div>
        </form>
    </div>
</div>

<footer>
    <p>&copy; 2025 Driving School. All Rights Reserved.</p>
</footer>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        console.log("DOM fully loaded");

        // Testimonial slider functionality
        const testimonials = document.querySelectorAll(".testimonial-card");
        const prevBtn = document.querySelector(".prev-btn");
        const nextBtn = document.querySelector(".next-btn");
        let index = 0;

        function showTestimonial(i) {
            testimonials.forEach((testimonial, idx) => {
                testimonial.classList.remove("active");
                if (idx === i) {
                    testimonial.classList.add("active");
                }
            });
        }

        if (prevBtn && nextBtn) {
            prevBtn.addEventListener("click", function () {
                index = (index === 0) ? testimonials.length - 1 : index - 1;
                showTestimonial(index);
            });

            nextBtn.addEventListener("click", function () {
                index = (index === testimonials.length - 1) ? 0 : index + 1;
                showTestimonial(index);
            });

            showTestimonial(index);
        }

        // Intersection Observer for scroll animations
        const observerOptions = {
            root: null,
            threshold: 0.2,
        };

        function handleIntersection(entries, observer) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = 1;
                    entry.target.style.transform = "translateX(0)";
                    observer.unobserve(entry.target);
                }
            });
        }

        const observer = new IntersectionObserver(handleIntersection, observerOptions);

        // Observe elements for scrolling animations
        document.querySelectorAll(".courses, .instructor-info").forEach(section => {
            observer.observe(section);
        });

        document.querySelectorAll(".course-card").forEach((card, i) => {
            setTimeout(() => {
                observer.observe(card);
            }, i * 300);
        });

        // Inquiry Form Functionality
        const inquiryBtn = document.getElementById("inquiryBtn");
        const inquiryOverlay = document.getElementById("inquiryOverlay");
        const closeInquiry = document.getElementById("closeInquiry");
        const inquiryForm = document.getElementById("inquiryForm");
        const formMessage = document.getElementById("formMessage");

        console.log("Inquiry button:", inquiryBtn);
        console.log("Inquiry overlay:", inquiryOverlay);

        // Open inquiry form
        if (inquiryBtn) {
            inquiryBtn.addEventListener("click", function() {
                console.log("Inquiry button clicked");
                inquiryOverlay.classList.add("active");
                document.body.style.overflow = "hidden"; // Prevent scrolling when overlay is open
            });
        }

        // Close inquiry form
        if (closeInquiry) {
            closeInquiry.addEventListener("click", function() {
                console.log("Close button clicked");
                inquiryOverlay.classList.remove("active");
                document.body.style.overflow = ""; // Re-enable scrolling
            });
        }

        // Close overlay when clicking outside the form
        if (inquiryOverlay) {
            inquiryOverlay.addEventListener("click", function(e) {
                if (e.target === inquiryOverlay) {
                    console.log("Clicked outside form");
                    inquiryOverlay.classList.remove("active");
                    document.body.style.overflow = ""; // Re-enable scrolling
                }
            });
        }

        // Handle form submission
        if (inquiryForm) {
            inquiryForm.addEventListener("submit", function(e) {
                console.log("Form submitted");
                // Don't prevent default - allow form to submit normally if fetch fails
                // This provides a fallback method

                // Show loading state
                const submitBtn = inquiryForm.querySelector(".submit-btn");
                submitBtn.textContent = "Submitting...";
                submitBtn.disabled = true;

                console.log("Form submitted, attempting to send via fetch API");

                // Try to submit via fetch first
                try {
                    // Get form data
                    const formData = new FormData(inquiryForm);

                    // Send form data to server
                    fetch("../inquiry", {
                        method: "POST",
                        headers: {
                            'X-Requested-With': 'XMLHttpRequest'
                        },
                        body: formData
                    })
                    .then(response => {
                        console.log("Response received:", response);
                        return response.json();
                    })
                    .then(data => {
                        console.log("Data received:", data);

                        // Reset button
                        submitBtn.textContent = "Submit Inquiry";
                        submitBtn.disabled = false;

                        // Show message
                        formMessage.textContent = data.message;
                        formMessage.className = "form-message " + (data.success ? "success" : "error");
                        formMessage.style.display = "block";

                        // If successful, reset form
                        if (data.success) {
                            inquiryForm.reset();

                            // Close overlay after 3 seconds
                            setTimeout(() => {
                                inquiryOverlay.classList.remove("active");
                                document.body.style.overflow = ""; // Re-enable scrolling
                                formMessage.style.display = "none";
                            }, 3000);
                        }

                        // Prevent the default form submission since we handled it via fetch
                        e.preventDefault();
                    })
                    .catch(error => {
                        console.error("Error in fetch:", error);
                        // Let the form submit normally as fallback
                        console.log("Falling back to normal form submission");
                        return true; // Allow form to submit normally
                    });
                } catch (error) {
                    console.error("Error in try/catch:", error);
                    // Let the form submit normally as fallback
                    console.log("Falling back to normal form submission due to exception");
                    return true; // Allow form to submit normally
                }
            });
        }
    });
</script>
</body>
</html>
