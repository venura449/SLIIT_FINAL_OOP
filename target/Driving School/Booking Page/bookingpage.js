document.addEventListener("DOMContentLoaded", function () {
    const bookingForm = document.getElementById("bookingForm");

    bookingForm.addEventListener("submit", function (event) {
        event.preventDefault();

        const name = document.getElementById("name").value;
        const email = document.getElementById("email").value;
        const date = document.getElementById("date").value;
        const time = document.getElementById("time").value;
        const instructor = document.getElementById("instructor").value;

        if (name && email && date && time && instructor) {
            alert(`Booking confirmed!\n\nName: ${name}\nEmail: ${email}\nDate: ${date}\nTime: ${time}\nInstructor: ${instructor}`);
            bookingForm.reset();
        } else {
            alert("Please fill in all fields.");
        }
    });

    // Fade-in effect on scroll
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = 1;
                entry.target.style.transform = "translateY(0)";
            }
        });
    }, { threshold: 0.2 });

    document.querySelectorAll('.booking-form').forEach(section => {
        observer.observe(section);
    });
});
