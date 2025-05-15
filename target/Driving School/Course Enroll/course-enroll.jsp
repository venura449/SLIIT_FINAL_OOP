<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manual Enrollment - Light Vehicles</title>
    <link rel="stylesheet" href="course-enroll.css">
</head>
<body>
    <div class="enrollment-container">
        <h1>Enrollment Successful!</h1>
        <p>Thank you for enrolling in the <strong>Manual Light Vehicles Course</strong>. Get ready to start your driving journey.</p>
        <p>Our team will contact you soon with further details.</p>
        <a href="../Home%20page/homepage.jsp" class="back-btn">Back to Home</a>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const container = document.querySelector(".enrollment-container");
            container.style.opacity = "0";
            container.style.transform = "translateY(-20px)";
            setTimeout(() => {
                container.style.transition = "opacity 0.8s ease, transform 0.8s ease";
                container.style.opacity = "1";
                container.style.transform = "translateY(0)";
            }, 200);
        });
    </script>
</body>
</html>
